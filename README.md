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
  // Optional: enable global actions (confirm/toast)
  RadixUI.setNavigatorKey(GlobalKey<NavigatorState>());
  runApp(MaterialApp(
    navigatorKey: RadixUI.navigatorKey,
    builder: RadixUI.appBuilder(RadixThemeData(brightness: Brightness.light)),
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
            RadixUI.heading('Hello Radix', level: 2),
            const SizedBox(height: 12),
            RadixUI.text('A design-system friendly Flutter UI kit.'),
            const SizedBox(height: 16),
            Row(children: [
              RadixUI.button('Primary', onPressed: () {}),
              const SizedBox(width: 8),
              RadixUI.button('Secondary', variant: RadixButtonVariant.outline, onPressed: () {}),
            ]),
            const SizedBox(height: 16),
            RadixUI.badge('New'),
          ],
        ),
      ),
    );
  }
}
```

## Theming

Use `RadixThemeData` to control palettes, radii, and spacing. Provide it via `RadixUI.appBuilder` (or `RadixScope`).

```dart
final base = RadixThemeData(
  brightness: Brightness.light,
  grayScale: RadixColors.mauve,
  brandScale: RadixColors.violet,
);
MaterialApp(
  theme: base.toMaterialTheme(),
  darkTheme: base.copyWith(brightness: Brightness.dark).toMaterialTheme(),
  builder: RadixUI.appBuilder(base),
)
```

## RadixUI API

- Structure/content: `section`, `card`, `text`, `heading`, `separator`, `badge`, `avatar`, `link`
- Buttons: `button(label, {variant, size, fullWidth, onPressed, color})`
- Inputs: `textField`, `labeledSwitch`, `checkbox`, `radioGroup`, `select`
- Ranges/status: `slider`, `progress`
- Navigation/overlays: `tabs`, `tooltip`, `openDialog(RadixDialog)`, `accordion`, `toggle`, `toggleGroup`
- Global UX: `showToast`, `confirm`, `appBuilder`, `setNavigatorKey`

Example:
```dart
RadixUI.section(
  title: 'Sign up',
  child: Column(children: [
    RadixUI.textField(placeholder: 'Email'),
    const SizedBox(height: 12),
    RadixUI.button('Create account', variant: RadixButtonVariant.soft, onPressed: () {}),
  ]),
)
```

## Icons

Use minimal SVG-based icons:

```dart
RadixIcon.check(size: 18)
```

## Colors

Access color scales and semantic colors via `RadixColors` and `RadixTheme.of(context).colors`.

## License

This package is MIT-licensed. Radix UI is maintained by WorkOS. This project is an independent, community-driven port for Flutter.
