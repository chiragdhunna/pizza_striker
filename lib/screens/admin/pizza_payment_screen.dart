import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/app_user.dart';
import '../../models/pizza_event.dart';
import '../../services/api_client.dart';
import '../../services/pizza_service.dart';
import '../../theme/app_colors.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/section_card.dart';
import '../../widgets/user_avatar.dart';

class PizzaPaymentScreen extends StatefulWidget {
  const PizzaPaymentScreen({super.key, required this.event, required this.user});
  final PizzaEvent event;
  final AppUser? user;

  @override
  State<PizzaPaymentScreen> createState() => _PizzaPaymentScreenState();
}

class _PizzaPaymentScreenState extends State<PizzaPaymentScreen> {
  DateTime _date = DateTime.now();
  bool _busy = false;
  bool _done = false;

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
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _busy = true);
    try {
      await PizzaService(context.read<ApiClient>()).fulfill(
        widget.event.id,
        notes: 'Pizza provided on ${DateFormat('MM/dd/yyyy').format(_date)}',
      );
      if (!mounted) return;
      setState(() {
        _busy = false;
        _done = true;
      });
      await Future.delayed(const Duration(milliseconds: 1100));
      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      setState(() => _busy = false);
      messenger.showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final name = widget.user?.displayName ?? 'User #${widget.event.userId}';

    return Scaffold(
      appBar: AppBar(title: const Text('Pizza Payment')),
      body: _done
          ? _SuccessView(name: name)
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Center(
                  child: Column(
                    children: [
                      UserAvatar(initials: widget.user?.initials ?? '?', radius: 36, highlighted: true),
                      const SizedBox(height: 12),
                      Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                      Text('${widget.event.strikeCount} strikes • owes a pizza party',
                          style: TextStyle(color: colors.textSecondary)),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SectionCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Date Provided', style: TextStyle(color: colors.textSecondary)),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: _pickDate,
                        borderRadius: BorderRadius.circular(12),
                        child: InputDecorator(
                          decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.calendar_today_rounded, size: 20)),
                          child: Text(DateFormat('MM/dd/yyyy').format(_date)),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text('Photo (optional)', style: TextStyle(color: colors.textSecondary)),
                      const SizedBox(height: 8),
                      Container(
                        height: 90,
                        decoration: BoxDecoration(
                          color: colors.fieldFill,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: colors.fieldBorder),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.image_outlined, color: colors.textSecondary),
                              const SizedBox(height: 4),
                              Text('Photo upload coming soon',
                                  style: TextStyle(color: colors.textSecondary, fontSize: 12)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                PrimaryButton(label: 'Confirm Payment', loading: _busy, onPressed: _confirm),
              ],
            ),
    );
  }
}

class _SuccessView extends StatelessWidget {
  const _SuccessView({required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🍕', style: TextStyle(fontSize: 72)),
          const SizedBox(height: 12),
          Text('Success!',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: colors.primary)),
          const SizedBox(height: 6),
          Text('$name paid up. Enjoy the pizza! 🎉',
              style: TextStyle(color: colors.textSecondary)),
        ],
      ),
    );
  }
}
