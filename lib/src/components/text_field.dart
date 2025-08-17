import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';

enum RadixFieldSize { sm, md, lg }

class RadixTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? placeholder;
  final String? label;
  final bool obscureText;
  final RadixFieldSize size;

  const RadixTextField({
    super.key,
    this.controller,
    this.placeholder,
    this.label,
    this.obscureText = false,
    this.size = RadixFieldSize.md,
  });

  EdgeInsetsGeometry get _padding => switch (size) {
    RadixFieldSize.sm => const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    RadixFieldSize.md => const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    RadixFieldSize.lg => const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
  };

  double get _fontSize => switch (size) {
    RadixFieldSize.sm => 13,
    RadixFieldSize.md => 14,
    RadixFieldSize.lg => 16,
  };

  @override
  Widget build(BuildContext context) {
    final t = RadixTheme.of(context);
    final c = t.colors;
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: c.text, fontSize: _fontSize),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: _padding,
        labelText: label,
        hintText: placeholder,
        filled: true,
        fillColor: c.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(t.radius1),
          borderSide: BorderSide(color: c.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(t.radius1),
          borderSide: BorderSide(color: c.accent),
        ),
      ),
    );
  }
}
