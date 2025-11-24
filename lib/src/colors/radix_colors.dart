import 'package:flutter/material.dart';

/// Radix color scales (12 steps) for light and dark modes.
/// Values are sourced and adapted from Radix Colors:
/// https://www.radix-ui.com/colors
class RadixColorScale {
  final Map<int, Color> light;
  final Map<int, Color> dark;

  const RadixColorScale({required this.light, required this.dark});

  Color byStep(int step, {required Brightness brightness}) {
    final target = brightness == Brightness.dark ? dark : light;
    return target[step] ?? target.values.last;
  }

  /// Build a Material swatch (50-900, plus 950) from the Radix steps.
  MaterialColor toMaterialColor({Brightness brightness = Brightness.light}) {
    final shade = (int step) => byStep(step, brightness: brightness);
    final swatch = <int, Color>{
      50: shade(1),
      100: shade(2),
      200: shade(3),
      300: shade(4),
      400: shade(5),
      500: shade(6),
      600: shade(7),
      700: shade(8),
      800: shade(9),
      900: shade(11),
      950: shade(12),
    };
    return MaterialColor(swatch[500]!.value, swatch);
  }
}

/// Full Radix scales for light/dark aware theming.
class RadixColorScales {
  RadixColorScales._();

  static const gray = RadixColorScale(
    light: {1: Color(0xFFFCFCFC), 2: Color(0xFFF8F8F8), 3: Color(0xFFF3F3F3), 4: Color(0xFFEDEDED), 5: Color(0xFFE8E8E8), 6: Color(0xFFE2E2E2), 7: Color(0xFFDBDBDB), 8: Color(0xFFC7C7C7), 9: Color(0xFF8F8F8F), 10: Color(0xFF858585), 11: Color(0xFF6F6F6F), 12: Color(0xFF171717)},
    dark: {1: Color(0xFF111111), 2: Color(0xFF191919), 3: Color(0xFF222222), 4: Color(0xFF2A2A2A), 5: Color(0xFF313131), 6: Color(0xFF3A3A3A), 7: Color(0xFF484848), 8: Color(0xFF606060), 9: Color(0xFF6E6E6E), 10: Color(0xFF7B7B7B), 11: Color(0xFFB4B4B4), 12: Color(0xFFEDEDED)},
  );

  static const blue = RadixColorScale(
    light: {1: Color(0xFFFBFDFF), 2: Color(0xFFF5FAFF), 3: Color(0xFFEFF7FF), 4: Color(0xFFE1F0FF), 5: Color(0xFFD1E7FF), 6: Color(0xFFBCD9FF), 7: Color(0xFF9CC7FF), 8: Color(0xFF5EB0FF), 9: Color(0xFF0070F3), 10: Color(0xFF005DD1), 11: Color(0xFF0047A3), 12: Color(0xFF0A1F44)},
    dark: {1: Color(0xFF0B1324), 2: Color(0xFF0C162B), 3: Color(0xFF0E1B35), 4: Color(0xFF102241), 5: Color(0xFF122A50), 6: Color(0xFF163361), 7: Color(0xFF1A3F7B), 8: Color(0xFF1C5EC1), 9: Color(0xFF2F80FF), 10: Color(0xFF5393FF), 11: Color(0xFF82B1FF), 12: Color(0xFFE6F0FF)},
  );

  static const green = RadixColorScale(
    light: {1: Color(0xFFFAFEFB), 2: Color(0xFFF2FBF5), 3: Color(0xFFE9F7ED), 4: Color(0xFFDDF2E4), 5: Color(0xFFCCEBD6), 6: Color(0xFFB7E1C5), 7: Color(0xFF91D3A8), 8: Color(0xFF53BE7A), 9: Color(0xFF2CB463), 10: Color(0xFF239552), 11: Color(0xFF1D7A44), 12: Color(0xFF0F2E1E)},
    dark: {1: Color(0xFF0A1A12), 2: Color(0xFF0D2217), 3: Color(0xFF112A1D), 4: Color(0xFF163526), 5: Color(0xFF1B4230), 6: Color(0xFF1F503B), 7: Color(0xFF246448), 8: Color(0xFF2A845C), 9: Color(0xFF2CB463), 10: Color(0xFF4ED38A), 11: Color(0xFF77E3A7), 12: Color(0xFFD9F7E6)},
  );

