import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';

class RadixLink extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final Uri? uri;
  final TextStyle? style;

  const RadixLink(this.text, {super.key, this.onTap, this.uri, this.style});

  @override
  Widget build(BuildContext context) {
    final c = RadixTheme.of(context).colors;
    final effective = TextStyle(color: c.accent, decoration: TextDecoration.underline).merge(style);
    return Text.rich(
      TextSpan(text: text, recognizer: onTap != null || uri != null ? (TapGestureRecognizer()..onTap = onTap) : null),
      style: effective,
    );
  }
}
