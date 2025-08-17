import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';

class RadixNavigationMenu extends StatelessWidget {
  final List<RadixNavItem> items;
  final ValueChanged<int>? onTap;
  final int currentIndex;

  const RadixNavigationMenu({super.key, required this.items, this.onTap, this.currentIndex = 0});

  @override
  Widget build(BuildContext context) {
    final c = RadixTheme.of(context).colors;
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: c.accent,
      unselectedItemColor: c.textSubtle,
      items: [for (final i in items) BottomNavigationBarItem(icon: i.icon, label: i.label)],
    );
  }
}

class RadixNavItem {
  final String label;
  final Widget icon;
  const RadixNavItem({required this.label, required this.icon});
}
