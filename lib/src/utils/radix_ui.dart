import 'package:flutter/material.dart';
import '../theme/radix_theme.dart';
import '../components/button.dart';
import '../components/text_field.dart';
import '../components/switch.dart';
import '../components/card.dart';
import '../components/text.dart';
import '../components/dialog_variants.dart';
import '../components/toast_manager.dart';
import '../components/badge.dart';
import '../components/avatar.dart';
import '../components/link.dart';
import '../components/separator.dart';
import '../components/checkbox.dart';
import '../components/radio_group.dart';
import '../components/slider.dart';
import '../components/progress.dart';
import '../components/tabs.dart';
import '../components/tooltip.dart';
import '../components/dialog.dart';
import '../components/select.dart';
import '../components/accordion.dart';
import '../components/toggle.dart';
import '../components/toggle_group.dart';
import '../components/label.dart';
import '../components/alert.dart';

/// Static facade for Radix UI and theme access without passing a [BuildContext].
///
/// This API is intended to be the primary way developers consume Radix UI in apps.
/// It exposes composable builders and utilities that mirror Radix components,
/// while handling theming automatically via [appBuilder] or [RadixScope].
class RadixUI {
  static RadixThemeData _theme = RadixThemeData(brightness: Brightness.light);
  static GlobalKey<NavigatorState>? navigatorKey;

  /// Current resolved theme snapshot (kept in sync by [RadixScope] or [appBuilder]).
  static RadixThemeData get theme => _theme;

  /// Semantic colors based on the current resolved theme.
  /// Resolved semantic color tokens for the active theme.
  static dynamic get colors => _theme.colors; // Kept dynamic to avoid export coupling

  /// Default Material text theme for the current theme.
  /// Material text theme derived from the active theme.
  static TextTheme get textTheme => _theme.toMaterialTheme().textTheme;

  /// Internal: update the active theme snapshot. Called by [RadixScope] and [appBuilder].
  static void setTheme(RadixThemeData theme) {
    _theme = theme;
  }

  /// Plug this into any MaterialApp/GetMaterialApp `builder` to keep Radix UI
  /// synchronized with the resolved [Brightness].
  /// Example:
  ///   GetMaterialApp(
  ///     theme: base.toMaterialTheme(),
  ///     darkTheme: base.copyWith(brightness: Brightness.dark).toMaterialTheme(),
  ///     builder: RadixUI.appBuilder(base),
  ///   )
  static TransitionBuilder appBuilder(RadixThemeData base) {
    return (context, child) {
      final resolvedBrightness = Theme.of(context).brightness;
      final resolved = base.copyWith(brightness: resolvedBrightness);
      RadixUI.setTheme(resolved);
      return RadixTheme(data: resolved, child: child ?? const SizedBox.shrink());
    };
  }

  // ---------- Component builders (no BuildContext required) ----------

  /// Creates a Radix button.
  ///
  /// - [label]: text content of the button
  /// - [onPressed]: tap callback; if null, the button is disabled
  /// - [variant]: visual style (solid/soft/outline/ghost); defaults to solid
  /// - [size]: control size (sm/md/lg); defaults to md
  /// - [fullWidth]: if true, expands horizontally
  /// - [color]: optional accent override
  static RadixButton button(String label, {VoidCallback? onPressed, RadixButtonVariant variant = RadixButtonVariant.solid, RadixButtonSize size = RadixButtonSize.md, bool fullWidth = false, Color? color}) => RadixButton(variant: variant, size: size, fullWidth: fullWidth, color: color, onPressed: onPressed, child: Text(label));

  // Back-compat helpers (redirect to button)
  static RadixButton solidButton(String label, {VoidCallback? onPressed, Color? color}) => button(label, onPressed: onPressed, color: color, variant: RadixButtonVariant.solid);
  static RadixButton outlineButton(String label, {VoidCallback? onPressed, Color? color}) => button(label, onPressed: onPressed, color: color, variant: RadixButtonVariant.outline);

  /// Creates a Radix text field.
  ///
  /// - [placeholder]: hint text
  /// - [controller]: optional text controller
  /// - [obscureText]: hide input for passwords
  static RadixTextField textField({String? placeholder, TextEditingController? controller, bool obscureText = false}) => RadixTextField(placeholder: placeholder, controller: controller, obscureText: obscureText);

  /// A switch with a clickable [label].
  ///
  /// - [label]: displayed next to the switch
  /// - [value]: current on/off value
  /// - [onChanged]: change callback
  static RadixSwitch labeledSwitch(String label, bool value, ValueChanged<bool> onChanged) => RadixSwitch(value: value, onChanged: onChanged, label: label, size: RadixSwitchSize.sm);

