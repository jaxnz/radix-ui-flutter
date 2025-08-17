import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';

/// Linear progress bar styled for Radix.
class RadixProgress extends StatelessWidget {
  /// Progress in [0..1].
  final double value; // 0..1

  /// Height of the bar. Defaults to 8.
  final double height;

  /// Creates a Radix progress bar.
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
