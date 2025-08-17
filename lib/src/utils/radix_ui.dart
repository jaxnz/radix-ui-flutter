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

/// Static facade for Radix helpers and theme access without passing BuildContext.
class RadixUI {
  static RadixThemeData _theme = RadixThemeData(brightness: Brightness.light);
  static GlobalKey<NavigatorState>? navigatorKey;

  /// Current resolved theme snapshot (kept in sync by [RadixScope] or [appBuilder]).
  static RadixThemeData get theme => _theme;

  /// Semantic colors based on the current resolved theme.
  static dynamic get colors => _theme.colors; // Keep type flexible if not exported

  /// Default Material text theme for the current theme.
  static TextTheme get textTheme => _theme.toMaterialTheme().textTheme;

  /// Internal: update the active theme snapshot. Called by [RadixScope] and [appBuilder].
  static void setTheme(RadixThemeData theme) {
    _theme = theme;
  }

  /// Convenience builder to plug into any MaterialApp/GetMaterialApp builder.
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

  // ---------- Convenience builders (no BuildContext required) ----------

  static RadixButton button(String label, {VoidCallback? onPressed, RadixButtonVariant variant = RadixButtonVariant.solid, RadixButtonSize size = RadixButtonSize.md, bool fullWidth = false}) => RadixButton(variant: variant, size: size, fullWidth: fullWidth, onPressed: onPressed, child: Text(label));

  // Back-compat helpers (redirect to button)
  static RadixButton solidButton(String label, {VoidCallback? onPressed}) => button(label, onPressed: onPressed, variant: RadixButtonVariant.solid);
  static RadixButton outlineButton(String label, {VoidCallback? onPressed}) => button(label, onPressed: onPressed, variant: RadixButtonVariant.outline);

  static RadixTextField textField({String? placeholder, TextEditingController? controller, bool obscureText = false}) => RadixTextField(placeholder: placeholder, controller: controller, obscureText: obscureText);

  static RadixSwitch labeledSwitch(String label, bool value, ValueChanged<bool> onChanged) => RadixSwitch(value: value, onChanged: onChanged, label: label, size: RadixSwitchSize.sm);

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
  static Widget text(String value, {TextStyle? style, TextAlign? align, int? maxLines}) => RadixText(value, style: style, align: align, maxLines: maxLines);

  static Widget heading(String value, {int level = 3}) => RadixHeading(value, level: level);

  static Widget card({Widget? header, Widget? footer, required Widget child}) => RadixCard(header: header, footer: footer, child: child);

  static Widget badge(String label, {RadixBadgeVariant variant = RadixBadgeVariant.solid}) => RadixBadge(label: label, variant: variant);

  static Widget avatar(String initials, {double size = 28}) => RadixAvatar(initials: initials, size: size);

  static Widget link(String textValue, {VoidCallback? onTap}) => RadixLink(textValue, onTap: onTap);

  static Widget separator() => const RadixSeparator();

  // Inputs & choices
  static Widget checkbox({required bool value, ValueChanged<bool?>? onChanged, String? label}) => RadixCheckbox(value: value, onChanged: onChanged, label: label);

  static Widget radioGroup<T>({required T groupValue, required ValueChanged<T?> onChanged, required List<RadixRadioOption<T>> options}) => RadixRadioGroup<T>(groupValue: groupValue, onChanged: onChanged, options: options);

  static Widget select<T>({required T? value, required List<RadixSelectOption<T>> options, ValueChanged<T?>? onChanged}) => RadixSelect<T>(value: value, options: options, onChanged: onChanged);

  // Ranges & status
  static Widget slider({required double value, required ValueChanged<double> onChanged, double max = 100}) => RadixSlider(value: value, onChanged: onChanged, max: max);

  static Widget progress({required double value}) => RadixProgress(value: value);

  // Navigation & structure
  static Widget tabs({required List<RadixTab> tabs, int initialIndex = 0, EdgeInsetsGeometry contentPadding = const EdgeInsets.fromLTRB(0, 16, 0, 24)}) => RadixTabs(tabs: tabs, initialIndex: initialIndex, contentPadding: contentPadding);

  static Widget tooltip({required String message, required Widget child}) => RadixTooltip(message: message, child: child);

  static Future<void> openDialog(RadixDialog dialog) async {
    final ctx = _navContext;
    if (ctx == null) return;
    await RadixDialog.show(ctx, dialog);
  }

  static Widget accordion({required List<RadixAccordionItem> items}) => RadixAccordion(items: items);

  static Widget toggle({required bool initialOn, required ValueChanged<bool> onChanged, required Widget child}) => RadixToggle(initialOn: initialOn, onChanged: onChanged, child: child);

  static Widget toggleGroup<T>({required Set<T> selected, required ValueChanged<Set<T>> onChanged, required List<RadixToggleOption<T>> options, bool multiple = true}) => RadixToggleGroup<T>(selected: selected, onChanged: onChanged, options: options, multiple: multiple);

  static Widget label(String textValue) => RadixLabel(textValue);

  static Widget alert({required String title, String? description, RadixAlertVariant variant = RadixAlertVariant.success}) => RadixAlert(title: title, description: description, variant: variant);

  /// Wraps a subtree with the Radix toast overlay manager.
  static Widget toastOverlay({required Widget child}) => RadixToastOverlay(child: child);

  // ---------- Context-free UX helpers (require navigatorKey wiring) ----------

  /// Call once in your app setup if you want global dialog/toast helpers.
  /// Example:
  ///   MaterialApp(
  ///     navigatorKey: RadixUI.navigatorKey = GlobalKey<NavigatorState>(),
  ///     builder: RadixUI.appBuilder(base),
  ///   )
  static void setNavigatorKey(GlobalKey<NavigatorState> key) {
    navigatorKey = key;
  }

  static BuildContext? get _navContext => navigatorKey?.currentContext;

  static Future<T?> confirm<T>({required String title, String? description, String confirmText = 'Confirm', String cancelText = 'Cancel'}) {
    final ctx = _navContext;
    if (ctx == null) return Future<T?>.value(null);
    return radixConfirmDialog<T>(context: ctx, title: title, description: description, confirmText: confirmText, cancelText: cancelText);
  }

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