  /// A standard Radix section composed of a heading, optional description, and [child].
  ///
  /// - [title]: section title
  /// - [description]: optional supporting text
  /// - [child]: section content
  static Widget section({required String title, String? description, required Widget child}) {
    final c = colors;
    return RadixCard(
      header: heading(title, level: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (description != null) ...[text(description, style: TextStyle(color: c.textSubtle)), const SizedBox(height: 10)],
          child,
        ],
      ),
    );
  }

  // ---------- Basic content helpers ----------
  /// Radix-styled text.
  static Widget text(String value, {TextStyle? style, TextAlign? align, int? maxLines}) => RadixText(value, style: style, align: align, maxLines: maxLines);

  /// Radix-styled heading. [level] ranges 1..6.
  static Widget heading(String value, {int level = 3}) => RadixHeading(value, level: level);

  /// Radix card container with optional [header] and [footer].
  static Widget card({Widget? header, Widget? footer, required Widget child}) => RadixCard(header: header, footer: footer, child: child);

  /// Radix badge with [label] and [variant].
  static Widget badge(String label, {RadixBadgeVariant variant = RadixBadgeVariant.solid}) => RadixBadge(label: label, variant: variant);

  /// Radix avatar built from [initials].
  static Widget avatar(String initials, {double size = 28}) => RadixAvatar(initials: initials, size: size);

  /// Radix-styled inline link.
  static Widget link(String textValue, {VoidCallback? onTap}) => RadixLink(textValue, onTap: onTap);

  /// Horizontal separator.
  static Widget separator() => const RadixSeparator();

  // Inputs & choices
  /// Checkbox with optional [label].
  static Widget checkbox({required bool value, ValueChanged<bool?>? onChanged, String? label}) => RadixCheckbox(value: value, onChanged: onChanged, label: label);

  /// Radio group bound to [groupValue] with [options].
  static Widget radioGroup<T>({required T groupValue, required ValueChanged<T?> onChanged, required List<RadixRadioOption<T>> options}) => RadixRadioGroup<T>(groupValue: groupValue, onChanged: onChanged, options: options);

  /// Select field with [options] and current [value].
  static Widget select<T>({required T? value, required List<RadixSelectOption<T>> options, ValueChanged<T?>? onChanged}) => RadixSelect<T>(value: value, options: options, onChanged: onChanged);

  // Ranges & status
  /// Slider with [value] in [0..max].
  static Widget slider({required double value, required ValueChanged<double> onChanged, double max = 100}) => RadixSlider(value: value, onChanged: onChanged, max: max);

  /// Linear progress indicator with [value] in [0..1].
  static Widget progress({required double value}) => RadixProgress(value: value);

  // Navigation & structure
  /// Tabs with [tabs] pages, optional [initialIndex], and [contentPadding].
  static Widget tabs({required List<RadixTab> tabs, int initialIndex = 0, EdgeInsetsGeometry contentPadding = const EdgeInsets.fromLTRB(0, 16, 0, 24)}) => RadixTabs(tabs: tabs, initialIndex: initialIndex, contentPadding: contentPadding);

  /// Tooltip wrapping [child].
  static Widget tooltip({required String message, required Widget child}) => RadixTooltip(message: message, child: child);

  /// Opens a [RadixDialog] using the configured [navigatorKey].
  static Future<void> openDialog(RadixDialog dialog) async {
    final ctx = _navContext;
    if (ctx == null) return;
    await RadixDialog.show(ctx, dialog);
  }

  /// Accordion from [items].
  static Widget accordion({required List<RadixAccordionItem> items}) => RadixAccordion(items: items);

  /// Toggle control with [initialOn] state.
  static Widget toggle({required bool initialOn, required ValueChanged<bool> onChanged, required Widget child}) => RadixToggle(initialOn: initialOn, onChanged: onChanged, child: child);

  /// Toggle group with [selected] values and [options].
  static Widget toggleGroup<T>({required Set<T> selected, required ValueChanged<Set<T>> onChanged, required List<RadixToggleOption<T>> options, bool multiple = true}) => RadixToggleGroup<T>(selected: selected, onChanged: onChanged, options: options, multiple: multiple);

  /// Form label.
  static Widget label(String textValue) => RadixLabel(textValue);

  /// Inline alert message with [variant].
  static Widget alert({required String title, String? description, RadixAlertVariant variant = RadixAlertVariant.success}) => RadixAlert(title: title, description: description, variant: variant);

  /// Wraps a subtree with the Radix toast overlay manager.
  static Widget toastOverlay({required Widget child}) => RadixToastOverlay(child: child);

  // ---------- Context-free UX helpers (require navigatorKey wiring) ----------

  /// Call once in your app setup if you want global confirm/toast actions.
  /// Example:
  ///   MaterialApp(
  ///     navigatorKey: RadixUI.navigatorKey = GlobalKey<NavigatorState>(),
  ///     builder: RadixUI.appBuilder(base),
  ///   )
  static void setNavigatorKey(GlobalKey<NavigatorState> key) {
    navigatorKey = key;
  }

  static BuildContext? get _navContext => navigatorKey?.currentContext;

  /// Shows a confirm dialog.
  /// - [title]: dialog title
  /// - [description]: optional body
  /// - [confirmText]/[cancelText]: action labels
  static Future<T?> confirm<T>({required String title, String? description, String confirmText = 'Confirm', String cancelText = 'Cancel'}) {
    final ctx = _navContext;
    if (ctx == null) return Future<T?>.value(null);
    return radixConfirmDialog<T>(context: ctx, title: title, description: description, confirmText: confirmText, cancelText: cancelText);
  }

  /// Shows a toast via [RadixToastOverlay] if present, otherwise falls back to a SnackBar.
  static void showToast(String message, {Duration duration = const Duration(seconds: 3), Color? background}) {
    final ctx = _navContext;
    if (ctx == null) return;
    final controller = RadixToastOverlay.of(ctx);
    if (controller != null) {
      controller.show(message, duration: duration, background: background);
      return;
    }
    // Fallback to SnackBar if overlay not present
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(message), duration: duration));
  }
}

/// Lightweight scope to keep [RadixUI] in sync with the resolved Material theme
/// and provide [RadixTheme] for widgets calling `RadixTheme.of(context)`.
class RadixScope extends StatelessWidget {
  final RadixThemeData baseTheme;
  final Widget child;
  const RadixScope({super.key, required this.baseTheme, required this.child});

  @override
  Widget build(BuildContext context) {
    final resolvedBrightness = Theme.of(context).brightness;
    final resolved = baseTheme.copyWith(brightness: resolvedBrightness);
    RadixUI.setTheme(resolved);
    return RadixTheme(data: resolved, child: child);
  }
}
