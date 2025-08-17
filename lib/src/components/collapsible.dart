import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';

class RadixCollapsible extends StatefulWidget {
  final Widget header;
  final Widget content;
  final bool initiallyOpen;
  const RadixCollapsible({super.key, required this.header, required this.content, this.initiallyOpen = false});

  @override
  State<RadixCollapsible> createState() => _RadixCollapsibleState();
}

class _RadixCollapsibleState extends State<RadixCollapsible> {
  late bool open = widget.initiallyOpen;

  @override
  Widget build(BuildContext context) {
    final c = RadixTheme.of(context).colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: () => setState(() => open = !open),
          child: DefaultTextStyle.merge(
            style: TextStyle(color: c.text),
            child: widget.header,
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: DefaultTextStyle.merge(
            style: TextStyle(color: c.text),
            child: widget.content,
          ),
          crossFadeState: open ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 180),
        ),
      ],
    );
  }
}
