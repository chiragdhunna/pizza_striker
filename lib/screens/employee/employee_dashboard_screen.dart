import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../config/app_config.dart';
import '../../models/pizza_event.dart';
import '../../models/strike.dart';
import '../../services/api_client.dart';
import '../../services/pizza_service.dart';
import '../../services/strike_service.dart';
import '../../state/auth_provider.dart';
import '../../theme/app_colors.dart';
import '../../widgets/async_views.dart';
import '../../widgets/pizza_strike_meter.dart';
import '../../widgets/section_card.dart';
import '../../widgets/user_avatar.dart';

class _DashboardData {
  _DashboardData(this.strikes, this.owedEvents);
  final List<Strike> strikes;
  final List<PizzaEvent> owedEvents;
}

class EmployeeDashboardScreen extends StatefulWidget {
  const EmployeeDashboardScreen({super.key});

  @override
  State<EmployeeDashboardScreen> createState() => _EmployeeDashboardScreenState();
}

class _EmployeeDashboardScreenState extends State<EmployeeDashboardScreen> {
  late final ApiClient _api;
  late Future<_DashboardData> _future;

  @override
  void initState() {
    super.initState();
    _api = context.read<ApiClient>();
    _future = _load();
  }

  Future<_DashboardData> _load() async {
    await context.read<AuthProvider>().refreshMe();
    final strikes = await StrikeService(_api).myStrikes(size: 50);
    final events = await PizzaService(_api).myEvents(size: 20);
    final owed = events.items.where((e) => e.isPending).toList();
    return _DashboardData(strikes.items, owed);
  }

  Future<void> _refresh() async {
    setState(() => _future = _load());
    await _future;
  }

  String _fmt(DateTime? d) => d == null ? '' : DateFormat('MMM d, yyyy').format(d.toLocal());

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final user = context.watch<AuthProvider>().user;

    return Scaffold(
      appBar: AppBar(title: const Text('My Status')),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<_DashboardData>(
          future: _future,
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const LoadingView();
            }
            if (snap.hasError) {
              return ListView(children: [
                const SizedBox(height: 160),
                ErrorView(message: snap.error.toString(), onRetry: _refresh),
              ]);
            }
            final data = snap.data!;
            if (user == null) return const LoadingView();

            return ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              children: [
                Center(
                  child: Column(
                    children: [
                      UserAvatar(initials: user.initials, radius: 40, highlighted: true),
                      const SizedBox(height: 12),
                      Text(
                        user.displayName,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: colors.textPrimary,
                        ),
                      ),
                      Text('@${user.username}', style: TextStyle(color: colors.textSecondary)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SectionCard(
                  title: 'Strikes',
                  child: Row(
                    children: [
                      PizzaStrikeMeter(current: user.currentStrikes, size: 30),
                      const Spacer(),
                      Text(
                        '${user.currentStrikes}/${AppConfig.strikeThreshold}',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: colors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                if (data.owedEvents.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  SectionCard(
                    title: 'Owes Pizza 🍕',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: data.owedEvents
                          .map((e) => Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Text(
                                  'You owe a pizza party — triggered ${_fmt(e.createdAt)} '
                                  '(${e.strikeCount} strikes).',
                                  style: TextStyle(color: colors.textPrimary),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                SectionCard(
                  title: 'Strike History',
                  child: data.strikes.isEmpty
                      ? Text('No strikes yet — keep it up! 🎉',
                          style: TextStyle(color: colors.textSecondary))
                      : Column(
                          children: [
                            for (final s in data.strikes) _StrikeRow(strike: s, dateText: _fmt(s.createdAt)),
                          ],
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _StrikeRow extends StatelessWidget {
  const _StrikeRow({required this.strike, required this.dateText});
  final Strike strike;
  final String dateText;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    Color statusColor;
    switch (strike.status) {
      case 'revoked':
        statusColor = Colors.green;
        break;
      case 'cleared':
        statusColor = colors.primary;
        break;
      default:
        statusColor = colors.danger;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 96,
            child: Text(dateText, style: TextStyle(color: colors.textSecondary, fontSize: 13)),
          ),
          Expanded(
            child: Text(strike.reason, style: TextStyle(color: colors.textPrimary)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              strike.status,
              style: TextStyle(color: statusColor, fontSize: 11, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
