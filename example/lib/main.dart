import 'package:flutter/material.dart';
import 'package:radix_ui_flutter/radix_ui_flutter.dart';
import 'tabs/team.dart';
import 'tabs/settings.dart';
import 'tabs/billing.dart';
import 'tabs/reports.dart';
import 'tabs/components.dart';

void main() {
  // Optional: set navigatorKey to enable RadixUI global helpers (confirm/toast)
  RadixUI.setNavigatorKey(GlobalKey<NavigatorState>());
  runApp(const ExampleApp());
}

class ExampleApp extends StatefulWidget {
  const ExampleApp({super.key});

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  ThemeMode _mode = ThemeMode.dark;

  void _toggleTheme() {
    setState(() {
      _mode = _mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    final base = RadixThemeData(
        brightness: Brightness.light,
        grayScale: RadixColorScales.mauve,
        brandScale: RadixColorScales.violet);
    return MaterialApp(
      navigatorKey: RadixUI.navigatorKey,
      title: 'Radix UI Flutter Example',
      theme: base.toMaterialTheme(),
      darkTheme: base.copyWith(brightness: Brightness.dark).toMaterialTheme(),
      themeMode: _mode,
      builder: RadixUI.appBuilder(base),
      home:
          DemoPage(onToggleTheme: _toggleTheme, dark: _mode == ThemeMode.dark),
    );
  }
}

class DemoPage extends StatefulWidget {
  final VoidCallback? onToggleTheme;
  final bool dark;
  const DemoPage({super.key, this.onToggleTheme, this.dark = false});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool comments = true;
  bool favorites = true;
  bool newDocs = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radix UI Flutter Example'),
        actions: [
          IconButton(
              tooltip: widget.dark ? 'Switch to light' : 'Switch to dark',
              onPressed: widget.onToggleTheme,
              icon: Icon(widget.dark ? Icons.dark_mode : Icons.light_mode))
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: RadixUI.tabs(
              tabs: [
                const RadixTab(label: 'Team'),
                const RadixTab(label: 'Settings'),
                const RadixTab(label: 'Billing'),
                const RadixTab(label: 'Reports'),
                const RadixTab(label: 'Components'),
              ],
              children: [
                const TeamTab(),
                SettingsTab(
                  comments: comments,
                  favorites: favorites,
                  newDocs: newDocs,
                  onComments: (v) => setState(() => comments = v),
                  onFavorites: (v) => setState(() => favorites = v),
                  onNewDocs: (v) => setState(() => newDocs = v),
                ),
                const BillingTab(),
                const ReportsTab(),
                const ComponentsTab(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
