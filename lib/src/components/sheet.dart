import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';

class RadixSheet {
  static Future<T?> bottom<T>(BuildContext context, {required Widget child, bool isScrollControlled = true}) {
    final t = RadixTheme.of(context);
    final c = t.colors;
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      backgroundColor: c.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(t.radius3)),
        side: BorderSide(color: c.border),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: child,
      ),
    );
  }

  static Widget drawer({required Widget child}) => Builder(
    builder: (context) {
      final c = RadixTheme.of(context).colors;
      return Drawer(backgroundColor: c.surface, child: child);
    },
  );
}
