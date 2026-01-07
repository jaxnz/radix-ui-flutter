import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';

enum RadixToastVariant { info, success, warning, danger }

class RadixToastStyle {
  final Color backgroundColor;
  final Color textColor;

  const RadixToastStyle({required this.backgroundColor, required this.textColor});
}

RadixToastStyle resolveRadixToastStyle(RadixThemeData theme, RadixToastVariant variant) {
  final c = theme.colors;
  final background = switch (variant) {
    RadixToastVariant.info => c.accent,
    RadixToastVariant.success => c.success,
    RadixToastVariant.warning => c.warning,
    RadixToastVariant.danger => c.danger,
  };
  final textColor = background.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  return RadixToastStyle(backgroundColor: background, textColor: textColor);
}

class RadixToast {
  static void show(BuildContext context, String message, {RadixToastVariant variant = RadixToastVariant.info, Duration duration = const Duration(seconds: 3)}) {
    final style = resolveRadixToastStyle(RadixTheme.of(context), variant);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: style.textColor)),
        backgroundColor: style.backgroundColor,
        duration: duration,
      ),
    );
  }
}
