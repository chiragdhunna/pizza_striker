import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/app_config.dart';
import '../../models/app_user.dart';
import '../../models/pizza_event.dart';
import '../../services/api_client.dart';
import '../../services/pizza_service.dart';
import '../../services/user_service.dart';
import '../../theme/app_colors.dart';
import '../../widgets/async_views.dart';
import '../../widgets/pizza_strike_meter.dart';
import '../../widgets/user_avatar.dart';
import 'add_strike_screen.dart';
import 'pizza_payment_screen.dart';

class _AdminData {
  _AdminData(this.users, this.pending);
  final List<AppUser> users;
  final List<PizzaEvent> pending;
}

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  late final ApiClient _api;
  late Future<_AdminData> _future;
  final _searchController = TextEditingController();
  String _query = '';
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _api = context.read<ApiClient>();
    _future = _load();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  Future<_AdminData> _load() async {
    final users = await UserService(_api).listUsers(size: 100, search: _query.isEmpty ? null : _query);
    final pending = await PizzaService(_api).listAll(status: 'pending', size: 100);
    return _AdminData(users.items, pending.items);
  }

  Future<void> _refresh() async {
    setState(() => _future = _load());
    await _future;
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      setState(() {
        _query = value.trim();
        _future = _load();
      });
    });
  }

  Future<void> _addStrike(AppUser user) async {
    final changed = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => AddStrikeScreen(user: user)),
    );
    if (changed == true) _refresh();
  }

  Future<void> _confirmPayment(PizzaEvent event, AppUser? user) async {
    final done = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => PizzaPaymentScreen(event: event, user: user)),
    );
    if (done == true) _refresh();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      appBar: AppBar(title: const Text('Admin')),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<_AdminData>(
          future: _future,
          builder: (context, snap) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  decoration: InputDecoration(
                    hintText: 'Search employees',
                    prefixIcon: const Icon(Icons.search_rounded),
                  ),
                ),
                const SizedBox(height: 16),
                if (snap.connectionState == ConnectionState.waiting)
                  const Padding(padding: EdgeInsets.only(top: 80), child: LoadingView())
                else if (snap.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: ErrorView(message: snap.error.toString(), onRetry: _refresh),
                  )
                else ...[
                  ..._buildContent(context, snap.data!, colors),
                ],
              ],
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildContent(BuildContext context, _AdminData data, AppColors colors) {
    final userMap = {for (final u in data.users) u.id: u};
    final widgets = <Widget>[];

    if (data.pending.isNotEmpty) {
      widgets.add(_sectionHeader('Owes Pizza'));
      for (final e in data.pending) {
        final u = userMap[e.userId];
        widgets.add(_OwesPizzaRow(
          name: u?.displayName ?? 'User #${e.userId}',
          initials: u?.initials ?? '?',
          onConfirm: () => _confirmPayment(e, u),
        ));
        widgets.add(const SizedBox(height: 10));
      }
      widgets.add(const SizedBox(height: 8));
    }

    widgets.add(_sectionHeader('Employee List'));
    if (data.users.isEmpty) {
      widgets.add(const Padding(
        padding: EdgeInsets.only(top: 24),
        child: EmptyView(message: 'No employees found.', icon: Icons.person_off_rounded),
      ));
    } else {
      for (final u in data.users) {
        widgets.add(_EmployeeRow(user: u, onAddStrike: () => _addStrike(u)));
        widgets.add(const SizedBox(height: 10));
      }
    }
    return widgets;
  }

  Widget _sectionHeader(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 4),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: context.colors.textPrimary,
          ),
        ),
      );
}

class _OwesPizzaRow extends StatelessWidget {
  const _OwesPizzaRow({required this.name, required this.initials, required this.onConfirm});
  final String name;
  final String initials;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.divider),
      ),
      child: Row(
        children: [
          UserAvatar(initials: initials, radius: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w700)),
                Text('Owes a pizza party 🍕', style: TextStyle(color: colors.textSecondary, fontSize: 13)),
              ],
            ),
          ),
          TextButton(onPressed: onConfirm, child: const Text('Confirm')),
        ],
      ),
    );
  }
}

class _EmployeeRow extends StatelessWidget {
  const _EmployeeRow({required this.user, required this.onAddStrike});
  final AppUser user;
  final VoidCallback onAddStrike;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.divider),
      ),
      child: Row(
        children: [
          UserAvatar(initials: user.initials, radius: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(user.displayName,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w700)),
                    ),
                    if (user.isAdmin) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(
                          color: colors.primary.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text('admin',
                            style: TextStyle(color: colors.primary, fontSize: 10, fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                PizzaStrikeMeter(current: user.currentStrikes, total: AppConfig.strikeThreshold, size: 16),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: onAddStrike,
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.danger,
              minimumSize: const Size(96, 40),
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            child: const Text('Add Strike', style: TextStyle(fontSize: 13)),
          ),
        ],
      ),
    );
  }
}
