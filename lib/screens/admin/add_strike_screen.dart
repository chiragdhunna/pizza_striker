import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../config/app_config.dart';
import '../../models/app_user.dart';
import '../../services/api_client.dart';
import '../../services/strike_service.dart';
import '../../theme/app_colors.dart';
import '../../widgets/pizza_strike_meter.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/user_avatar.dart';
import '../pizza_party_dialog.dart';

class AddStrikeScreen extends StatefulWidget {
  const AddStrikeScreen({super.key, required this.user});
  final AppUser user;

  @override
  State<AddStrikeScreen> createState() => _AddStrikeScreenState();
}

class _AddStrikeScreenState extends State<AddStrikeScreen> {
  final _reason = TextEditingController();
  DateTime _date = DateTime.now();
  bool _busy = false;

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  bool get _willTriggerParty =>
      widget.user.currentStrikes + 1 >= AppConfig.strikeThreshold;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _confirm() async {
    if (_reason.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please enter a reason.')));
      return;
    }
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    setState(() => _busy = true);
    try {
      final result =
          await StrikeService(context.read<ApiClient>()).addStrike(widget.user.id, _reason.text.trim());
      if (!mounted) return;
      if (result.pizzaPartyTriggered) {
        await showPizzaPartyDialog(
          context,
          name: widget.user.displayName,
          strikeCount: result.pizzaEvent?.strikeCount ?? AppConfig.strikeThreshold,
        );
      } else {
        messenger.showSnackBar(SnackBar(content: Text(result.message)));
      }
      navigator.pop(true);
    } catch (e) {
      setState(() => _busy = false);
      messenger.showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final user = widget.user;

    return Scaffold(
      appBar: AppBar(title: const Text('Add Strike')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            children: [
              UserAvatar(initials: user.initials, radius: 28),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.displayName,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text('Strikes  ', style: TextStyle(color: colors.textSecondary)),
                      PizzaStrikeMeter(current: user.currentStrikes, size: 18),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 26),
          Text('Reason', style: TextStyle(color: colors.textSecondary, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          TextField(
            controller: _reason,
            maxLines: 2,
            decoration: const InputDecoration(hintText: 'Enter the reason'),
          ),
          if (_willTriggerParty) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: colors.warningBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning_amber_rounded, color: colors.warningText),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'This will be strike #${AppConfig.strikeThreshold} — it triggers a pizza party! 🍕',
                      style: TextStyle(color: colors.warningText, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 20),
          Text('Date', style: TextStyle(color: colors.textSecondary, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          InkWell(
            onTap: _pickDate,
            borderRadius: BorderRadius.circular(12),
            child: InputDecorator(
              decoration: const InputDecoration(suffixIcon: Icon(Icons.calendar_today_rounded, size: 20)),
              child: Text(DateFormat('MM/dd/yyyy').format(_date)),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Note: the strike timestamp is recorded by the server automatically.',
            style: TextStyle(color: colors.textSecondary, fontSize: 12),
          ),
          const SizedBox(height: 26),
          PrimaryButton(
            label: 'Confirm Strike',
            loading: _busy,
            color: colors.danger,
            onPressed: _confirm,
          ),
        ],
      ),
    );
  }
}
