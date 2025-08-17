import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';

/// Vertical radio button group.
class RadixRadioGroup<T> extends StatelessWidget {
  /// Currently selected value.
  final T groupValue;

  /// List of options to display.
  final List<RadixRadioOption<T>> options;

  /// Called when the selection changes.
  final ValueChanged<T?>? onChanged;

  /// Creates a Radix radio group.
  const RadixRadioGroup({super.key, required this.groupValue, required this.options, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final t = RadixTheme.of(context);
    final c = t.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: options
          .map(
            (opt) => RadioListTile<T>(
              value: opt.value,
              groupValue: groupValue,
              onChanged: onChanged,
              title: Text(opt.label, style: TextStyle(color: c.text)),
              activeColor: c.accent,
            ),
          )
          .toList(),
    );
  }
}

/// Option descriptor for [RadixRadioGroup].
class RadixRadioOption<T> {
  /// Display label for the radio.
  final String label;

  /// Associated value.
  final T value;

  /// Creates a radio option.
  const RadixRadioOption({required this.label, required this.value});
}
