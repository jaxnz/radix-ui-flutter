import 'package:flutter/widgets.dart';
import '../theme/radix_theme.dart';

/// Form label with optional [trailing] widget (e.g., help link).
class RadixLabel extends StatelessWidget {
  /// Label text.
  final String text;

  /// Optional widget displayed to the right.
  final Widget? trailing;

  /// Creates a Radix label.
  const RadixLabel(this.text, {super.key, this.trailing});

  @override
  Widget build(BuildContext context) {
    final c = RadixTheme.of(context).colors;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: TextStyle(color: c.text, fontWeight: FontWeight.w600),
        ),
        if (trailing != null) ...[const SizedBox(width: 6), trailing!],
      ],
    );
  }
}
