import 'package:flutter/widgets.dart';
import '../theme/radix_theme.dart';

/// Thin rule used to separate content.
class RadixSeparator extends StatelessWidget {
  /// Orientation of the separator. Defaults to horizontal.
  final Axis orientation;

  /// Thickness of the rule (pixels).
  final double thickness;

  /// Optional fixed length for vertical separators.
  final double? length;

  /// Creates a Radix separator.
  const RadixSeparator({super.key, this.orientation = Axis.horizontal, this.thickness = 1, this.length});

  @override
  Widget build(BuildContext context) {
    final c = RadixTheme.of(context).colors;
    final color = c.border;
    return SizedBox(
      width: orientation == Axis.horizontal ? double.infinity : thickness,
      height: orientation == Axis.horizontal ? thickness : (length ?? double.infinity),
      child: DecoratedBox(decoration: BoxDecoration(color: color)),
    );
  }
}
