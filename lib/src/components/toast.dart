import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';

enum RadixToastVariant { info, success, warning, danger }

class RadixToast {
  static void show(BuildContext context, String message, {RadixToastVariant variant = RadixToastVariant.info, Duration duration = const Duration(seconds: 3)}) {
    final c = RadixTheme.of(context).colors;
    Color bg;
    switch (variant) {
      case RadixToastVariant.info:
        bg = c.text;
        break;
      case RadixToastVariant.success:
        bg = RadixTheme.of(context).colors.success;
        break;
      case RadixToastVariant.warning:
        bg = RadixTheme.of(context).colors.warning;
        break;
      case RadixToastVariant.danger:
        bg = RadixTheme.of(context).colors.danger;
        break;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: bg, duration: duration));
  }
}
