import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';

class RadixDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final List<Widget> actions;

  const RadixDialog({super.key, required this.title, required this.content, this.actions = const []});

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