  static const red = RadixColorScale(
    light: {1: Color(0xFFFFFCFC), 2: Color(0xFFFFF7F7), 3: Color(0xFFFFEFEE), 4: Color(0xFFFFE5E4), 5: Color(0xFFFFDAD7), 6: Color(0xFFFFCDC8), 7: Color(0xFFFFB7AF), 8: Color(0xFFFF8A80), 9: Color(0xFFDE3A3A), 10: Color(0xFFB82F2F), 11: Color(0xFF891F1F), 12: Color(0xFF3F0C0C)},
    dark: {1: Color(0xFF240B0B), 2: Color(0xFF2B0C0C), 3: Color(0xFF350E0E), 4: Color(0xFF411010), 5: Color(0xFF501212), 6: Color(0xFF611616), 7: Color(0xFF7B1A1A), 8: Color(0xFFB21D1D), 9: Color(0xFFDE3A3A), 10: Color(0xFFFF6A6A), 11: Color(0xFFFF9B9B), 12: Color(0xFFFFE5E5)},
  );

  static const amber = RadixColorScale(
    light: {1: Color(0xFFFFFEFA), 2: Color(0xFFFFFBEB), 3: Color(0xFFFFF7D1), 4: Color(0xFFFFF0A6), 5: Color(0xFFFFE482), 6: Color(0xFFFFD359), 7: Color(0xFFFFB224), 8: Color(0xFFEE9900), 9: Color(0xFFC78000), 10: Color(0xFFA16900), 11: Color(0xFF7B5100), 12: Color(0xFF2E1F00)},
    dark: {1: Color(0xFF221500), 2: Color(0xFF2A1A00), 3: Color(0xFF332100), 4: Color(0xFF3F2900), 5: Color(0xFF4D3300), 6: Color(0xFF5D3F00), 7: Color(0xFF7A5200), 8: Color(0xFFB37800), 9: Color(0xFFEE9900), 10: Color(0xFFFFB224), 11: Color(0xFFFFD359), 12: Color(0xFFFFF0CC)},
  );

  static const violet = RadixColorScale(
    light: {1: Color(0xFFFEFCFF), 2: Color(0xFFFBF5FF), 3: Color(0xFFF7ECFF), 4: Color(0xFFEFDBFF), 5: Color(0xFFE5C7FF), 6: Color(0xFFD7AEFF), 7: Color(0xFFC18DFF), 8: Color(0xFF9B5BFF), 9: Color(0xFF6E33F5), 10: Color(0xFF5E2ACF), 11: Color(0xFF4B22A6), 12: Color(0xFF1C0E35)},
    dark: {1: Color(0xFF130A1F), 2: Color(0xFF170D27), 3: Color(0xFF1F1133), 4: Color(0xFF271A40), 5: Color(0xFF322354), 6: Color(0xFF402D6C), 7: Color(0xFF553A8E), 8: Color(0xFF7A53CF), 9: Color(0xFF9A6FFF), 10: Color(0xFFB391FF), 11: Color(0xFFD4BFFF), 12: Color(0xFFF2ECFF)},
  );

