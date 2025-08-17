import 'package:flutter/widgets.dart';
import '../theme/radix_theme.dart';

class RadixLabel extends StatelessWidget {
  final String text;
  final Widget? trailing;
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
