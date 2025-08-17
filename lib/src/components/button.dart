import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';

enum RadixButtonVariant { solid, soft, outline, ghost }

enum RadixButtonSize { sm, md, lg }

/// A Radix-styled button supporting multiple visual variants and sizes.
class RadixButton extends StatelessWidget {
  /// The button label/content. Typically a [Text] or an [Icon] + [Text].
  final Widget child;

  /// Called when the button is tapped. If null, the button is disabled.
  final VoidCallback? onPressed;

  /// Visual style of the button. Defaults to [RadixButtonVariant.solid].
  final RadixButtonVariant variant;

  /// Size of the button. Controls padding and icon size.
  final RadixButtonSize size;

  /// If true, the button expands to fill the available horizontal space.
  final bool fullWidth;

  /// Optional color override for the button's accent/tint.
  final Color? color;

  /// Optional focus node used for keyboard focus management.
  final FocusNode? focusNode;

  /// Optional key assigned to the underlying [InkWell].
  final Key? buttonKey;

  /// Creates a Radix-styled button.
  const RadixButton({super.key, required this.child, this.onPressed, this.variant = RadixButtonVariant.solid, this.size = RadixButtonSize.md, this.fullWidth = false, this.color, this.focusNode, this.buttonKey});

  EdgeInsetsGeometry _padding(RadixButtonSize s) {
    switch (s) {
      case RadixButtonSize.sm:
        return const EdgeInsets.symmetric(horizontal: 10, vertical: 8);
      case RadixButtonSize.md:
        return const EdgeInsets.symmetric(horizontal: 14, vertical: 10);
      case RadixButtonSize.lg:
        return const EdgeInsets.symmetric(horizontal: 18, vertical: 12);
    }
  }

  BorderRadius _radius(RadixThemeData t) => BorderRadius.circular(t.radius2);

  @override
  Widget build(BuildContext context) {
    final t = RadixTheme.of(context);
    final colors = t.colors;
    final bgAccent = color ?? colors.accent;
    final primaryText = colors.accentText;
    final surface = colors.surface;
    final text = colors.text;
    final borderColor = colors.border;

    Color background;
    Color foreground;
    Color? overlay;
    BorderSide? border;

    switch (variant) {
      case RadixButtonVariant.solid:
        background = bgAccent;
        foreground = primaryText;
        overlay = primaryText.withValues(alpha: 0.08);
        border = BorderSide(color: bgAccent.withValues(alpha: 0.8));
        break;
      case RadixButtonVariant.soft:
        background = bgAccent.withValues(alpha: 0.12);
        foreground = bgAccent;
        overlay = bgAccent.withValues(alpha: 0.08);
        border = BorderSide(color: bgAccent.withValues(alpha: 0.24));
        break;
      case RadixButtonVariant.outline:
        background = surface;
        foreground = text;
        overlay = text.withValues(alpha: 0.04);
        border = BorderSide(color: borderColor);
        break;
      case RadixButtonVariant.ghost:
        background = Colors.transparent;
        foreground = text;
        overlay = text.withValues(alpha: 0.06);
        border = BorderSide(color: Colors.transparent);
        break;
    }

    final padding = _padding(size);
    final shape = RoundedRectangleBorder(borderRadius: _radius(t), side: border);

    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: fullWidth ? double.infinity : 0),
      child: Material(
        color: background,
        shape: shape,
        child: InkWell(
          key: buttonKey,
          focusNode: focusNode,
          onTap: onPressed,
          borderRadius: _radius(t),
          splashColor: overlay,
          hoverColor: overlay,
          highlightColor: overlay,
          child: Padding(
            padding: padding,
            child: DefaultTextStyle.merge(
              style: TextStyle(color: foreground, fontWeight: FontWeight.w600),
              child: IconTheme.merge(
                data: IconThemeData(
                  color: foreground,
                  size: size == RadixButtonSize.sm
                      ? 16
                      : size == RadixButtonSize.md
                      ? 18
                      : 20,
                ),
                child: Center(child: child),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
