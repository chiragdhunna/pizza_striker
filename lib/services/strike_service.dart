import '../models/paginated.dart';
import '../models/strike.dart';
import '../models/strike_action_result.dart';
import 'api_client.dart';

/// Strike endpoints: employee read views + admin add/revoke.
class StrikeService {
  StrikeService(this._api);
  final ApiClient _api;

  // ---- employee ----
  Future<Paginated<Strike>> myStrikes({int page = 1, int size = 20, String? status}) async {
    final query = <String, dynamic>{'page': page, 'size': size};
    if (status != null) query['status_filter'] = status;
    final data = await _api.getJson('/api/strikes', query: query);
    return Paginated<Strike>.fromJson(
      Map<String, dynamic>.from(data as Map),
      (e) => Strike.fromJson(e),
    );
  }

  // ---- admin ----
  Future<StrikeActionResult> addStrike(int userId, String reason) async {
    final data = await _api.postJson(
      '/api/admin/strikes',
      data: {'user_id': userId, 'reason': reason},
    );
    return StrikeActionResult.fromJson(Map<String, dynamic>.from(data as Map));
  }

  Future<Strike> revokeStrike(int strikeId, {String? reason}) async {
    final data = await _api.postJson(
      '/api/admin/strikes/$strikeId/revoke',
      data: {if (reason != null && reason.trim().isNotEmpty) 'reason': reason.trim()},
    );
    return Strike.fromJson(Map<String, dynamic>.from(data as Map));
  }

  Future<Paginated<Strike>> listAll({
    int page = 1,
    int size = 20,
    int? userId,
    String? status,
  }) async {
    final query = <String, dynamic>{'page': page, 'size': size};
    if (userId != null) query['user_id'] = userId;
    if (status != null) query['status_filter'] = status;
    final data = await _api.getJson('/api/admin/strikes', query: query);
    return Paginated<Strike>.fromJson(
      Map<String, dynamic>.from(data as Map),
      (e) => Strike.fromJson(e),
    );
  }
}
