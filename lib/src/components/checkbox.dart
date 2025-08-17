import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';

class RadixCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final String? label;
  final bool tristate;

  const RadixCheckbox({super.key, required this.value, this.onChanged, this.label, this.tristate = false});

  @override
  Widget build(BuildContext context) {
    final t = RadixTheme.of(context);
    final c = t.colors;
    final checkbox = Checkbox(
      value: value,
      tristate: tristate,
      onChanged: onChanged,
      activeColor: c.accent,
      checkColor: c.accentText,
      side: BorderSide(color: c.border),
    );
    if (label == null) return checkbox;
    return InkWell(
      onTap: onChanged == null ? null : () => onChanged!(!value),
      radius: 14,
      splashColor: c.accent.withValues(alpha: 0.08),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          checkbox,
          Text(label!, style: TextStyle(color: c.text)),
        ],
      ),
    );
  }
}
