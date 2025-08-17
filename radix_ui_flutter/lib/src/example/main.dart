import 'package:flutter/material.dart';
import 'package:radix_ui_flutter/radix_ui_flutter.dart';

void main() {
  runApp(
    RadixApp(
      theme: RadixThemeData(brightness: Brightness.light),
      home: const DemoPage(),
    ),
  );
}

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = RadixTheme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Radix UI Flutter')),
      body: RadixToastOverlay(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            RadixUI.heading('Typography', level: 2),
            const SizedBox(height: 8),
            const RadixText('Body text using semantic colors.'),
            const SizedBox(height: 16),
            RadixUI.heading('Buttons', level: 2),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                RadixUI.button('Solid', onPressed: () {}),
                RadixButton(variant: RadixButtonVariant.soft, onPressed: () {}, child: const Text('Soft')),
                RadixButton(variant: RadixButtonVariant.outline, onPressed: () {}, child: const Text('Outline')),
                RadixButton(variant: RadixButtonVariant.ghost, onPressed: () {}, child: const Text('Ghost')),
                RadixButton(
                  color: RadixColors.red.byStep(9, brightness: theme.brightness),
                  onPressed: () {},
                  child: const Text('Danger'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            RadixUI.heading('Toast', level: 2),
            const SizedBox(height: 8),
            RadixButton(onPressed: () => RadixToastOverlay.of(context)?.show('Hello from toast'), child: const Text('Show toast')),
            const SizedBox(height: 16),
            RadixUI.heading('Badges', level: 2),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: const [
                RadixBadge(label: 'New'),
                RadixBadge(label: 'Info', variant: RadixBadgeVariant.outline),
              ],
            ),
            const SizedBox(height: 16),
            RadixUI.heading('Card', level: 2),
            const SizedBox(height: 8),
            RadixCard(
              header: const Text('Account'),
              footer: Row(
                children: [
                  RadixButton(variant: RadixButtonVariant.ghost, onPressed: () {}, child: const Text('Details')),
                  const SizedBox(width: 8),
                  RadixButton(onPressed: () {}, child: const Text('Pay')),
                ],
              ),
              child: const RadixText('Balance: \$1,234.56'),
            ),
          ],
        ),
      ),
    );
  }
}
