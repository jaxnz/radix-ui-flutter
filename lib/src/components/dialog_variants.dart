import 'package:flutter/material.dart';
import 'package:radix_ui_flutter/radix_ui_flutter.dart';

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
        RadixUI.button(label: cancelText, variant: RadixButtonVariant.ghost, onPressed: () => Navigator.of(context).pop(false)),
        const SizedBox(height: 7),
        RadixUI.button(label: confirmText, onPressed: () => Navigator.of(context).pop(true)),
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
      actions: [RadixUI.button(label: dismissText, variant: RadixButtonVariant.ghost, onPressed: () => Navigator.of(context).pop())],
    ),
  );
}
