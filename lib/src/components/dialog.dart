import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';

/// Radix-themed dialog wrapper providing consistent styling.
class RadixDialog extends StatelessWidget {
  /// Dialog title.
  final String title;

  /// Dialog content.
  final Widget content;

  /// Optional action buttons.
  final List<Widget> actions;

  /// Creates a Radix dialog.
  const RadixDialog({super.key, required this.title, required this.content, this.actions = const []});

  /// Shows a [RadixDialog] using [showDialog].
  static Future<T?> show<T>(BuildContext context, RadixDialog dialog) {
    final t = RadixTheme.of(context);
    final c = t.colors;
    return showDialog<T>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          dialog.title,
          style: TextStyle(color: c.text, fontWeight: FontWeight.w700),
        ),
        content: DefaultTextStyle.merge(
          style: TextStyle(color: c.text),
          child: dialog.content,
        ),
        actions: dialog.actions,
        backgroundColor: c.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(t.radius3),
          side: BorderSide(color: c.border),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
