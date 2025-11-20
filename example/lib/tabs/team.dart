import 'package:flutter/material.dart';
import 'package:radix_ui_flutter/radix_ui_flutter.dart';

class TeamTab extends StatelessWidget {
  const TeamTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const RadixAlert(title: 'Invoice paid', description: 'A receipt copy was sent to accounting@example.com', variant: RadixAlertVariant.success),
        const SizedBox(height: 16),
        RadixUI.section(
          title: 'Your team',
          description: 'Invite and manage your team members.',
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [_InviteRow(), SizedBox(height: 12), _TeamRow('Emmeline Labrie', 'emmeline.labrie@example.com'), _TeamRow('Zac Wight', 'zac.wight@example.com'), _TeamRow('Poppy Nicholls', 'poppy.nicholls@example.com'), _TeamRow('Da-Xia Wu', 'da-xia.wu@example.com'), _TeamRow('Marisa Palermo', 'marisa.palermo@example.com')]),
        ),
      ],
    );
  }
}

// _Section replaced by RadixUI.section

class _TeamRow extends StatelessWidget {
  final String name;
  final String email;
  const _TeamRow(this.name, this.email);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          RadixUI.avatar(name.split(' ').map((p) => p[0]).take(2).join(), size: 28),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RadixText(name),
                RadixText(email, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          RadixUI.badge('Member', variant: RadixBadgeVariant.outline),
        ],
      ),
    );
  }
}

// _Card no longer used after switching to RadixUI.section

class _InviteRow extends StatefulWidget {
  const _InviteRow();

  @override
  State<_InviteRow> createState() => _InviteRowState();
}

class _InviteRowState extends State<_InviteRow> {
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RadixUI.textField(placeholder: 'Email address', controller: _controller, variant: RadixTextFieldVariant.surface),
        ),
        const SizedBox(width: 8),
        RadixUI.button(label: 'Invite', onPressed: () {}),
      ],
    );
  }
}
