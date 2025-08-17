import 'package:flutter/material.dart';

class RadixFocusRing extends StatelessWidget {
  final Widget child;
  final BorderRadiusGeometry borderRadius;
  const RadixFocusRing({super.key, required this.child, this.borderRadius = const BorderRadius.all(Radius.circular(6))});

  @override
  Widget build(BuildContext context) {
    return Focus(
      child: Builder(
        builder: (context) {
          final focused = Focus.of(context).hasFocus;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            decoration: focused
                ? ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: borderRadius,
                      side: const BorderSide(width: 2, color: Color(0xFF3B82F6)),
                    ),
                  )
                : const BoxDecoration(),
            child: child,
          );
        },
      ),
    );
  }
}
