import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';
import 'button.dart';

Future<T?> radixConfirmDialog<T>({required BuildContext context, required String title, String? description, String confirmText = 'Confirm', String cancelText = 'Cancel'}) {
  final t = RadixTheme.of(context);
  final c = t.colors;
  return showDialog<T>(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title, style: TextStyle(color: c.text)),
      content: description == null ? null : Text(description, style: TextStyle(color: c.textSubtle)),
      backgroundColor: c.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(t.radius2),
        side: BorderSide(color: c.border),
      ),
      actions: [
        RadixButton(variant: RadixButtonVariant.ghost, onPressed: () => Navigator.of(context).pop(false), child: Text(cancelText)),
        const SizedBox(height: 7),
        RadixButton(onPressed: () => Navigator.of(context).pop(true), child: Text(confirmText)),
      ],
    ),
  );
}

Future<void> radixAlertDialog({required BuildContext context, required String title, String? description, String dismissText = 'OK'}) {
  final t = RadixTheme.of(context);
  final c = t.colors;
  return showDialog<void>(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title, style: TextStyle(color: c.text)),
      content: description == null ? null : Text(description, style: TextStyle(color: c.textSubtle)),
      backgroundColor: c.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(t.radius2),
        side: BorderSide(color: c.border),
      ),
      actions: [RadixButton(variant: RadixButtonVariant.ghost, onPressed: () => Navigator.of(context).pop(), child: Text(dismissText))],
    ),
  );
}
