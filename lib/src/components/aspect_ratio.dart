import 'package:flutter/widgets.dart';

class RadixAspectRatio extends StatelessWidget {
  final double aspectRatio;
  final Widget child;
  const RadixAspectRatio({super.key, required this.aspectRatio, required this.child});

  @override
  Widget build(BuildContext context) => AspectRatio(aspectRatio: aspectRatio, child: child);
}
