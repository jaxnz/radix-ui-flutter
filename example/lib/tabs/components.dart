import 'package:flutter/material.dart';
import 'package:radix_ui_flutter/radix_ui_flutter.dart';

class ComponentsTab extends StatefulWidget {
  const ComponentsTab({super.key});

  @override
  State<ComponentsTab> createState() => _ComponentsTabState();
}

class _ComponentsTabState extends State<ComponentsTab> {
  bool chk = false;
  String radio = 'one';
  bool sw = true;
  double slide = 50;
  double progress = 0.6;
  String? selectValue = 'apple';
  bool toggleOn = false;
  Set<String> toggles = {'bold'};

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        const _SectionHeader('Buttons'),
        _Card(
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              RadixUI.button(label: 'Solid', onPressed: () {}),
              RadixUI.button(label: 'Soft', variant: RadixButtonVariant.soft, onPressed: () {}),
              RadixUI.button(label: 'Outline', variant: RadixButtonVariant.outline, onPressed: () {}),
              RadixUI.button(label: 'Ghost', variant: RadixButtonVariant.ghost, onPressed: () {}),
            ],
          ),
        ),
        const SizedBox(height: 16),

        const _SectionHeader('Badges'),
        _Card(
          child: Wrap(
            spacing: 8,
            children: [
              RadixUI.badge('New'),
              RadixUI.badge('Info', variant: RadixBadgeVariant.outline),
            ],
          ),
        ),
        const SizedBox(height: 16),

        const _SectionHeader('Text & Headings'),
        _Card(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [RadixUI.heading('Heading 2', level: 2), const SizedBox(height: 6), RadixUI.text('Body text using semantic colors.')]),
        ),
        const SizedBox(height: 16),

        const _SectionHeader('Inputs'),
        _Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [RadixCheckbox(value: chk, onChanged: (v) => setState(() => chk = v ?? false), label: 'Accept')],
              ),
              const SizedBox(height: 8),
              RadixRadioGroup<String>(
                groupValue: radio,
                onChanged: (v) => setState(() => radio = v ?? 'one'),
                options: const [
                  RadixRadioOption(label: 'One', value: 'one'),
                  RadixRadioOption(label: 'Two', value: 'two'),
                ],
              ),
              const SizedBox(height: 8),
              Row(children: [RadixUI.labeledSwitch('Enable', sw, (v) => setState(() => sw = v))]),
              const SizedBox(height: 8),
              RadixUI.textField(placeholder: 'your@email.com'),
            ],
          ),
        ),
        const SizedBox(height: 16),

        const _SectionHeader('Slider & Progress'),
        _Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RadixUI.slider(value: slide, onChanged: (v) => setState(() => slide = v), max: 100),
              const SizedBox(height: 8),
              RadixUI.progress(value: progress),
            ],
          ),
        ),
        const SizedBox(height: 16),

        const _SectionHeader('Tabs'),
        _Card(
          child: SizedBox(
            height: 220,
            child: RadixUI.tabs(
              tabs: const [
                RadixTab(
                  label: 'One',
                  content: Padding(padding: EdgeInsets.all(8), child: RadixText('Tab one')),
                ),
                RadixTab(
                  label: 'Two',
                  content: Padding(padding: EdgeInsets.all(8), child: RadixText('Tab two')),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        const _SectionHeader('Tooltip & Icons'),
        _Card(
          child: RadixUI.tooltip(message: 'Info tooltip', child: const Icon(Icons.info_outline)),
        ),
        const SizedBox(height: 16),

        const _SectionHeader('Dialogs'),
        _Card(
          child: Wrap(
            spacing: 8,
            children: [
              RadixUI.button(
                label: 'Open Dialog',
                onPressed: () => RadixUI.openDialog(const RadixDialog(title: 'Dialog', content: RadixText('Hello'))),
              ),
              RadixUI.button(
                label: 'Alert',
                onPressed: () => radixAlertDialog(context: context, title: 'Alert', description: 'Pay attention.'),
              ),
              RadixUI.button(
                label: 'Confirm',
                onPressed: () => radixConfirmDialog(context: context, title: 'Confirm'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        const _SectionHeader('Select'),
        _Card(
          child: RadixUI.select<String>(
            value: selectValue,
            onChanged: (v) => setState(() => selectValue = v),
            options: const [
              RadixSelectOption(label: 'Apple', value: 'apple'),
              RadixSelectOption(label: 'Banana', value: 'banana'),
              RadixSelectOption(label: 'Cherry', value: 'cherry'),
            ],
          ),
        ),
        const SizedBox(height: 16),

        const _SectionHeader('Avatar, Separator'),
        _Card(
          child: Row(
            children: [
              RadixUI.avatar('JD'),
              const SizedBox(width: 12),
              const Expanded(child: RadixSeparator()),
            ],
          ),
        ),
        const SizedBox(height: 16),

        const _SectionHeader('Accordion'),
        _Card(
          child: RadixUI.accordion(
            items: const [
              RadixAccordionItem(header: 'Section 1', content: RadixText('Content one')),
              RadixAccordionItem(header: 'Section 2', content: RadixText('Content two')),
            ],
          ),
        ),
        const SizedBox(height: 16),

        const _SectionHeader('Toggle & ToggleGroup'),
        _Card(
          child: Column(
            children: [
              RadixUI.toggle(initialOn: toggleOn, onChanged: (v) => setState(() => toggleOn = v), child: const Text('Toggle')),
              const SizedBox(height: 8),
              RadixUI.toggleGroup<String>(
                multiple: true,
                selected: toggles,
                onChanged: (s) => setState(() => toggles = s),
                options: const [
                  RadixToggleOption(label: 'Bold', value: 'bold'),
                  RadixToggleOption(label: 'Italic', value: 'italic'),
                  RadixToggleOption(label: 'Underline', value: 'underline'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        const _SectionHeader('Label & Link'),
        _Card(child: Row(children: [const RadixLabel('Email'), const SizedBox(width: 8), RadixUI.link('Open docs')])),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) => RadixUI.heading(title, level: 2);
}

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});

  @override
  Widget build(BuildContext context) => RadixCard(child: child);
}
