import '../models/app_user.dart';
import '../models/paginated.dart';
import 'api_client.dart';

/// Profile endpoints plus admin user management.
class UserService {
  UserService(this._api);
  final ApiClient _api;

  // ---- current user ----
  Future<AppUser> me() async {
    final data = await _api.getJson('/api/users/me');
    return AppUser.fromJson(Map<String, dynamic>.from(data as Map));
  }

  Future<AppUser> updateProfile({String? fullName, String? email, String? username}) async {
    final body = <String, dynamic>{};
    if (fullName != null) body['full_name'] = fullName;
    if (email != null) body['email'] = email;
    if (username != null) body['username'] = username;
    final data = await _api.patchJson('/api/users/me', data: body);
    return AppUser.fromJson(Map<String, dynamic>.from(data as Map));
  }

  Future<void> changePassword(String currentPassword, String newPassword) async {
    await _api.postJson(
      '/api/users/me/change-password',
      data: {'current_password': currentPassword, 'new_password': newPassword},
    );
  }

  // ---- admin ----
  Future<Paginated<AppUser>> listUsers({
    int page = 1,
    int size = 20,
    String? role,
    String? search,
    bool? isActive,
  }) async {
    final query = <String, dynamic>{'page': page, 'size': size};
    if (role != null) query['role'] = role;
    if (search != null && search.trim().isNotEmpty) query['search'] = search.trim();
    if (isActive != null) query['is_active'] = isActive;
    final data = await _api.getJson('/api/admin/users', query: query);
    return Paginated<AppUser>.fromJson(
      Map<String, dynamic>.from(data as Map),
      (e) => AppUser.fromJson(e),
    );
  }

  Future<AppUser> createUser({
    required String email,
    required String username,
    required String password,
    String? fullName,
    String role = 'employee',
  }) async {
    final data = await _api.postJson('/api/admin/users', data: {
      'email': email,
      'username': username,
      'password': password,
      'role': role,
      if (fullName != null && fullName.trim().isNotEmpty) 'full_name': fullName.trim(),
    });
    return AppUser.fromJson(Map<String, dynamic>.from(data as Map));
  }

  Future<AppUser> updateUser(int id, {String? fullName, String? role, bool? isActive}) async {
    final body = <String, dynamic>{};
    if (fullName != null) body['full_name'] = fullName;
    if (role != null) body['role'] = role;
    if (isActive != null) body['is_active'] = isActive;
    final data = await _api.patchJson('/api/admin/users/$id', data: body);
    return AppUser.fromJson(Map<String, dynamic>.from(data as Map));
  }

  Future<AppUser> deactivateUser(int id) async {
    final data = await _api.deleteJson('/api/admin/users/$id');
    return AppUser.fromJson(Map<String, dynamic>.from(data as Map));
  }
}
