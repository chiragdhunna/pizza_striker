import '../models/dashboard.dart';
import 'api_client.dart';

/// Admin dashboard endpoints.
class DashboardService {
  DashboardService(this._api);
  final ApiClient _api;

  Future<Dashboard> getDashboard() async {
    final data = await _api.getJson('/api/admin/dashboard');
    return Dashboard.fromJson(Map<String, dynamic>.from(data as Map));
  }

  Future<List<TrendPoint>> trends({int days = 7}) async {
    final data = await _api.getJson('/api/admin/dashboard/trends', query: {'days': days});
    return (data as List<dynamic>)
        .map((e) => TrendPoint.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }
}
