import '../models/paginated.dart';
import '../models/pizza_event.dart';
import 'api_client.dart';

/// Pizza-event endpoints: employee read views + admin fulfill/cancel.
class PizzaService {
  PizzaService(this._api);
  final ApiClient _api;

  Future<Paginated<PizzaEvent>> myEvents({int page = 1, int size = 20, String? status}) async {
    final query = <String, dynamic>{'page': page, 'size': size};
    if (status != null) query['status_filter'] = status;
    final data = await _api.getJson('/api/pizza-events', query: query);
    return Paginated<PizzaEvent>.fromJson(
      Map<String, dynamic>.from(data as Map),
      (e) => PizzaEvent.fromJson(e),
    );
  }

  // ---- admin ----
  Future<Paginated<PizzaEvent>> listAll({
    int page = 1,
    int size = 20,
    int? userId,
    String? status,
  }) async {
    final query = <String, dynamic>{'page': page, 'size': size};
    if (userId != null) query['user_id'] = userId;
    if (status != null) query['status_filter'] = status;
    final data = await _api.getJson('/api/admin/pizza-events', query: query);
    return Paginated<PizzaEvent>.fromJson(
      Map<String, dynamic>.from(data as Map),
      (e) => PizzaEvent.fromJson(e),
    );
  }

  Future<PizzaEvent> fulfill(int eventId, {String? notes}) async {
    final data = await _api.postJson(
      '/api/admin/pizza-events/$eventId/fulfill',
      data: {if (notes != null && notes.trim().isNotEmpty) 'notes': notes.trim()},
    );
    return PizzaEvent.fromJson(Map<String, dynamic>.from(data as Map));
  }

  Future<PizzaEvent> cancel(int eventId) async {
    final data = await _api.postJson('/api/admin/pizza-events/$eventId/cancel');
    return PizzaEvent.fromJson(Map<String, dynamic>.from(data as Map));
  }
}
