import '../models/app_notification.dart';
import '../models/paginated.dart';
import 'api_client.dart';

/// In-app notification endpoints.
class NotificationService {
  NotificationService(this._api);
  final ApiClient _api;

  Future<Paginated<AppNotification>> list({
    int page = 1,
    int size = 30,
    bool unreadOnly = false,
  }) async {
    final query = <String, dynamic>{'page': page, 'size': size, 'unread_only': unreadOnly};
    final data = await _api.getJson('/api/notifications', query: query);
    return Paginated<AppNotification>.fromJson(
      Map<String, dynamic>.from(data as Map),
      (e) => AppNotification.fromJson(e),
    );
  }

  Future<int> unreadCount() async {
    final data = await _api.getJson('/api/notifications/unread-count');
    return (Map<String, dynamic>.from(data as Map)['count'] as num?)?.toInt() ?? 0;
  }

  Future<void> markRead(int id) async {
    await _api.postJson('/api/notifications/$id/read');
  }

  Future<void> markAllRead() async {
    await _api.postJson('/api/notifications/read-all');
  }
}
