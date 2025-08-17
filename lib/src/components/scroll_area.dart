import 'package:flutter/material.dart';

class RadixScrollArea extends StatelessWidget {
  final Widget child;
  final ScrollController? controller;
  const RadixScrollArea({super.key, required this.child, this.controller});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: controller,
      child: SingleChildScrollView(controller: controller, child: child),
    );
  }
}
