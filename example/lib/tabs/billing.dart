import 'package:flutter/material.dart';
import 'package:radix_ui_flutter/radix_ui_flutter.dart';

class BillingTab extends StatelessWidget {
  const BillingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        RadixUI.section(
          title: 'Pricing',
          description: 'No credit card required. Every plan includes a 30-day trial of all Pro features.',
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _PricingCard(title: 'Basic', price: '\$0 / mo', members: '3 team members', cta: 'Downgrade', outline: true, features: ['Community support', 'Basic analytics', 'Single project']),
              _PricingCard(title: 'Growth', price: '\$49 / mo', members: '10 team members', cta: 'Go to Billing', outline: false, features: ['Priority support', 'Advanced analytics', 'Multiple projects', 'API access']),
              _PricingCard(title: 'Pro', price: '\$99 / mo', members: 'Unlimited team members', cta: 'Upgrade', outline: true, features: ['Dedicated success manager', 'Custom reports', 'Unlimited projects', 'SAML SSO']),
            ],
          ),
        ),
        const SizedBox(height: 20),
        RadixUI.section(
          title: 'Your company card',
          description: 'View and manage your corporate card.',
          child: RadixUI.card(
            child: Row(
              children: [
                RadixUI.avatar('SJ', size: 36),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RadixUI.text('Sophie Johnson'),
                      RadixUI.text('4929 3849 5027 1846', style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                RadixUI.badge('01 / 27', variant: RadixBadgeVariant.outline),
                const SizedBox(width: 8),
                RadixUI.button('Freeze', variant: RadixButtonVariant.ghost, onPressed: null),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        RadixUI.section(
          title: 'Invoice #3463',
          description: null,
          child: RadixUI.card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RadixUI.heading('Issued', level: 5),
                RadixUI.text('June 21, 2023'),
                const SizedBox(height: 6),
                RadixUI.heading('Due', level: 5),
                RadixUI.text('July 21, 2023'),
                const SizedBox(height: 12),
                RadixUI.heading('To', level: 4),
                RadixUI.text('Paradise Ventures'),
                RadixUI.text('742 Evergreen Terrace, Springfield, IL 62704', style: const TextStyle(fontSize: 12)),
                const SizedBox(height: 10),
                RadixUI.heading('From', level: 4),
                RadixUI.text('Rogue Widgets'),
                RadixUI.text('1600 Baker Street NW, Washington, DC 20500', style: const TextStyle(fontSize: 12)),
                const SizedBox(height: 12),
                RadixUI.text('Services', style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                RadixUI.text('Branding — \$20,000'),
                RadixUI.text('Marketing website — \$17,500'),
                const SizedBox(height: 6),
                RadixUI.text('Total — \$38,500', style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// _Section no longer used after switching to RadixUI.section

class _PricingCard extends StatelessWidget {
  final String title;
  final String price;
  final String members;
  final String cta;
  final bool outline;
  final List<String> features;
  const _PricingCard({required this.title, required this.price, required this.members, required this.cta, this.outline = false, this.features = const []});

  @override
  Widget build(BuildContext context) {
    final c = RadixTheme.of(context).colors;
    return SizedBox(
      width: 300,
      height: 320,
      child: RadixUI.card(
        header: RadixUI.heading(title, level: 3),
        footer: RadixUI.button(cta, variant: outline ? RadixButtonVariant.outline : RadixButtonVariant.solid, onPressed: () {}),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            RadixUI.text(members, style: TextStyle(color: c.textSubtle)),
            const SizedBox(height: 10),
            RadixUI.heading(price, level: 3),
            const SizedBox(height: 10),
            for (final f in features) ...[
              Row(
                children: [
                  Icon(Icons.check, size: 16, color: c.accent),
                  const SizedBox(width: 6),
                  Expanded(child: RadixUI.text(f)),
                ],
              ),
              const SizedBox(height: 6),
            ],
          ],
        ),
      ),
    );
  }
}
