import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';

/// Avatar that displays an image or fallback initials.
class RadixAvatar extends StatelessWidget {
  /// Optional network image URL.
  final String? imageUrl;

  /// Initials used when [imageUrl] is null/empty.
  final String? initials;

  /// Avatar size in logical pixels.
  final double size;

  /// Creates a Radix avatar.
  const RadixAvatar({super.key, this.imageUrl, this.initials, this.size = 32});

  @override
  Widget build(BuildContext context) {
    final t = RadixTheme.of(context);
    final c = t.colors;
    final radius = BorderRadius.circular(t.radius3);
    Widget child;
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      child = ClipRRect(
        borderRadius: radius,
        child: Image.network(imageUrl!, width: size, height: size, fit: BoxFit.cover),
      );
    } else {
      child = Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: c.subtleSurface,
          borderRadius: radius,
          border: Border.all(color: c.border),
        ),
        child: Text(
          (initials ?? '?').toUpperCase(),
          style: TextStyle(color: c.text, fontWeight: FontWeight.bold),
        ),
      );
    }
    return SizedBox(width: size, height: size, child: child);
  }
}
