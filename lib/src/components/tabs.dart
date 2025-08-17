import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';

/// Radix-styled tabs with heading border and padded content.
class RadixTabs extends StatefulWidget {
  /// Tab pages to render.
  final List<RadixTab> tabs;

  /// Initial selected tab index. Defaults to 0.
  final int initialIndex;

  /// Padding applied inside each tab page.
  final EdgeInsetsGeometry contentPadding;

  /// Creates Radix tabs.
  const RadixTabs({super.key, required this.tabs, this.initialIndex = 0, this.contentPadding = const EdgeInsets.only(top: 16, bottom: 24)});

  @override
  State<RadixTabs> createState() => _RadixTabsState();
}

class _RadixTabsState extends State<RadixTabs> with TickerProviderStateMixin {
  late final TabController _controller = TabController(length: widget.tabs.length, vsync: this, initialIndex: widget.initialIndex);

  @override
  void didUpdateWidget(covariant RadixTabs oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tabs.length != widget.tabs.length) {
      _controller.dispose();
      // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
      // Recreate controller when tab count changes
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = RadixTheme.of(context);
    final c = t.colors;
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
            overlayColor: WidgetStatePropertyAll(c.accent.withValues(alpha: 0.06)),
            tabs: [for (final t in widget.tabs) Tab(text: t.label, icon: t.icon)],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _controller,
            children: [for (final t in widget.tabs) Padding(padding: widget.contentPadding, child: t.content)],
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

  /// Tab page widget displayed when selected.
  final Widget content;

  /// Optional leading icon for the tab.
  final Widget? icon;

  /// Creates a tab descriptor.
  const RadixTab({required this.label, required this.content, this.icon});
}
