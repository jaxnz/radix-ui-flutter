import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';

class RadixRadioGroup<T> extends StatelessWidget {
  final T groupValue;
  final List<RadixRadioOption<T>> options;
  final ValueChanged<T?>? onChanged;

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

class RadixRadioOption<T> {
  final String label;
  final T value;

  const RadixRadioOption({required this.label, required this.value});
}
