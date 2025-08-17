import 'package:flutter/widgets.dart';

class RadixPresence extends StatelessWidget {
  final bool present;
  final Widget child;
  const RadixPresence({super.key, required this.present, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(duration: const Duration(milliseconds: 150), child: present ? child : const SizedBox.shrink());
  }
}
