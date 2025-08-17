import 'package:flutter/material.dart';

class RadixDismissibleLayer extends StatelessWidget {
  final Widget child;
  final VoidCallback? onDismiss;
  const RadixDismissibleLayer({super.key, required this.child, this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(onTap: onDismiss, behavior: HitTestBehavior.opaque),
        ),
        child,
      ],
    );
  }
}
