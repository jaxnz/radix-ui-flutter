import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';

enum RadixAlertVariant { info, success, warning, danger }

class RadixAlert extends StatelessWidget {
  final String title;
  final String? description;
  final RadixAlertVariant variant;
  final Widget? trailing;

  const RadixAlert({super.key, required this.title, this.description, this.variant = RadixAlertVariant.info, this.trailing});

  @override
  Widget build(BuildContext context) {
    final t = RadixTheme.of(context);
    final c = t.colors;
    Color fg = c.text;
    Color bg = c.subtleSurface;
    switch (variant) {
      case RadixAlertVariant.info:
        break;
      case RadixAlertVariant.success:
        fg = RadixTheme.of(context).colors.success;
        bg = fg.withValues(alpha: 0.12);
        break;
      case RadixAlertVariant.warning:
        fg = RadixTheme.of(context).colors.warning;
        bg = fg.withValues(alpha: 0.12);
        break;
      case RadixAlertVariant.danger:
        fg = RadixTheme.of(context).colors.danger;
        bg = fg.withValues(alpha: 0.12);
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(t.radius2),
        border: Border.all(color: fg.withValues(alpha: 0.24)),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: c.text, fontWeight: FontWeight.w700),
                ),
                if (description != null) ...[const SizedBox(height: 4), Text(description!, style: TextStyle(color: c.textSubtle))],
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
