import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';

class RadixToggleGroup<T> extends StatefulWidget {
  final List<RadixToggleOption<T>> options;
  final Set<T> selected;
  final bool multiple;
  final ValueChanged<Set<T>>? onChanged;
  const RadixToggleGroup({super.key, required this.options, this.selected = const {}, this.multiple = false, this.onChanged});

  @override
  State<RadixToggleGroup<T>> createState() => _RadixToggleGroupState<T>();
}

class _RadixToggleGroupState<T> extends State<RadixToggleGroup<T>> {
  late Set<T> selectedValues = {...widget.selected};

  void _toggle(T value) {
    setState(() {
      if (widget.multiple) {
        if (!selectedValues.add(value)) selectedValues.remove(value);
      } else {
        selectedValues = {value};
      }
    });
    widget.onChanged?.call(selectedValues);
  }

  @override
  Widget build(BuildContext context) {
    final t = RadixTheme.of(context);
    final c = t.colors;
    return Wrap(
      spacing: 8,
      children: [for (final opt in widget.options) _ToggleChip(label: opt.label, selected: selectedValues.contains(opt.value), onTap: () => _toggle(opt.value), accent: c.accent, border: c.border, text: c.text)],
    );
  }
}

class _ToggleChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color accent;
  final Color border;
  final Color text;

  const _ToggleChip({required this.label, required this.selected, required this.onTap, required this.accent, required this.border, required this.text});

  @override
  Widget build(BuildContext context) {
    final t = RadixTheme.of(context);
    final bg = selected ? accent.withValues(alpha: 0.12) : Colors.transparent;
    final br = selected ? accent : border;
    final fg = selected ? accent : text;
    return Material(
      color: bg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(t.radius2),
        side: BorderSide(color: br),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(t.radius2),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Text(label, style: TextStyle(color: fg)),
        ),
      ),
    );
  }
}

class RadixToggleOption<T> {
  final String label;
  final T value;
  const RadixToggleOption({required this.label, required this.value});
}
