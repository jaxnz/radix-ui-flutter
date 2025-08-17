import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';

class RadixSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;
  final int? divisions;

  const RadixSlider({super.key, required this.value, this.onChanged, this.min = 0, this.max = 100, this.divisions});

  @override
  Widget build(BuildContext context) {
    final c = RadixTheme.of(context).colors;
    return Slider(value: value, min: min, max: max, divisions: divisions, onChanged: onChanged, activeColor: c.accent, inactiveColor: c.border);
  }
}
