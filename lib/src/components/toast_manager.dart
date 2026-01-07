import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';
import 'toast.dart';

/// Placement options for Radix toasts.
enum RadixToastPosition {
  topLeft,
  topCenter,
  topRight,
  bottomLeft,
  bottomCenter,
  bottomRight,
}

/// Internal host for Radix toasts. Used by [RadixUI.showToast].
class RadixToastHost {
  static OverlayEntry? _entry;

  static void show(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
    RadixToastVariant variant = RadixToastVariant.info,
    RadixToastPosition position = RadixToastPosition.bottomCenter,
    OverlayState? overlayState,
  }) {
    final overlay = overlayState ?? Overlay.of(context, rootOverlay: true);

    // Only one toast at a time for simplicity.
    _entry?.remove();
    _entry = null;

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (ctx) {
        final theme = RadixTheme.of(ctx);
        final colors = theme.colors;
        final style = resolveRadixToastStyle(theme, variant);

        final card = Material(
          color: style.backgroundColor,
          elevation: 12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(theme.radius2),
            side: BorderSide(color: colors.border),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: DefaultTextStyle(
              style: TextStyle(
                color: style.textColor,
                fontSize: 14,
              ),
              child: Text(message),
            ),
          ),
        );

        switch (position) {
          case RadixToastPosition.topLeft:
            return Positioned(
              left: 24,
              top: 24,
              child: card,
            );
          case RadixToastPosition.topCenter:
            return Positioned(
              left: 24,
              right: 24,
              top: 24,
              child: Center(child: card),
            );
          case RadixToastPosition.topRight:
            return Positioned(
              right: 24,
              top: 24,
              child: card,
            );
          case RadixToastPosition.bottomLeft:
            return Positioned(
              left: 24,
              bottom: 24,
              child: card,
            );
          case RadixToastPosition.bottomCenter:
            return Positioned(
              left: 24,
              right: 24,
              bottom: 24,
              child: Center(child: card),
            );
          case RadixToastPosition.bottomRight:
          return Positioned(
              right: 24,
              bottom: 24,
              child: card,
            );
        }
      },
    );

    _entry = entry;
    overlay.insert(entry);

    Future.delayed(duration, () {
      if (_entry == entry) {
        entry.remove();
        _entry = null;
      }
    });
  }
}