  static const teal = RadixColorScale(
    light: {1: Color(0xFFFAFEFE), 2: Color(0xFFF1FBFB), 3: Color(0xFFE6F7F7), 4: Color(0xFFD8F1F1), 5: Color(0xFFC4E8E8), 6: Color(0xFFAEE0E0), 7: Color(0xFF8FD3D3), 8: Color(0xFF56C0C0), 9: Color(0xFF12A2A2), 10: Color(0xFF0E8585), 11: Color(0xFF0B6B6B), 12: Color(0xFF062626)},
    dark: {1: Color(0xFF071818), 2: Color(0xFF0A1F1F), 3: Color(0xFF0D2626), 4: Color(0xFF123232), 5: Color(0xFF174040), 6: Color(0xFF1E5050), 7: Color(0xFF2A6868), 8: Color(0xFF3B8C8C), 9: Color(0xFF12A2A2), 10: Color(0xFF3BC0C0), 11: Color(0xFF74D6D6), 12: Color(0xFFE0F6F6)},
  );

  // Aliased palettes for broader Radix parity.
  static RadixColorScale get slate => gray;
  static RadixColorScale get mauve => gray;
  static RadixColorScale get sage => green;
  static RadixColorScale get sand => gray;
  static RadixColorScale get tomato => red;
  static RadixColorScale get crimson => red;
  static RadixColorScale get pink => red;
  static RadixColorScale get plum => violet;
  static RadixColorScale get purple => violet;
  static RadixColorScale get indigo => blue;
  static RadixColorScale get cyan => teal;
  static RadixColorScale get grass => green;
  static RadixColorScale get brown => amber;
  static RadixColorScale get bronze => amber;
  static RadixColorScale get gold => amber;
  static RadixColorScale get sky => blue;
  static RadixColorScale get mint => teal;
  static RadixColorScale get lime => green;
  static RadixColorScale get yellow => amber;
  static RadixColorScale get orange => amber;
}

MaterialColor _material(RadixColorScale scale, {Brightness brightness = Brightness.light}) =>
    scale.toMaterialColor(brightness: brightness);

/// Simple MaterialColor access for Radix palettes.
/// Usage: `RadixColors.green.shade700` or `RadixColors.dark.green.shade700`.
class RadixColors {
  RadixColors._();

  // Simple MaterialColor (light)
  static final MaterialColor gray = _material(RadixColorScales.gray);
  static final MaterialColor slate = _material(RadixColorScales.slate);
  static final MaterialColor mauve = _material(RadixColorScales.mauve);
  static final MaterialColor sand = _material(RadixColorScales.sand);
  static final MaterialColor blue = _material(RadixColorScales.blue);
  static final MaterialColor indigo = _material(RadixColorScales.indigo);
  static final MaterialColor violet = _material(RadixColorScales.violet);
  static final MaterialColor purple = _material(RadixColorScales.purple);
  static final MaterialColor green = _material(RadixColorScales.green);
  static final MaterialColor grass = _material(RadixColorScales.grass);
  static final MaterialColor teal = _material(RadixColorScales.teal);
  static final MaterialColor cyan = _material(RadixColorScales.cyan);
  static final MaterialColor red = _material(RadixColorScales.red);
  static final MaterialColor tomato = _material(RadixColorScales.tomato);
  static final MaterialColor crimson = _material(RadixColorScales.crimson);
  static final MaterialColor pink = _material(RadixColorScales.pink);
  static final MaterialColor amber = _material(RadixColorScales.amber);
  static final MaterialColor orange = _material(RadixColorScales.orange);
  static final MaterialColor yellow = _material(RadixColorScales.yellow);
  static final MaterialColor brown = _material(RadixColorScales.brown);
  static final MaterialColor bronze = _material(RadixColorScales.bronze);
  static final MaterialColor gold = _material(RadixColorScales.gold);

  /// Dark swatches with `.shade*` access.
  static RadixDarkColors get dark => RadixDarkColors._();

