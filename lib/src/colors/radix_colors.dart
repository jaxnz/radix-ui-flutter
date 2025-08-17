import 'package:flutter/material.dart';

/// Radix color scales (subset) for light and dark modes.
/// Values are sourced and adapted from Radix Colors.
/// See: https://github.com/radix-ui/colors
class RadixColorScale {
  final Map<int, Color> light;
  final Map<int, Color> dark;

  const RadixColorScale({required this.light, required this.dark});

  Color byStep(int step, {required Brightness brightness}) {
    final target = brightness == Brightness.dark ? dark : light;
    return target[step] ?? target.values.last;
  }
}

class RadixColors {
  RadixColors._();

  // Gray
  static const gray = RadixColorScale(
    light: {1: Color(0xFFFCFCFC), 2: Color(0xFFF8F8F8), 3: Color(0xFFF3F3F3), 4: Color(0xFFEDEDED), 5: Color(0xFFE8E8E8), 6: Color(0xFFE2E2E2), 7: Color(0xFFDBDBDB), 8: Color(0xFFC7C7C7), 9: Color(0xFF8F8F8F), 10: Color(0xFF858585), 11: Color(0xFF6F6F6F), 12: Color(0xFF171717)},
    dark: {1: Color(0xFF111111), 2: Color(0xFF191919), 3: Color(0xFF222222), 4: Color(0xFF2A2A2A), 5: Color(0xFF313131), 6: Color(0xFF3A3A3A), 7: Color(0xFF484848), 8: Color(0xFF606060), 9: Color(0xFF6E6E6E), 10: Color(0xFF7B7B7B), 11: Color(0xFFB4B4B4), 12: Color(0xFFEDEDED)},
  );

  // Blue
  static const blue = RadixColorScale(
    light: {1: Color(0xFFFBFDFF), 2: Color(0xFFF5FAFF), 3: Color(0xFFEFF7FF), 4: Color(0xFFE1F0FF), 5: Color(0xFFD1E7FF), 6: Color(0xFFBCD9FF), 7: Color(0xFF9CC7FF), 8: Color(0xFF5EB0FF), 9: Color(0xFF0070F3), 10: Color(0xFF005DD1), 11: Color(0xFF0047A3), 12: Color(0xFF0A1F44)},
    dark: {1: Color(0xFF0B1324), 2: Color(0xFF0C162B), 3: Color(0xFF0E1B35), 4: Color(0xFF102241), 5: Color(0xFF122A50), 6: Color(0xFF163361), 7: Color(0xFF1A3F7B), 8: Color(0xFF1C5EC1), 9: Color(0xFF2F80FF), 10: Color(0xFF5393FF), 11: Color(0xFF82B1FF), 12: Color(0xFFE6F0FF)},
  );

  // Green
  static const green = RadixColorScale(
    light: {1: Color(0xFFFAFEFB), 2: Color(0xFFF2FBF5), 3: Color(0xFFE9F7ED), 4: Color(0xFFDDF2E4), 5: Color(0xFFCCEBD6), 6: Color(0xFFB7E1C5), 7: Color(0xFF91D3A8), 8: Color(0xFF53BE7A), 9: Color(0xFF2CB463), 10: Color(0xFF239552), 11: Color(0xFF1D7A44), 12: Color(0xFF0F2E1E)},
    dark: {1: Color(0xFF0A1A12), 2: Color(0xFF0D2217), 3: Color(0xFF112A1D), 4: Color(0xFF163526), 5: Color(0xFF1B4230), 6: Color(0xFF1F503B), 7: Color(0xFF246448), 8: Color(0xFF2A845C), 9: Color(0xFF2CB463), 10: Color(0xFF4ED38A), 11: Color(0xFF77E3A7), 12: Color(0xFFD9F7E6)},
  );

