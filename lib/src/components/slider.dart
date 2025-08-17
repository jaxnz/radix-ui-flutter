import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';

/// Radix-styled slider.
class RadixSlider extends StatelessWidget {
  /// Current value.
  final double value;

  /// Called when the slider value changes.
  final ValueChanged<double>? onChanged;

  /// Minimum value (inclusive). Defaults to 0.
  final double min;

  /// Maximum value (inclusive). Defaults to 100.
  final double max;

  /// Optional number of uniform discrete divisions.
  final int? divisions;

  /// Creates a Radix slider.
  const RadixSlider({super.key, required this.value, this.onChanged, this.min = 0, this.max = 100, this.divisions});

  @override
  Widget build(BuildContext context) {
    final c = RadixTheme.of(context).colors;
    return Slider(value: value, min: min, max: max, divisions: divisions, onChanged: onChanged, activeColor: c.accent, inactiveColor: c.border);
  }
}
