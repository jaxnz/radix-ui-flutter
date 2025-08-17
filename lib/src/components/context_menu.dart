import 'package:flutter/material.dart';

class RadixContextMenu extends StatelessWidget {
  final List<RadixContextAction> actions;
  final Widget child;
  const RadixContextMenu({super.key, required this.actions, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onSecondaryTapDown: (d) async {
        final pos = d.globalPosition;
        final selected = await showMenu<int>(
          context: context,
          position: RelativeRect.fromLTRB(pos.dx, pos.dy, pos.dx, pos.dy),
          items: [for (int i = 0; i < actions.length; i++) PopupMenuItem<int>(value: i, child: actions[i].child)],
        );
        if (selected != null) actions[selected].onSelected?.call();
      },
      child: child,
    );
  }
}

class RadixContextAction {
  final Widget child;
  final VoidCallback? onSelected;
  const RadixContextAction({required this.child, this.onSelected});
}