  // Red
  static const red = RadixColorScale(
    light: {1: Color(0xFFFFFCFC), 2: Color(0xFFFFF7F7), 3: Color(0xFFFFEFEE), 4: Color(0xFFFFE5E4), 5: Color(0xFFFFDAD7), 6: Color(0xFFFFCDC8), 7: Color(0xFFFFB7AF), 8: Color(0xFFFF8A80), 9: Color(0xFFDE3A3A), 10: Color(0xFFB82F2F), 11: Color(0xFF891F1F), 12: Color(0xFF3F0C0C)},
    dark: {1: Color(0xFF240B0B), 2: Color(0xFF2B0C0C), 3: Color(0xFF350E0E), 4: Color(0xFF411010), 5: Color(0xFF501212), 6: Color(0xFF611616), 7: Color(0xFF7B1A1A), 8: Color(0xFFB21D1D), 9: Color(0xFFDE3A3A), 10: Color(0xFFFF6A6A), 11: Color(0xFFFF9B9B), 12: Color(0xFFFFE5E5)},
  );

  // Amber
  static const amber = RadixColorScale(
    light: {1: Color(0xFFFFFEFA), 2: Color(0xFFFFFBEB), 3: Color(0xFFFFF7D1), 4: Color(0xFFFFF0A6), 5: Color(0xFFFFE482), 6: Color(0xFFFFD359), 7: Color(0xFFFFB224), 8: Color(0xFFEE9900), 9: Color(0xFFC78000), 10: Color(0xFFA16900), 11: Color(0xFF7B5100), 12: Color(0xFF2E1F00)},
    dark: {1: Color(0xFF221500), 2: Color(0xFF2A1A00), 3: Color(0xFF332100), 4: Color(0xFF3F2900), 5: Color(0xFF4D3300), 6: Color(0xFF5D3F00), 7: Color(0xFF7A5200), 8: Color(0xFFB37800), 9: Color(0xFFEE9900), 10: Color(0xFFFFB224), 11: Color(0xFFFFD359), 12: Color(0xFFFFF0CC)},
  );

  // Extended palettes (subset examples expanded with more steps would go here).
  // Add more scales: slate, mauve, sage, sand, tomato, crimson, pink, plum,
  // purple, violet, indigo, cyan, teal, grass, brown, bronze, gold, sky,
  // mint, lime, yellow, orange.
  // Note: For brevity, only a few are included now. More can be mapped
  // from Radix Colors tokens one-to-one.

  static const violet = RadixColorScale(
    light: {1: Color(0xFFFEFCFF), 2: Color(0xFFFBF5FF), 3: Color(0xFFF7ECFF), 4: Color(0xFFEFDBFF), 5: Color(0xFFE5C7FF), 6: Color(0xFFD7AEFF), 7: Color(0xFFC18DFF), 8: Color(0xFF9B5BFF), 9: Color(0xFF6E33F5), 10: Color(0xFF5E2ACF), 11: Color(0xFF4B22A6), 12: Color(0xFF1C0E35)},
    dark: {1: Color(0xFF130A1F), 2: Color(0xFF170D27), 3: Color(0xFF1F1133), 4: Color(0xFF271A40), 5: Color(0xFF322354), 6: Color(0xFF402D6C), 7: Color(0xFF553A8E), 8: Color(0xFF7A53CF), 9: Color(0xFF9A6FFF), 10: Color(0xFFB391FF), 11: Color(0xFFD4BFFF), 12: Color(0xFFF2ECFF)},
  );

  static const teal = RadixColorScale(
    light: {1: Color(0xFFFAFEFE), 2: Color(0xFFF1FBFB), 3: Color(0xFFE6F7F7), 4: Color(0xFFD8F1F1), 5: Color(0xFFC4E8E8), 6: Color(0xFFAEE0E0), 7: Color(0xFF8FD3D3), 8: Color(0xFF56C0C0), 9: Color(0xFF12A2A2), 10: Color(0xFF0E8585), 11: Color(0xFF0B6B6B), 12: Color(0xFF062626)},
    dark: {1: Color(0xFF071818), 2: Color(0xFF0A1F1F), 3: Color(0xFF0D2626), 4: Color(0xFF123232), 5: Color(0xFF174040), 6: Color(0xFF1E5050), 7: Color(0xFF2A6868), 8: Color(0xFF3B8C8C), 9: Color(0xFF12A2A2), 10: Color(0xFF3BC0C0), 11: Color(0xFF74D6D6), 12: Color(0xFFE0F6F6)},
  );

  // Aliased palettes for broader Radix parity
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
