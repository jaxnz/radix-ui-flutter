import 'package:flutter/material.dart';

class RadixHoverCard extends StatefulWidget {
  final Widget anchor;
  final Widget content;
  const RadixHoverCard({super.key, required this.anchor, required this.content});

  @override
  State<RadixHoverCard> createState() => _RadixHoverCardState();
}

class _RadixHoverCardState extends State<RadixHoverCard> {
  OverlayEntry? _entry;
  final LayerLink _link = LayerLink();

  void _show() {
    if (_entry != null) return;
    final overlay = Overlay.of(context);
    _entry = OverlayEntry(
      builder: (_) {
        final size = MediaQuery.of(context).size;
        final anchorBox = context.findRenderObject() as RenderBox?;
        final anchorPos = anchorBox?.localToGlobal(Offset.zero) ?? Offset.zero;
        final isNearBottom = anchorPos.dy > size.height * 0.6;
        final offset = isNearBottom ? const Offset(0, -8) : const Offset(0, 8);
        return CompositedTransformFollower(
          link: _link,
          offset: offset,
          showWhenUnlinked: false,
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(8),
            child: widget.content,
          ),
        );
      },
    );
    overlay.insert(_entry!);
  }

  void _hide() {
    _entry?.remove();
    _entry = null;
  }

  @override
  void dispose() {
    _hide();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _show(),
      onExit: (_) => _hide(),
      child: CompositedTransformTarget(link: _link, child: widget.anchor),
    );
  }
}
