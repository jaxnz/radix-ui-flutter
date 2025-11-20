import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';

enum RadixFieldSize { sm, md, lg }

/// Visual variants for Radix text fields.
enum RadixTextFieldVariant { surface, classic, soft }

/// A Radix-styled text field with consistent padding, radius and colors.
class RadixTextField extends StatelessWidget {
  /// Optional controller to manage the input text.
  final TextEditingController? controller;

  /// Placeholder (hint) shown when empty.
  final String? placeholder;

  /// Optional floating label text.
  final String? label;

  /// Optional prefix icon.
  final Widget? prefixIcon;

  /// Optional suffix icon or action.
  final Widget? suffixIcon;

  /// If true, masks the input (e.g., for passwords). Defaults to false.
  final bool obscureText;

  /// Control size (sm/md/lg). Affects padding and font size.
  final RadixFieldSize size;

  /// Visual variant controlling background and border style.
  final RadixTextFieldVariant variant;

  /// Creates a Radix text field.
  const RadixTextField({super.key, this.controller, this.placeholder, this.label, this.prefixIcon, this.suffixIcon, this.obscureText = false, this.size = RadixFieldSize.md, this.variant = RadixTextFieldVariant.surface});

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

    // Map variants to background + border semantics.
    final bool filled;
    final Color fillColor;
    final Color borderColor;
    final Color focusedBorderColor;

    switch (variant) {
      case RadixTextFieldVariant.surface:
        filled = true;
        fillColor = c.surface;
        borderColor = c.border;
        focusedBorderColor = c.accent;
        break;
      case RadixTextFieldVariant.classic:
        filled = false;
        fillColor = Colors.transparent;
        borderColor = c.border;
        focusedBorderColor = c.accent;
        break;
      case RadixTextFieldVariant.soft:
        filled = true;
        fillColor = c.accent.withValues(alpha: 0.08);
        borderColor = c.accent.withValues(alpha: 0.24);
        focusedBorderColor = c.accent;
        break;
    }

    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: c.text, fontSize: _fontSize),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: _padding,
        labelText: label,
        hintText: placeholder,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: filled,
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(t.radius1),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(t.radius1),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(t.radius1),
          borderSide: BorderSide(color: focusedBorderColor),
        ),
      ),
    );
  }
}
