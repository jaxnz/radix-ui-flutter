import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';

class RadixProgress extends StatelessWidget {
  final double value; // 0..1
  final double height;

  const RadixProgress({super.key, required this.value, this.height = 8});

  @override
  Widget build(BuildContext context) {
    final t = RadixTheme.of(context);
    final c = t.colors;
    return ClipRRect(
      borderRadius: BorderRadius.circular(t.radius1),
      child: LinearProgressIndicator(value: value.clamp(0, 1), minHeight: height, backgroundColor: c.subtleSurface, color: c.accent),
    );
  }
}
