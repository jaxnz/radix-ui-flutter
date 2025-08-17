import 'package:flutter/material.dart';

class RadixToolbar extends StatelessWidget {
  final List<Widget> children;
  const RadixToolbar({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 8, runSpacing: 8, children: children);
  }
}
