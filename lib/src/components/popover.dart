import 'package:flutter/material.dart';

class RadixPopover extends StatefulWidget {
  final Widget anchor;
  final Widget content;
  final bool openOnTap;
  final bool barrierDismissible;

  const RadixPopover({
    super.key,
    required this.anchor,
    required this.content,
    this.openOnTap = true,
    this.barrierDismissible = true,
  });

  @override
  State<RadixPopover> createState() => _RadixPopoverState();
}

class _RadixPopoverState extends State<RadixPopover> {
  final LayerLink _link = LayerLink();
  OverlayEntry? _entry;

  void _show() {
    if (_entry != null) return;
    final overlay = Overlay.of(context);
    _entry = OverlayEntry(
      builder: (context) {
        // Basic flip: if near bottom, place above
        final size = MediaQuery.of(context).size;
        final anchorBox = context.findRenderObject() as RenderBox?;
        final anchorPos = anchorBox?.localToGlobal(Offset.zero) ?? Offset.zero;
        final isNearBottom = anchorPos.dy > size.height * 0.6;
        final offset = isNearBottom ? const Offset(0, -8) : const Offset(0, 8);
        return Stack(
          children: [
            if (widget.barrierDismissible)
              Positioned.fill(
                child: GestureDetector(
                  onTap: _hide,
                  behavior: HitTestBehavior.opaque,
                  child: const SizedBox.shrink(),
                ),
              ),
            CompositedTransformFollower(
              link: _link,
              showWhenUnlinked: false,
              offset: offset,
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(8),
                child: widget.content,
              ),
            ),
          ],
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
    return CompositedTransformTarget(
      link: _link,
      child: GestureDetector(onTap: widget.openOnTap ? _show : null, child: widget.anchor),
    );
  }
}
