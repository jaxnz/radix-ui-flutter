import 'package:flutter/material.dart';

class RadixMenubar extends StatelessWidget {
  final List<RadixMenuCascade> menus;
  const RadixMenubar({super.key, required this.menus});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final m in menus)
          PopupMenuButton<int>(
            child: Padding(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6), child: Text(m.title)),
            itemBuilder: (_) => [for (int i = 0; i < m.items.length; i++) PopupMenuItem(value: i, onTap: m.items[i].onSelected, child: m.items[i].child)],
          ),
      ],
    );
  }
}

class RadixMenuCascade {
  final String title;
  final List<RadixMenuAction> items;
  const RadixMenuCascade({required this.title, required this.items});
}

class RadixMenuAction {
  final Widget child;
  final VoidCallback? onSelected;
  const RadixMenuAction({required this.child, this.onSelected});
}
