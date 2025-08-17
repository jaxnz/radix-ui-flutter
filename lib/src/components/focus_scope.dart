import 'package:flutter/widgets.dart';

class RadixFocusScope extends StatelessWidget {
  final Widget child;
  const RadixFocusScope({super.key, required this.child});

  @override
  Widget build(BuildContext context) => FocusScope(canRequestFocus: true, autofocus: true, child: child);
}
