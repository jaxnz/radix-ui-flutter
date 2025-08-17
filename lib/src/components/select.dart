import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';

enum RadixSelectSize { sm, md, lg }

class RadixSelect<T> extends StatelessWidget {
  final T? value;
  final List<RadixSelectOption<T>> options;
  final ValueChanged<T?>? onChanged;
  final String? hint;
  final RadixSelectSize size;

  const RadixSelect({super.key, required this.value, required this.options, this.onChanged, this.hint, this.size = RadixSelectSize.md});

  @override
  Widget build(BuildContext context) {
    final t = RadixTheme.of(context);
    final c = t.colors;
    EdgeInsetsGeometry padding;
    double fontSize;
    switch (size) {
      case RadixSelectSize.sm:
        padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 8);
        fontSize = 13;
        break;
      case RadixSelectSize.md:
        padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 10);
        fontSize = 14;
        break;
      case RadixSelectSize.lg:
        padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 14);
        fontSize = 16;
        break;
    }
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: padding,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(t.radius1),
          borderSide: BorderSide(color: c.border),
        ),
      ),
      hint: hint != null
          ? Text(
              hint!,
              style: TextStyle(color: c.textSubtle, fontSize: fontSize),
            )
          : null,
      items: [
        for (final opt in options)
          DropdownMenuItem<T>(
            value: opt.value,
            child: Text(
              opt.label,
              style: TextStyle(color: c.text, fontSize: fontSize),
            ),
          ),
      ],
      onChanged: onChanged,
    );
  }
}

class RadixSelectOption<T> {
  final String label;
  final T value;
  const RadixSelectOption({required this.label, required this.value});
}
