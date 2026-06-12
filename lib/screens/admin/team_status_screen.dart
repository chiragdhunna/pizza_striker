import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/app_user.dart';
import '../../models/dashboard.dart';
import '../../models/pizza_event.dart';
import '../../services/api_client.dart';
import '../../services/dashboard_service.dart';
import '../../services/pizza_service.dart';
import '../../services/user_service.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/async_views.dart';
import '../../widgets/pizza_strike_meter.dart';
import '../../widgets/section_card.dart';
import '../../widgets/user_avatar.dart';
import 'pizza_payment_screen.dart';

class _TeamData {
  _TeamData(this.dashboard, this.pending, this.users);
  final Dashboard dashboard;
  final List<PizzaEvent> pending;
  final Map<int, AppUser> users;
}

class TeamStatusScreen extends StatefulWidget {
  const TeamStatusScreen({super.key});

  @override
  State<TeamStatusScreen> createState() => _TeamStatusScreenState();
}

class _TeamStatusScreenState extends State<TeamStatusScreen> {
  late final ApiClient _api;
  late Future<_TeamData> _future;

  @override
  void initState() {
    super.initState();
    _api = context.read<ApiClient>();
    _future = _load();
  }

  Future<_TeamData> _load() async {
    final dashboard = await DashboardService(_api).getDashboard();
    final pending = await PizzaService(_api).listAll(status: 'pending', size: 100);
    final users = await UserService(_api).listUsers(size: 100);
    return _TeamData(dashboard, pending.items, {for (final u in users.items) u.id: u});
  }

  Future<void> _refresh() async {
    setState(() => _future = _load());
    await _future;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: FutureBuilder<_TeamData>(
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
              final leaderboard = data.dashboard.leaderboard;
              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Center(child: const AppLogo(size: 56)),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      'TEAM STATUS',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                        color: colors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  if (data.pending.isNotEmpty)
                    _OwesBanner(
                      events: data.pending,
                      users: data.users,
                      onTap: (e, u) async {
                        final done = await Navigator.of(context).push<bool>(
                          MaterialPageRoute(builder: (_) => PizzaPaymentScreen(event: e, user: u)),
                        );
                        if (done == true) _refresh();
                      },
                    ),
                  const SizedBox(height: 18),
                  SectionCard(
                    title: 'Leaderboard',
                    child: leaderboard.isEmpty
                        ? Text('No strikes recorded yet.', style: TextStyle(color: colors.textSecondary))
                        : Column(
                            children: [
                              for (final e in leaderboard) _LeaderRow(entry: e),
                            ],
                          ),
                  ),
                  const SizedBox(height: 16),
                  SectionCard(
                    title: 'Recent Activity',
                    child: data.dashboard.recentActivity.isEmpty
                        ? Text('Nothing yet.', style: TextStyle(color: colors.textSecondary))
                        : Column(
                            children: [
                              for (final a in data.dashboard.recentActivity.take(8))
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 6),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('• ', style: TextStyle(color: colors.primary)),
                                      Expanded(child: Text(a.message, style: TextStyle(color: colors.textPrimary))),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _OwesBanner extends StatelessWidget {
  const _OwesBanner({required this.events, required this.users, required this.onTap});
  final List<PizzaEvent> events;
  final Map<int, AppUser> users;
  final void Function(PizzaEvent, AppUser?) onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final first = events.first;
    final user = users[first.userId];
    return Material(
      color: colors.owesBannerBg,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => onTap(first, user),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              UserAvatar(initials: user?.initials ?? '?', radius: 24, highlighted: true),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Owes Pizza',
                        style: TextStyle(color: colors.owesBannerText.withOpacity(0.85), fontSize: 13)),
                    Text(
                      user?.displayName ?? 'User #${first.userId}',
                      style: TextStyle(
                        color: colors.owesBannerText,
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                    if (events.length > 1)
                      Text('+${events.length - 1} more owe a party',
                          style: TextStyle(color: colors.owesBannerText.withOpacity(0.85), fontSize: 12)),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: colors.owesBannerText),
            ],
          ),
        ),
      ),
    );
  }
}

class _LeaderRow extends StatelessWidget {
  const _LeaderRow({required this.entry});
  final LeaderboardEntry entry;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(entry.displayName,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w600)),
          ),
          if (entry.currentStrikes > 0)
            PizzaStrikeMeter(current: entry.currentStrikes, total: entry.currentStrikes, size: 16)
          else
            Text('0', style: TextStyle(color: colors.textSecondary)),
          const SizedBox(width: 10),
          Text('${entry.totalStrikes} total',
              style: TextStyle(color: colors.textSecondary, fontSize: 12)),
        ],
      ),
    );
  }
}
