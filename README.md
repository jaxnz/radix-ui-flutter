# Radix UI for Flutter

Radix UI themes, components (primitives), icons and colors for Flutter.

- Inspired by Radix Themes, Primitives, Icons, and Colors
  - Website: [radix-ui.com](https://www.radix-ui.com/)
  - Themes: [radix-ui/themes](https://github.com/radix-ui/themes)
  - Primitives: [radix-ui/primitives](https://github.com/radix-ui/primitives)
  - Icons: [radix-ui/icons](https://github.com/radix-ui/icons)
  - Colors: [radix-ui/colors](https://github.com/radix-ui/colors)

## Quick start

```dart
import 'package:flutter/material.dart';
import 'package:radix_ui_flutter/radix_ui_flutter.dart';

void main() {
  runApp(RadixApp(
    theme: RadixThemeData(brightness: Brightness.light),
    home: const DemoPage(),
  ));
}

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Radix UI Flutter')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const RadixUI.heading('Hello Radix', level: 2),
            const SizedBox(height: 12),
            const RadixText('A design-system friendly Flutter UI kit.'),
            const SizedBox(height: 16),
            Row(children: [
              RadixButton(child: const Text('Primary'), onPressed: () {}),
              const SizedBox(width: 8),
              RadixButton(variant: RadixButtonVariant.outline, child: const Text('Secondary'), onPressed: () {}),
            ]),
            const SizedBox(height: 16),
            const RadixBadge(label: 'New'),
          ],
        ),
      ),
    );
  }
}
```

## Theming

Use `RadixThemeData` to control colors, radii, and spacing. Wrap your app in `RadixApp` or provide `RadixTheme` manually.

```dart
RadixApp(
  theme: RadixThemeData(
    brightness: Brightness.dark,
    brandScale: RadixColors.blue,
  ),
  home: const DemoPage(),
)
```

## Components

- `RadixButton` with `solid`, `soft`, `outline`, `ghost`
- `RadixBadge` with `solid`, `soft`, `outline`
- `RadixCard` layout container
- `RadixText`, `RadixUI.heading`

## Icons

Use minimal SVG-based icons:

```dart
RadixIcon.check(size: 18)
```

## Colors

Access color scales and semantic colors via `RadixColors` and `RadixTheme.of(context).colors`.

## License

This package is MIT-licensed. Radix UI is maintained by WorkOS. This project is an independent, community-driven port for Flutter.
