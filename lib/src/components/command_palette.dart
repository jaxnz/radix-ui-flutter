import 'package:flutter/material.dart';

class RadixCommandItem {
  final String label;
  final String? shortcut;
  final VoidCallback onSelected;
  const RadixCommandItem({required this.label, required this.onSelected, this.shortcut});
}

class RadixCommandPalette {
  static Future<void> show(BuildContext context, List<RadixCommandItem> items) async {
    final controller = TextEditingController();
    await showDialog(
      context: context,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.all(16),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640, maxHeight: 480),
          child: _PaletteBody(controller: controller, items: items),
        ),
      ),
    );
  }
}

class _PaletteBody extends StatefulWidget {
  final TextEditingController controller;
  final List<RadixCommandItem> items;
  const _PaletteBody({required this.controller, required this.items});

  @override
  State<_PaletteBody> createState() => _PaletteBodyState();
}

class _PaletteBodyState extends State<_PaletteBody> {
  String query = '';
  @override
  Widget build(BuildContext context) {
    final filtered = widget.items.where((i) => i.label.toLowerCase().contains(query.toLowerCase())).toList();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            controller: widget.controller,
            autofocus: true,
            decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Type a command...'),
            onChanged: (v) => setState(() => query = v),
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: ListView.builder(
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final item = filtered[index];
              return ListTile(
                title: Text(item.label),
                trailing: item.shortcut == null ? null : Text(item.shortcut!, style: Theme.of(context).textTheme.labelSmall),
                onTap: () {
                  Navigator.of(context).pop();
                  item.onSelected();
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
