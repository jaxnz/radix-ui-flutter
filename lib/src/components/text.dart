import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';

/// Body text with Radix semantic color and optional style overrides.
class RadixText extends StatelessWidget {
  /// Text content.
  final String text;

  /// Additional style merged over the base style.
  final TextStyle? style;

  /// Alignment of the text.
  final TextAlign? align;

  /// If provided, truncates and adds ellipsis after this number of lines.
  final int? maxLines;

  const RadixText(this.text, {super.key, this.style, this.align, this.maxLines});

  @override
  Widget build(BuildContext context) {
    final t = RadixTheme.of(context);
    final c = t.colors;
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines == null ? TextOverflow.visible : TextOverflow.ellipsis,
      style: TextStyle(color: c.text).merge(style),
    );
  }
}

/// Headline text sized by [level] (1..6) using Radix typography.
class RadixHeading extends StatelessWidget {
  /// Heading content.
  final String text;

  /// Heading level (1..6). Smaller number means larger text.
  final int level; // 1..6

  const RadixHeading(this.text, {super.key, this.level = 3});

  @override
  Widget build(BuildContext context) {
    final t = RadixTheme.of(context);
    final c = t.colors;
    final size = switch (level) {
      1 => 32.0,
      2 => 28.0,
      3 => 24.0,
      4 => 20.0,
      5 => 18.0,
      _ => 16.0,
    };
    final weight = level <= 3 ? FontWeight.w700 : FontWeight.w600;
    return Text(
      text,
      style: TextStyle(fontSize: size, fontWeight: weight, color: c.text),
    );
  }
}
