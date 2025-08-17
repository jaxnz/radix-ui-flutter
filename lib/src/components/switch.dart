import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';

enum RadixSwitchSize { sm, md, lg }

/// Radix-styled switch with optional clickable [label].
class RadixSwitch extends StatelessWidget {
  /// Whether the switch is on.
  final bool value;

  /// Called when the value changes.
  final ValueChanged<bool>? onChanged;

  /// Optional label text displayed to the right; also toggles the switch.
  final String? label;

  /// Control size (sm/md/lg).
  final RadixSwitchSize size;

  /// Creates a Radix switch.
  const RadixSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.label,
    this.size = RadixSwitchSize.md,
  });

  double get _scale => switch (size) {
    RadixSwitchSize.sm => 0.8,
    RadixSwitchSize.md => 1.0,
    RadixSwitchSize.lg => 1.2,
  };

  @override
  Widget build(BuildContext context) {
    final t = RadixTheme.of(context);
    final c = t.colors;
    final sw = Transform.scale(
      scale: _scale,
      child: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: c.accentText,
        activeTrackColor: c.accent,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
    if (label == null) return sw;
    return InkWell(
      onTap: onChanged == null ? null : () => onChanged!(!value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          sw,
          Text(label!, style: TextStyle(color: c.text)),
        ],
      ),
    );
  }
}
