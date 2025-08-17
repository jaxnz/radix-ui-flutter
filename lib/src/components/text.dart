import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';

class RadixText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? align;
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

class RadixHeading extends StatelessWidget {
  final String text;
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