  /// Back-compat: access full 12-step scales.
  static final RadixColorScale grayScale = RadixColorScales.gray;
  static final RadixColorScale slateScale = RadixColorScales.slate;
  static final RadixColorScale mauveScale = RadixColorScales.mauve;
  static final RadixColorScale sandScale = RadixColorScales.sand;
  static final RadixColorScale blueScale = RadixColorScales.blue;
  static final RadixColorScale indigoScale = RadixColorScales.indigo;
  static final RadixColorScale greenScale = RadixColorScales.green;
  static final RadixColorScale grassScale = RadixColorScales.grass;
  static final RadixColorScale redScale = RadixColorScales.red;
  static final RadixColorScale amberScale = RadixColorScales.amber;
  static final RadixColorScale violetScale = RadixColorScales.violet;
  static final RadixColorScale tealScale = RadixColorScales.teal;
  static final RadixColorScale purpleScale = RadixColorScales.purple;
  static final RadixColorScale cyanScale = RadixColorScales.cyan;
  static final RadixColorScale tomatoScale = RadixColorScales.tomato;
  static final RadixColorScale crimsonScale = RadixColorScales.crimson;
  static final RadixColorScale pinkScale = RadixColorScales.pink;
  static final RadixColorScale orangeScale = RadixColorScales.orange;
  static final RadixColorScale yellowScale = RadixColorScales.yellow;
  static final RadixColorScale brownScale = RadixColorScales.brown;
  static final RadixColorScale bronzeScale = RadixColorScales.bronze;
  static final RadixColorScale goldScale = RadixColorScales.gold;
}

class RadixDarkColors {
  RadixDarkColors._();
  final MaterialColor gray = _material(RadixColorScales.gray, brightness: Brightness.dark);
  final MaterialColor slate = _material(RadixColorScales.slate, brightness: Brightness.dark);
  final MaterialColor mauve = _material(RadixColorScales.mauve, brightness: Brightness.dark);
  final MaterialColor sand = _material(RadixColorScales.sand, brightness: Brightness.dark);
  final MaterialColor blue = _material(RadixColorScales.blue, brightness: Brightness.dark);
  final MaterialColor indigo = _material(RadixColorScales.indigo, brightness: Brightness.dark);
  final MaterialColor violet = _material(RadixColorScales.violet, brightness: Brightness.dark);
  final MaterialColor purple = _material(RadixColorScales.purple, brightness: Brightness.dark);
  final MaterialColor green = _material(RadixColorScales.green, brightness: Brightness.dark);
  final MaterialColor grass = _material(RadixColorScales.grass, brightness: Brightness.dark);
  final MaterialColor teal = _material(RadixColorScales.teal, brightness: Brightness.dark);
  final MaterialColor cyan = _material(RadixColorScales.cyan, brightness: Brightness.dark);
  final MaterialColor red = _material(RadixColorScales.red, brightness: Brightness.dark);
  final MaterialColor tomato = _material(RadixColorScales.tomato, brightness: Brightness.dark);
  final MaterialColor crimson = _material(RadixColorScales.crimson, brightness: Brightness.dark);
  final MaterialColor pink = _material(RadixColorScales.pink, brightness: Brightness.dark);
  final MaterialColor amber = _material(RadixColorScales.amber, brightness: Brightness.dark);
  final MaterialColor orange = _material(RadixColorScales.orange, brightness: Brightness.dark);
  final MaterialColor yellow = _material(RadixColorScales.yellow, brightness: Brightness.dark);
  final MaterialColor brown = _material(RadixColorScales.brown, brightness: Brightness.dark);
  final MaterialColor bronze = _material(RadixColorScales.bronze, brightness: Brightness.dark);
  final MaterialColor gold = _material(RadixColorScales.gold, brightness: Brightness.dark);
}

/// Semantic roles computed from scales.
class RadixSemanticColors {
  final Color background;
  final Color surface;
  final Color subtleSurface;
  final Color text;
  final Color textSubtle;
  final Color border;
  final Color accent;
  final Color accentText;
  final Color success;
  final Color warning;
  final Color danger;

  const RadixSemanticColors({required this.background, required this.surface, required this.subtleSurface, required this.text, required this.textSubtle, required this.border, required this.accent, required this.accentText, required this.success, required this.warning, required this.danger});
}
