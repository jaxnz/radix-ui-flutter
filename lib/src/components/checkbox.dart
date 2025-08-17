import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';

/// Radix-styled checkbox with optional clickable [label].
class RadixCheckbox extends StatelessWidget {
  /// Whether the checkbox is checked.
  final bool value;

  /// Callback when the value changes. If null, the control is disabled.
  final ValueChanged<bool?>? onChanged;

  /// Optional label displayed to the right. Tapping it toggles the value.
  final String? label;

  /// If true, supports three states (null/true/false).
  final bool tristate;

  /// Creates a Radix checkbox.
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
