import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Minimal inline SVG icon set inspired by Radix Icons.
/// See: https://github.com/radix-ui/icons
class RadixIcon extends StatelessWidget {
  final String _svg;
  final double? size;
  final Color? color;
  final Key? iconKey;

  const RadixIcon._(this._svg, {this.size, this.color, this.iconKey});

  factory RadixIcon.chevronRight({double? size, Color? color, Key? key}) => RadixIcon._(_chevronRight, size: size, color: color, iconKey: key);
  factory RadixIcon.chevronLeft({double? size, Color? color, Key? key}) => RadixIcon._(_chevronLeft, size: size, color: color, iconKey: key);
  factory RadixIcon.check({double? size, Color? color, Key? key}) => RadixIcon._(_check, size: size, color: color, iconKey: key);
  factory RadixIcon.cross({double? size, Color? color, Key? key}) => RadixIcon._(_cross, size: size, color: color, iconKey: key);
  factory RadixIcon.info({double? size, Color? color, Key? key}) => RadixIcon._(_info, size: size, color: color, iconKey: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: SvgPicture.string(_svg, key: iconKey, width: size, height: size, colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null),
    );
  }

  static const String _template = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" xmlns="http://www.w3.org/2000/svg">{PATH}</svg>';
  static String _p(String d) => _template.replaceFirst('{PATH}', '<path d="$d" />');

  static final String _chevronRight = _p('M9 18l6-6-6-6');
  static final String _chevronLeft = _p('M15 18l-6-6 6-6');
  static final String _check = _p('M20 6L9 17l-5-5');
  static final String _cross = _p('M18 6L6 18M6 6l12 12');
  static final String _info =
      '<g>'
      '<circle cx="12" cy="12" r="10" />'
      '<path d="M12 16v-4M12 8h.01" />'
      '</g>';
}
