import '../models/app_user.dart';
import '../models/token_pair.dart';
import 'api_client.dart';

/// Authentication endpoints: register, login, current user, logout.
class AuthService {
  AuthService(this._api);
  final ApiClient _api;

  Future<AppUser> login(String username, String password) async {
    final data = await _api.postJson(
      '/api/auth/login',
      data: {'username': username, 'password': password},
      auth: false,
    );
    return _consumeAuthResponse(data);
  }

  Future<AppUser> register({
    required String email,
    required String username,
    required String password,
    String? fullName,
  }) async {
    final data = await _api.postJson(
      '/api/auth/register',
      data: {
        'email': email,
        'username': username,
        'password': password,
        if (fullName != null && fullName.trim().isNotEmpty) 'full_name': fullName.trim(),
      },
      auth: false,
    );
    return _consumeAuthResponse(data);
  }

  Future<AppUser> me() async {
    final data = await _api.getJson('/api/auth/me');
    return AppUser.fromJson(Map<String, dynamic>.from(data as Map));
  }

  Future<void> logout() async {
    final refresh = await _api.tokenStore.refreshToken;
    try {
      if (refresh != null) {
        await _api.postJson('/api/auth/logout', data: {'refresh_token': refresh});
      }
    } catch (_) {
      // Even if the server call fails, clear local tokens below.
    }
    await _api.tokenStore.clear();
  }

  Future<AppUser> _consumeAuthResponse(dynamic data) async {
    final map = Map<String, dynamic>.from(data as Map);
    final tokens = TokenPair.fromJson(Map<String, dynamic>.from(map['tokens'] as Map));
    await _api.tokenStore.save(tokens.accessToken, tokens.refreshToken);
    return AppUser.fromJson(Map<String, dynamic>.from(map['user'] as Map));
  }
}
