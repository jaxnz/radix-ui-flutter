import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';

/// Accordion with bordered container and animated expand/collapse.
class RadixAccordion extends StatelessWidget {
  /// Accordion items to render.
  final List<RadixAccordionItem> items;

  /// Creates a Radix accordion.
  const RadixAccordion({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final t = RadixTheme.of(context);
    final c = t.colors;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: c.border),
        borderRadius: BorderRadius.circular(t.radius2),
      ),
      child: Column(children: items.map((e) => _Item(e)).toList()),
    );
  }
}

class _Item extends StatefulWidget {
  final RadixAccordionItem item;
  const _Item(this.item);

  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> {
  bool open = false;
  @override
  Widget build(BuildContext context) {
    final t = RadixTheme.of(context);
    final c = t.colors;
    return Column(
      children: [
        ListTile(
          title: Text(
            widget.item.header,
            style: TextStyle(color: c.text, fontWeight: FontWeight.w600),
          ),
          trailing: Icon(open ? Icons.expand_less : Icons.expand_more, color: c.textSubtle),
          onTap: () => setState(() => open = !open),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Padding(
            padding: EdgeInsets.only(left: t.contentPadding.horizontal / 2, right: t.contentPadding.horizontal / 2, bottom: t.contentPadding.vertical),
            child: DefaultTextStyle.merge(
              style: TextStyle(color: c.text),
              child: widget.item.content,
            ),
          ),
          crossFadeState: open ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 180),
        ),
        const Divider(height: 1),
      ],
    );
  }
}

/// Item configuration for [RadixAccordion].
class RadixAccordionItem {
  /// Header text.
  final String header;

  /// Item content displayed when expanded.
  final Widget content;

  /// Creates an accordion item.
  const RadixAccordionItem({required this.header, required this.content});
}
