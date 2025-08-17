import 'package:flutter/widgets.dart';

class RadixVisuallyHidden extends StatelessWidget {
  final Widget child;
  const RadixVisuallyHidden({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(excluding: false, child: Offstage(offstage: true, child: child));
  }
}
