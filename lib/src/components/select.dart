import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';

enum RadixSelectSize { sm, md, lg }

/// Radix-styled select field with a custom trigger and overlay menu.
class RadixSelect<T> extends StatefulWidget {
  /// Current selected value.
  final T? value;

  /// Available [options] rendered as items.
  final List<RadixSelectOption<T>> options;

  /// Called when the value changes.
  final ValueChanged<T?>? onChanged;

  /// Optional hint shown when no value is selected.
  final String? hint;

  /// Control size (sm/md/lg). Adjusts padding and font size.
  final RadixSelectSize size;

  /// Creates a Radix select.
  const RadixSelect({super.key, required this.value, required this.options, this.onChanged, this.hint, this.size = RadixSelectSize.md});

  @override
  State<RadixSelect<T>> createState() => _RadixSelectState<T>();
}

class _RadixSelectState<T> extends State<RadixSelect<T>> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _open = false;

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _open = false;
  }

  void _toggleOpen() {
    if (_open) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
    setState(() {});
  }

  void _showOverlay() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) return;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        final t = RadixTheme.of(context);
        return Stack(
          children: [
            // Tap outside to close
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _toggleOpen,
                child: const SizedBox.shrink(),
              ),
            ),
            CompositedTransformFollower(
              link: _layerLink,
              offset: Offset(0, size.height + 4),
              showWhenUnlinked: false,
              child: Material(
                color: Colors.transparent,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: size.width,
                    maxWidth: size.width,
                    maxHeight: 260,
                  ),
                  child: _RadixSelectMenu<T>(
                    options: widget.options,
                    value: widget.value,
                    onChanged: (v) {
                      widget.onChanged?.call(v);
                      _toggleOpen();
                    },
                    theme: t,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    overlay.insert(_overlayEntry!);
    _open = true;
  }

  @override
  Widget build(BuildContext context) {
    final t = RadixTheme.of(context);
    final c = t.colors;

    EdgeInsetsGeometry padding;
    double fontSize;
    switch (widget.size) {
      case RadixSelectSize.sm:
        padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 8);
        fontSize = 13;
        break;
      case RadixSelectSize.md:
        padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 10);
        fontSize = 14;
        break;
      case RadixSelectSize.lg:
        padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 14);
        fontSize = 16;
        break;
    }
    final hasValue = widget.value != null;
    final selected = hasValue
        ? widget.options.firstWhere(
            (o) => o.value == widget.value,
            orElse: () => widget.options.first,
          )
        : null;

    final Color borderColor = _open ? c.accent : c.border;

    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleOpen,
        child: Container(
          decoration: BoxDecoration(
            color: c.surface,
            borderRadius: BorderRadius.circular(t.radius1),
            border: Border.all(color: borderColor),
          ),
          padding: padding,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Text(
                  hasValue ? selected!.label : (widget.hint ?? ''),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: hasValue ? c.text : c.textSubtle,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                _open ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                size: 18,
                color: c.textSubtle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A select item option.
class RadixSelectOption<T> {
  /// Display label.
  final String label;

  /// Backing value.
  final T value;

  /// Creates a select option with [label] and [value].
  const RadixSelectOption({required this.label, required this.value});
}

class _RadixSelectMenu<T> extends StatelessWidget {
  final List<RadixSelectOption<T>> options;
  final T? value;
  final ValueChanged<T?> onChanged;
  final RadixThemeData theme;

  const _RadixSelectMenu({
    required this.options,
    required this.value,
    required this.onChanged,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final c = theme.colors;

    return Material(
      color: c.surface,
      elevation: 8,
      borderRadius: BorderRadius.circular(theme.radius1),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 4),
        shrinkWrap: true,
        children: [
          for (final opt in options)
            _RadixSelectMenuItem(
              label: opt.label,
              selected: value != null && value == opt.value,
              onTap: () => onChanged(opt.value),
              colors: c,
            ),
        ],
      ),
    );
  }
}

class _RadixSelectMenuItem extends StatelessWidget {
  final String label;
  final bool selected;
  final dynamic colors;
  final VoidCallback onTap;

  const _RadixSelectMenuItem({
    required this.label,
    required this.selected,
    required this.colors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color accent = colors.accent;
    final Color text = colors.text;

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: selected ? accent.withValues(alpha: 0.12) : Colors.transparent,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(
          children: [
            Icon(
              Icons.check,
              size: 16,
              color: selected ? accent : Colors.transparent,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: text,
                fontSize: 14,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
