import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';

class RadixToggle extends StatefulWidget {
  final bool initialOn;
  final Widget child;
  final ValueChanged<bool>? onChanged;
  const RadixToggle({super.key, required this.child, this.initialOn = false, this.onChanged});

  @override
  State<RadixToggle> createState() => _RadixToggleState();
}

class _RadixToggleState extends State<RadixToggle> {
  late bool on = widget.initialOn;
  @override
  Widget build(BuildContext context) {
    final t = RadixTheme.of(context);
    final c = t.colors;
    final bg = on ? c.accent.withValues(alpha: 0.12) : Colors.transparent;
    final br = on ? c.accent : c.border;
    final fg = on ? c.accent : c.text;
    return Material(
      color: bg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(t.radius2),
        side: BorderSide(color: br),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(t.radius2),
        onTap: () {
          setState(() => on = !on);
          widget.onChanged?.call(on);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: IconTheme.merge(
            data: IconThemeData(color: fg),
            child: DefaultTextStyle.merge(
              style: TextStyle(color: fg),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
