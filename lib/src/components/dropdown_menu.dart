import 'package:flutter/material.dart';

class RadixDropdownMenu<T> extends StatelessWidget {
  final T? value;
  final List<RadixDropdownItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final Widget? hint;

  const RadixDropdownMenu({super.key, required this.value, required this.items, this.onChanged, this.hint});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      value: value,
      hint: hint,
      items: [for (final i in items) DropdownMenuItem<T>(value: i.value, enabled: i.enabled, onTap: i.onSelected, child: i.child)],
      onChanged: onChanged,
    );
  }
}

class RadixDropdownItem<T> {
  final T value;
  final Widget child;
  final bool enabled;
  final VoidCallback? onSelected;
  const RadixDropdownItem({required this.value, required this.child, this.enabled = true, this.onSelected});
}
