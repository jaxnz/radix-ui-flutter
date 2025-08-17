import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';

/// Inline link styled with the theme accent color.
class RadixLink extends StatelessWidget {
  /// Link text.
  final String text;

  /// Tap callback. If null and [uri] is null, the link is inert.
  final VoidCallback? onTap;

  /// Optional destination URI (consumer can handle navigation).
  final Uri? uri;

  /// Extra text style merged over the default accent style.
  final TextStyle? style;

  /// Creates a Radix link.
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
