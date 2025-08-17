import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';

class RadixCard extends StatelessWidget {
  final Widget? header;
  final Widget? footer;
  final Widget child;

  const RadixCard({super.key, required this.child, this.header, this.footer});

  @override
  Widget build(BuildContext context) {
    final t = RadixTheme.of(context);
    final c = t.colors;

    return Container(
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(t.radius3),
        border: Border.all(color: c.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (header != null)
            Padding(
              padding: EdgeInsets.all(t.contentPadding.horizontal / 2),
              child: DefaultTextStyle.merge(
                style: TextStyle(color: c.text, fontWeight: FontWeight.w700),
                child: header!,
              ),
            ),
          Padding(
            padding: t.contentPadding,
            child: DefaultTextStyle.merge(
              style: TextStyle(color: c.text),
              child: child,
            ),
          ),
          if (footer != null)
            Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: c.border)),
              ),
              padding: const EdgeInsets.all(12),
              child: DefaultTextStyle.merge(
                style: TextStyle(color: c.textSubtle),
                child: footer!,
              ),
            ),
        ],
      ),
    );
  }
}
