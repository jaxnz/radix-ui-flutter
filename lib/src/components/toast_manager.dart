import 'package:flutter/material.dart';

class RadixToastOverlay extends StatefulWidget {
  final Widget child;
  const RadixToastOverlay({super.key, required this.child});

  static RadixToastController? of(BuildContext context) => context.findAncestorStateOfType<_RadixToastOverlayState>();

  @override
  State<RadixToastOverlay> createState() => _RadixToastOverlayState();
}

class _RadixToastOverlayState extends State<RadixToastOverlay> implements RadixToastController {
  final List<_ToastEntry> _toasts = [];

  @override
  void show(String message, {Duration duration = const Duration(seconds: 3), Color? background}) {
    final entry = _ToastEntry(message: message, background: background);
    setState(() => _toasts.add(entry));
    Future.delayed(duration, () {
      if (mounted) setState(() => _toasts.remove(entry));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Positioned(
          left: 0,
          right: 0,
          bottom: 24,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final t in _toasts)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Dismissible(
                    key: ValueKey(t),
                    direction: DismissDirection.down,
                    onDismissed: (_) => setState(() => _toasts.remove(t)),
                    child: Material(
                      color: t.background ?? Colors.black87,
                      elevation: 8,
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        child: Text(t.message, style: const TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ToastEntry {
  final String message;
  final Color? background;
  _ToastEntry({required this.message, this.background});
}

abstract class RadixToastController {
  void show(String message, {Duration duration, Color? background});
}
