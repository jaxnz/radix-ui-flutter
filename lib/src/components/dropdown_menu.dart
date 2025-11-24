import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';

/// Base class for dropdown entries.
sealed class RadixDropdownEntry {
  const RadixDropdownEntry();
}

/// A selectable dropdown item.
class RadixDropdownItem extends RadixDropdownEntry {
  final String label;
  final VoidCallback? onSelected;
  final bool disabled;
  final IconData? icon;
  final String? shortcut;
  final bool destructive;

  const RadixDropdownItem({
    required this.label,
    this.onSelected,
    this.disabled = false,
    this.icon,
    this.shortcut,
    this.destructive = false,
  }) : super();
}

/// Visual separator inside a dropdown menu.
class RadixDropdownSeparator extends RadixDropdownEntry {
  const RadixDropdownSeparator() : super();
}

/// Radix-styled dropdown menu using a trigger widget and overlayed content.
class RadixDropdownMenu extends StatefulWidget {
  final Widget button;
  final List<RadixDropdownEntry> entries;
  final double? width;

  const RadixDropdownMenu({
    super.key,
    required this.button,
    required this.entries,
    this.width,
  });

  @override
  State<RadixDropdownMenu> createState() => _RadixDropdownMenuState();
}

class _RadixDropdownMenuState extends State<RadixDropdownMenu> {
  final LayerLink _link = LayerLink();
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

  void _toggle() {
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
    final menuWidth = widget.width ?? 200;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        final theme = RadixTheme.of(context);
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _toggle,
                child: const SizedBox.shrink(),
              ),
            ),
            CompositedTransformFollower(
              link: _link,
              offset: Offset(0, size.height + 6),
              showWhenUnlinked: false,
              child: _RadixDropdownPanel(
                entries: widget.entries,
                width: menuWidth,
                theme: theme,
                onClose: _toggle,
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
    return CompositedTransformTarget(
      link: _link,
      child: GestureDetector(
        onTap: _toggle,
        behavior: HitTestBehavior.opaque,
        child: IgnorePointer(
          ignoring: true, // let the outer detector handle taps/hover
          child: widget.button,
        ),
      ),
    );
  }
}

class _RadixDropdownPanel extends StatelessWidget {
  final List<RadixDropdownEntry> entries;
  final double width;
  final RadixThemeData theme;
  final VoidCallback onClose;

  const _RadixDropdownPanel({
    required this.entries,
    required this.width,
    required this.theme,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final c = theme.colors;

    return Material(
      elevation: 10,
      color: c.surface,
      shadowColor: Colors.black.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(theme.radius2),
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: width, maxWidth: width, maxHeight: 320),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(theme.radius2),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 6),
            itemCount: entries.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final entry = entries[index];
              if (entry is RadixDropdownSeparator) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Divider(height: 1, color: c.border),
                );
              }
              if (entry is RadixDropdownItem) {
                return _RadixDropdownRow(
                  entry: entry,
                  theme: theme,
                  onClose: onClose,
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

class _RadixDropdownRow extends StatefulWidget {
  final RadixDropdownItem entry;
  final RadixThemeData theme;
  final VoidCallback onClose;

  const _RadixDropdownRow({
    required this.entry,
    required this.theme,
    required this.onClose,
  });

  @override
  State<_RadixDropdownRow> createState() => _RadixDropdownRowState();
}

class _RadixDropdownRowState extends State<_RadixDropdownRow> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final entry = widget.entry;
    final c = widget.theme.colors;
    final disabled = entry.disabled;
    final bg = _hover && !disabled ? c.subtleSurface : Colors.transparent;
    final textColor = disabled ? c.textSubtle : (entry.destructive ? c.danger : c.text);
    final shortcutColor = disabled ? c.textSubtle : c.textSubtle;

    return InkWell(
      onTap: disabled
          ? null
          : () {
              entry.onSelected?.call();
              widget.onClose();
            },
      onHover: (v) => setState(() => _hover = v),
      child: Container(
        decoration: BoxDecoration(color: bg),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          children: [
            if (entry.icon != null) ...[
              Icon(entry.icon, size: 18, color: textColor),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: Text(
                entry.label,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (entry.shortcut != null) ...[
              const SizedBox(width: 8),
              Text(
                entry.shortcut!,
                style: TextStyle(color: shortcutColor, fontSize: 12),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
