import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/app_notification.dart';
import '../services/api_client.dart';
import '../services/notification_service.dart';
import '../theme/app_colors.dart';
import '../widgets/async_views.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late final NotificationService _service;
  late Future<List<AppNotification>> _future;

  @override
  void initState() {
    super.initState();
    _service = NotificationService(context.read<ApiClient>());
    _future = _load();
  }

  Future<List<AppNotification>> _load() async {
    final page = await _service.list(size: 50);
    return page.items;
  }

  Future<void> _refresh() async {
    setState(() => _future = _load());
    await _future;
  }

  Future<void> _markAll() async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await _service.markAllRead();
      await _refresh();
    } catch (e) {
      if (mounted) messenger.showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> _tap(AppNotification n) async {
    if (n.isRead) return;
    try {
      await _service.markRead(n.id);
      await _refresh();
    } catch (_) {/* ignore */}
  }

  IconData _iconFor(String type) {
    switch (type) {
      case 'strike_added':
        return Icons.warning_amber_rounded;
      case 'strike_revoked':
        return Icons.check_circle_rounded;
      case 'pizza_triggered':
        return Icons.local_pizza_rounded;
      case 'pizza_fulfilled':
        return Icons.celebration_rounded;
      default:
        return Icons.notifications_rounded;
    }
  }

  String _fmt(DateTime? d) =>
      d == null ? '' : DateFormat('MMM d, h:mm a').format(d.toLocal());

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(onPressed: _markAll, child: const Text('Mark all read')),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List<AppNotification>>(
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
            final items = snap.data!;
            if (items.isEmpty) {
              return ListView(children: const [
                SizedBox(height: 160),
                EmptyView(message: 'No notifications yet.', icon: Icons.notifications_none_rounded),
              ]);
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (context, i) {
                final n = items[i];
                return InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () => _tap(n),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: n.isRead ? colors.surface : colors.primary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: colors.divider),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(_iconFor(n.type), color: colors.primary),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(n.title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700, color: colors.textPrimary)),
                              const SizedBox(height: 2),
                              Text(n.message, style: TextStyle(color: colors.textSecondary)),
                              const SizedBox(height: 4),
                              Text(_fmt(n.createdAt),
                                  style: TextStyle(color: colors.textSecondary, fontSize: 12)),
                            ],
                          ),
                        ),
                        if (!n.isRead)
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(color: colors.primary, shape: BoxShape.circle),
                          ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 10),
            );
          },
        ),
      ),
    );
  }
}
