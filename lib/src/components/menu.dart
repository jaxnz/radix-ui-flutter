import 'package:flutter/material.dart';

class RadixMenu extends StatelessWidget {
  final Widget anchor;
  final List<RadixMenuItem> items;
  const RadixMenu({super.key, required this.anchor, required this.items});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      child: anchor,
      itemBuilder: (_) => [
        for (int i = 0; i < items.length; i++)
          PopupMenuItem<int>(
            value: i,
            enabled: items[i].enabled,
            onTap: items[i].onSelected,
            child: items[i].child,
          ),
      ],
    );
  }
}

class RadixMenuItem {
  final Widget child;
  final bool enabled;
  final VoidCallback? onSelected;
  const RadixMenuItem({required this.child, this.enabled = true, this.onSelected});
}
