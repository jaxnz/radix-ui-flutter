import 'package:flutter/widgets.dart';
import '../theme/radix_theme.dart';

class RadixSeparator extends StatelessWidget {
  final Axis orientation;
  final double thickness;
  final double? length;

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
