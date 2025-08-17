import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';

enum RadixBadgeVariant { solid, soft, outline }

class RadixBadge extends StatelessWidget {
  final String label;
  final RadixBadgeVariant variant;
  final Color? color;

  const RadixBadge({super.key, required this.label, this.variant = RadixBadgeVariant.soft, this.color});

  @override
  Widget build(BuildContext context) {
    final t = RadixTheme.of(context);
    final c = t.colors;
    final base = color ?? c.accent;

    Color bg;
    Color fg;
    BorderSide? border;

    switch (variant) {
      case RadixBadgeVariant.solid:
        bg = base;
        fg = c.accentText;
        border = BorderSide(color: base.withValues(alpha: 0.8));
        break;
      case RadixBadgeVariant.soft:
        bg = base.withValues(alpha: 0.12);
        fg = base;
        border = BorderSide(color: base.withValues(alpha: 0.24));
        break;
      case RadixBadgeVariant.outline:
        bg = Colors.transparent;
        fg = c.text;
        border = BorderSide(color: c.border);
        break;
    }

    return Container(
      decoration: ShapeDecoration(
        color: bg,
        shape: RoundedRectangleBorder(side: border, borderRadius: BorderRadius.circular(t.radius1)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(
        label,
        style: TextStyle(color: fg, fontWeight: FontWeight.w600),
      ),
    );
  }
}
