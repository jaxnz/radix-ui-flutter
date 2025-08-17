import 'package:flutter/material.dart';
import 'package:radix_ui_flutter/radix_ui_flutter.dart';

class SettingsTab extends StatelessWidget {
  final bool comments;
  final bool favorites;
  final bool newDocs;
  final ValueChanged<bool> onComments;
  final ValueChanged<bool> onFavorites;
  final ValueChanged<bool> onNewDocs;

  const SettingsTab({super.key, required this.comments, required this.favorites, required this.newDocs, required this.onComments, required this.onFavorites, required this.onNewDocs});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        RadixUI.section(
          title: 'Notifications',
          description: 'Manage your notification settings.',
          child: Column(
            children: [
              _row('Comments', comments, onComments, switchLabel: 'Push'),
              const SizedBox(height: 8),
              _row('Favorites', favorites, onFavorites),
              const SizedBox(height: 8),
              _row('New documents', newDocs, onNewDocs),
            ],
          ),
        ),
        const SizedBox(height: 20),
        RadixUI.section(
          title: 'Sign up',
          description: null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const RadixText('Email address'),
              const SizedBox(height: 6),
              RadixUI.textField(placeholder: 'Enter your email'),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RadixText('Password'),
                            RadixLink('Forgot password?', onTap: () {}),
                          ],
                        ),
                        SizedBox(height: 6),
                        RadixUI.textField(obscureText: true, placeholder: 'Enter your password'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RadixUI.button('Create an account', variant: RadixButtonVariant.soft, onPressed: () {}),
                  const SizedBox(width: 10),
                  RadixUI.button('Sign in', onPressed: () {}),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _Section(
          title: 'Toast',
          description: null,
          child: RadixUI.button('Show toast', onPressed: () => RadixUI.showToast('Hello from toast')),
        ),
      ],
    );
  }

  Widget _row(String label, bool value, ValueChanged<bool> onChanged, {String? switchLabel}) {
    return Row(
      children: [
        Expanded(child: RadixText(label)),
        RadixSwitch(size: RadixSwitchSize.sm, value: value, onChanged: onChanged, label: switchLabel),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final String? description;
  final Widget child;
  const _Section({required this.title, required this.description, required this.child});

  @override
  Widget build(BuildContext context) {
    final c = RadixTheme.of(context).colors;
    return RadixCard(
      header: RadixText(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (description != null) ...[RadixText(description!, style: TextStyle(color: c.textSubtle)), const SizedBox(height: 10)],
          child,
        ],
      ),
    );
  }
}
