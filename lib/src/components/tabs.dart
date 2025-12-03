import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';

/// Radix-styled tabs with heading border and padded content.
class RadixTabs extends StatefulWidget {
  /// Tab triggers to render.
  final List<RadixTab> tabs;

  /// Tab page widgets displayed when selected. Must match [tabs] length if provided.
  final List<Widget>? children;

  /// Initial selected tab index. Defaults to 0.
  final int initialIndex;

  /// Padding applied inside each tab page.
  final EdgeInsetsGeometry contentPadding;

  /// Selection callback fired when a tab is tapped or the active tab changes.
  final ValueChanged<int>? onTap;

  /// Creates Radix tabs.
  RadixTabs({
    super.key,
    required this.tabs,
    this.children,
    this.initialIndex = 0,
    this.contentPadding = const EdgeInsets.only(top: 16, bottom: 24),
    this.onTap,
  })  : assert(
            children == null ||
                children.isEmpty ||
                tabs.length == children.length,
            'Tabs and children must have the same length when provided.'),
        assert(tabs.isNotEmpty, 'RadixTabs requires at least one tab.');

  @override
  State<RadixTabs> createState() => _RadixTabsState();
}

class _RadixTabsState extends State<RadixTabs> with TickerProviderStateMixin {
  late TabController _controller;
  int? _lastReportedIndex;

  @override
  void initState() {
    super.initState();
    _controller = _createController(widget.initialIndex);
    _controller.addListener(_handleIndexChanged);
    _lastReportedIndex = _controller.index;
  }

  TabController _createController(int index) {
    return TabController(
        length: widget.tabs.length,
        vsync: this,
        initialIndex: _clampIndex(index));
  }

  int _clampIndex(int index) => index.clamp(0, widget.tabs.length - 1).toInt();

  @override
  void didUpdateWidget(covariant RadixTabs oldWidget) {
    super.didUpdateWidget(oldWidget);
    final tabsChanged = oldWidget.tabs.length != widget.tabs.length;
    if (tabsChanged) {
      final newIndex = _clampIndex(_controller.index);
      _swapController(_createController(newIndex));
    } else if (oldWidget.initialIndex != widget.initialIndex &&
        widget.initialIndex != _controller.index) {
      _controller.animateTo(_clampIndex(widget.initialIndex));
    }
  }

  void _swapController(TabController controller) {
    _controller.removeListener(_handleIndexChanged);
    _controller.dispose();
    _controller = controller;
    _controller.addListener(_handleIndexChanged);
    _lastReportedIndex = _controller.index;
  }

  void _handleTabTap(int index) {
    if (widget.onTap == null) return;
    _lastReportedIndex = index;
    widget.onTap!(index);
  }

  void _handleIndexChanged() {
    if (widget.onTap == null ||
        _controller.indexIsChanging ||
        _controller.index == _lastReportedIndex) return;
    _lastReportedIndex = _controller.index;
    widget.onTap!(_controller.index);
  }

  @override
  void dispose() {
    _controller.removeListener(_handleIndexChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = RadixTheme.of(context);
    final c = t.colors;
    final children = widget.children;
    final hasContent = children != null && children.isNotEmpty;
    assert(
        !hasContent || children.length == widget.tabs.length,
        'When providing tab content, its length must match the number of tabs '
        '(${widget.tabs.length}).');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: c.border)),
          ),
          child: TabBar(
            controller: _controller,
            labelColor: c.text,
            indicatorColor: c.accent,
            indicatorSize: TabBarIndicatorSize.tab,
            overlayColor:
                WidgetStatePropertyAll(c.accent.withValues(alpha: 0.06)),
            onTap: widget.onTap == null ? null : _handleTabTap,
            tabs: [
              for (final t in widget.tabs) Tab(text: t.label, icon: t.icon)
            ],
          ),
        ),
        if (hasContent)
          Expanded(
            child: TabBarView(
              controller: _controller,
              children: [
                for (final child in children)
                  Padding(padding: widget.contentPadding, child: child)
              ],
            ),
          ),
      ],
    );
  }
}

/// A single tab configuration used by [RadixTabs].
class RadixTab {
  /// Tab label.
  final String label;

  /// Optional leading icon for the tab.
  final Widget? icon;

  /// Creates a tab descriptor.
  const RadixTab({required this.label, this.icon});
}
