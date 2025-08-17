import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';

/// Radix-styled wrapper for [Tooltip].
class RadixTooltip extends StatelessWidget {
  /// The widget that triggers the tooltip.
  final Widget child;

  /// Tooltip text.
  final String message;

  /// Creates a Radix tooltip.
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
