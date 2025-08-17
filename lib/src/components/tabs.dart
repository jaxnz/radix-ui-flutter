import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';

class RadixTabs extends StatefulWidget {
  final List<RadixTab> tabs;
  final int initialIndex;
  final EdgeInsetsGeometry contentPadding;
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

class RadixTab {
  final String label;
  final Widget content;
  final Widget? icon;
  const RadixTab({required this.label, required this.content, this.icon});
}
