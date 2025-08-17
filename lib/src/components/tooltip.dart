import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';

class RadixTooltip extends StatelessWidget {
  final Widget child;
  final String message;

  const RadixTooltip({super.key, required this.child, required this.message});

  @override
  Widget build(BuildContext context) {
    final c = RadixTheme.of(context).colors;
    return Tooltip(
      message: message,
      decoration: BoxDecoration(color: c.text, borderRadius: BorderRadius.circular(6)),
      textStyle: const TextStyle(color: Colors.white),
      child: child,
    );
  }
}
