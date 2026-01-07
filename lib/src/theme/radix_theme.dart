import 'package:flutter/material.dart';
import '../colors/radix_colors.dart';
import '../utils/radix_ui.dart';

/// Radix theme data for Flutter.
class RadixThemeData {
  final Brightness brightness;
  final RadixColorScale grayScale;
  final RadixColorScale brandScale;
  final double radius1;
  final double radius2;
  final double radius3;
  final EdgeInsetsGeometry contentPadding;

  late final RadixSemanticColors colors = _computeSemanticColors();

  RadixThemeData({required this.brightness, this.grayScale = RadixColorScales.gray, this.brandScale = RadixColorScales.blue, this.radius1 = 6.0, this.radius2 = 8.0, this.radius3 = 12.0, this.contentPadding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8)});

  ThemeData toMaterialTheme() {
    final c = colors;
    final primarySwatch = brandScale.toMaterialColor(brightness: brightness);
    final schemeBase = ColorScheme.fromSwatch(
      primarySwatch: primarySwatch,
      brightness: brightness,
      backgroundColor: c.background,
      cardColor: c.surface,
      errorColor: c.danger,
    );
    final colorScheme = schemeBase.copyWith(
      primary: c.accent,
      onPrimary: c.accentText,
      secondary: c.surface,
      onSecondary: c.text,
      surface: c.surface,
      onSurface: c.text,
      error: c.danger,
      onError: Colors.white,
      outline: c.border,
    );

    return ThemeData(
      colorScheme: colorScheme,
      brightness: brightness,
      primarySwatch: primarySwatch,
      useMaterial3: true,
      scaffoldBackgroundColor: c.background,
      textTheme: brightness == Brightness.dark ? Typography.whiteMountainView : Typography.blackMountainView,
    );
  }

  RadixSemanticColors _computeSemanticColors() {
    final gray = grayScale;
    final brand = brandScale;
    final b = brightness;
    return RadixSemanticColors(
      background: gray.byStep(1, brightness: b),
      surface: gray.byStep(3, brightness: b),
      subtleSurface: gray.byStep(2, brightness: b),
      text: b == Brightness.dark ? gray.byStep(12, brightness: b) : gray.byStep(12, brightness: b),
      textSubtle: gray.byStep(11, brightness: b),
      border: gray.byStep(6, brightness: b),
      accent: brand.byStep(9, brightness: b),
      accentText: b == Brightness.dark ? Colors.black : Colors.white,
      success: RadixColorScales.green.byStep(9, brightness: b),
      warning: RadixColorScales.amber.byStep(9, brightness: b),
      danger: RadixColorScales.red.byStep(9, brightness: b),
    );
  }

  RadixThemeData copyWith({Brightness? brightness, RadixColorScale? grayScale, RadixColorScale? brandScale, double? radius1, double? radius2, double? radius3, EdgeInsetsGeometry? contentPadding}) {
    return RadixThemeData(brightness: brightness ?? this.brightness, grayScale: grayScale ?? this.grayScale, brandScale: brandScale ?? this.brandScale, radius1: radius1 ?? this.radius1, radius2: radius2 ?? this.radius2, radius3: radius3 ?? this.radius3, contentPadding: contentPadding ?? this.contentPadding);
  }
}

class RadixTheme extends InheritedWidget {
  final RadixThemeData data;

  const RadixTheme({super.key, required this.data, required super.child});

  static RadixThemeData of(BuildContext context) {
    final inherited = context.dependOnInheritedWidgetOfExactType<RadixTheme>();
    return inherited?.data ?? RadixThemeData(brightness: Theme.of(context).brightness);
  }

  @override
  bool updateShouldNotify(RadixTheme oldWidget) => data != oldWidget.data;
}

/// A convenience widget to apply RadixTheme to MaterialApp.
class RadixApp extends StatelessWidget {
  final RadixThemeData theme;
  final Widget home;
  final String? title;
  final ThemeMode themeMode;

  const RadixApp({super.key, required this.theme, required this.home, this.title, this.themeMode = ThemeMode.system});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title ?? 'Radix App',
      theme: theme.toMaterialTheme(),
      darkTheme: theme.copyWith(brightness: Brightness.dark).toMaterialTheme(),
      themeMode: themeMode,
      home: home,
      builder: (context, child) {
        final resolvedBrightness = Theme.of(context).brightness;
        final resolved = theme.copyWith(brightness: resolvedBrightness);
        // Keep RadixUI static snapshot in sync for no-context helpers
        RadixUI.setTheme(resolved);
        return RadixTheme(data: resolved, child: child ?? const SizedBox.shrink());
      },
    );
  }
}
