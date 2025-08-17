import 'package:flutter/material.dart';

class RadixCombobox<T> extends StatefulWidget {
  final List<RadixComboboxOption<T>> options;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String? hintText;

  const RadixCombobox({super.key, required this.options, this.value, this.onChanged, this.hintText});

  @override
  State<RadixCombobox<T>> createState() => _RadixComboboxState<T>();
}

class _RadixComboboxState<T> extends State<RadixCombobox<T>> {
  final LayerLink _link = LayerLink();
  final TextEditingController _controller = TextEditingController();
  OverlayEntry? _entry;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    final selected = widget.options.where((o) => o.value == widget.value).toList();
    if (selected.isNotEmpty) _controller.text = selected.first.label;
  }

  @override
  void dispose() {
    _controller.dispose();
    _hide();
    super.dispose();
  }

  List<RadixComboboxOption<T>> get _filtered {
    final q = _controller.text.toLowerCase();
    if (q.isEmpty) return widget.options;
    return widget.options.where((o) => o.label.toLowerCase().contains(q)).toList();
  }

  void _show() {
    if (_entry != null) return;
    final overlay = Overlay.of(context);
    _entry = OverlayEntry(
      builder: (context) => Positioned.fill(
        child: Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(onTap: _hide, behavior: HitTestBehavior.opaque),
            ),
            CompositedTransformFollower(
              link: _link,
              offset: const Offset(0, 8),
              showWhenUnlinked: false,
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(8),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 240, minWidth: 220),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: [
                      for (final opt in _filtered)
                        ListTile(
                          dense: true,
                          title: Text(opt.label),
                          onTap: () {
                            _controller.text = opt.label;
                            widget.onChanged?.call(opt.value);
                            _hide();
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    overlay.insert(_entry!);
    setState(() => _open = true);
  }

  void _hide() {
    _entry?.remove();
    _entry = null;
    if (_open) setState(() => _open = false);
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _link,
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(suffixIcon: Icon(_open ? Icons.arrow_drop_up : Icons.arrow_drop_down), hintText: widget.hintText),
        onTap: _show,
        onChanged: (_) {
          _hide();
          _show();
          setState(() {});
        },
      ),
    );
  }
}

class RadixComboboxOption<T> {
  final String label;
  final T value;
  const RadixComboboxOption({required this.label, required this.value});
}
