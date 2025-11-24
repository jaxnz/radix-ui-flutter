import 'package:flutter/material.dart';
import 'package:radix_ui_flutter/radix_ui_flutter.dart';

class ReportsTab extends StatelessWidget {
  const ReportsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        RadixUI.section(
          title: 'Financial performance',
          description: 'Review your company’s KPIs compared to the month before.',
          child: const _KpiGrid(
            items: [
              _KpiItem(label: 'MRR', value: '\$350K', delta: '+3.2%', trend: _Trend.up),
              _KpiItem(label: 'OpEx', value: '\$211K', delta: '+12.8%', trend: _Trend.down),
              _KpiItem(label: 'CapEx', value: '\$94K', delta: '+8.8%', trend: _Trend.up),
              _KpiItem(label: 'GPM', value: '44.6%', delta: '+1.2%', trend: _Trend.down),
              _KpiItem(label: 'NPM', value: '9.1%', delta: '0.0%', trend: _Trend.flat),
              _KpiItem(label: 'EBITDA', value: '\$443K', delta: '+4.1%', trend: _Trend.up),
              _KpiItem(label: 'CAC', value: '\$146', delta: '+11%', trend: _Trend.down),
              _KpiItem(label: 'LTV', value: '\$1,849', delta: '3%', trend: _Trend.up),
              _KpiItem(label: 'Churn', value: '12.4%', delta: '1.1%', trend: _Trend.down),
            ],
          ),
        ),
        const SizedBox(height: 20),
        RadixUI.section(
          title: 'Recent activity',
          description: 'Review what has happened over the past days.',
          child: const Column(
            children: [
              _ActivityItem(who: 'Danilo Sousa', what: 'Approved invoice #3461', when: 'June 21, 11:34 am'),
              _ActivityItem(who: 'Zahra Ambessa', what: 'Purchased 15 office chairs and 2 drum sets', when: 'June 21, 9:43 am'),
              _ActivityItem(who: 'Zahra Ambessa', what: 'Responded to your comment #7514', when: 'June 21, 9:41 am'),
              _ActivityItem(who: 'Jasper Eriksson', what: 'Created 4 invoices', when: 'June 20, 4:55 pm'),
            ],
          ),
        ),
      ],
    );
  }
}

// _Section replaced by RadixUI.section

// legacy tile removed; using _KpiTileDetailed via _KpiGrid

enum _Trend { up, down, flat }

class _KpiItem {
  final String label;
  final String value;
  final String delta;
  final _Trend trend;
  const _KpiItem({required this.label, required this.value, required this.delta, required this.trend});
}

class _KpiGrid extends StatelessWidget {
  final List<_KpiItem> items;
  const _KpiGrid({required this.items});

  // badge color computed inline in tile

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final columns = width >= 1100
        ? 3
        : width >= 800
        ? 2
        : 1;
    return LayoutBuilder(
      builder: (context, constraints) {
        final gap = 16.0;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final item in items)
              SizedBox(
                width: (constraints.maxWidth - gap * (columns - 1)) / columns,
                child: _KpiTileDetailed(item: item),
              ),
          ],
        );
      },
    );
  }
}

class _KpiTileDetailed extends StatelessWidget {
  final _KpiItem item;
  const _KpiTileDetailed({required this.item});

  @override
  Widget build(BuildContext context) {
    final c = RadixTheme.of(context).colors;
    final brightness = Theme.of(context).brightness;
    final badgeBg = item.trend == _Trend.flat
        ? c.subtleSurface
        : (item.trend == _Trend.up
                ? RadixColorScales.teal.byStep(9, brightness: brightness)
                : RadixColorScales.red.byStep(9, brightness: brightness))
            .withValues(alpha: 0.12);
    final badgeFg = item.trend == _Trend.flat
        ? c.textSubtle
        : (item.trend == _Trend.up
            ? RadixColorScales.teal.byStep(9, brightness: brightness)
            : RadixColorScales.red.byStep(9, brightness: brightness));
    return RadixUI.card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: RadixUI.text(item.label, style: TextStyle(color: c.textSubtle)),
              ),
              Container(
                decoration: BoxDecoration(color: badgeBg, borderRadius: BorderRadius.circular(9999)),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: RadixUI.text(
                  item.delta,
                  style: TextStyle(color: badgeFg, fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(item.value, style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final String who;
  final String what;
  final String when;
  const _ActivityItem({required this.who, required this.what, required this.when});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          RadixUI.avatar(who.split(' ').map((p) => p[0]).take(2).join(), size: 28),
          SizedBox(width: 10),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [RadixUI.text(who), RadixUI.text(what)]),
          ),
          RadixUI.text(when, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
