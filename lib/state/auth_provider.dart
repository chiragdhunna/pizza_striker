import 'package:flutter/foundation.dart';

import '../models/app_user.dart';
import '../services/api_client.dart';
import '../services/auth_service.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

/// Holds the current session and drives login / register / logout.
class AuthProvider extends ChangeNotifier {
  AuthProvider({required ApiClient api, AuthService? authService})
      : _api = api,
        _auth = authService ?? AuthService(api) {
    // When a token refresh fails deep in the API client, drop to login.
    _api.onUnauthorized = _handleUnauthorized;
  }

  final ApiClient _api;
  final AuthService _auth;

  AuthStatus status = AuthStatus.unknown;
  AppUser? user;
  bool busy = false;
  String? error;

  bool get isAdmin => user?.isAdmin ?? false;

  /// Called on startup: restore a session from stored tokens if possible.
  Future<void> bootstrap() async {
    if (await _api.tokenStore.hasTokens) {
      try {
        user = await _auth.me();
        status = AuthStatus.authenticated;
      } catch (_) {
        await _api.tokenStore.clear();
        status = AuthStatus.unauthenticated;
      }
    } else {
      status = AuthStatus.unauthenticated;
    }
    notifyListeners();
  }

  Future<bool> login(String username, String password) async {
    _setBusy(true);
    try {
      user = await _auth.login(username, password);
      status = AuthStatus.authenticated;
      error = null;
      return true;
    } on ApiException catch (e) {
      error = e.message;
      return false;
    } finally {
      _setBusy(false);
    }
  }

  Future<bool> register({
    required String email,
    required String username,
    required String password,
    String? fullName,
  }) async {
    _setBusy(true);
    try {
      user = await _auth.register(
        email: email,
        username: username,
        password: password,
        fullName: fullName,
      );
      status = AuthStatus.authenticated;
      error = null;
      return true;
    } on ApiException catch (e) {
      error = e.message;
      return false;
    } finally {
      _setBusy(false);
    }
  }

  Future<void> logout() async {
    await _auth.logout();
    user = null;
    status = AuthStatus.unauthenticated;
    notifyListeners();
  }

  /// Refresh the cached current-user (e.g. after a strike count changes).
  Future<void> refreshMe() async {
    try {
      user = await _auth.me();
      notifyListeners();
    } catch (_) {
      // ignore — keep showing the last known user
    }
  }

  void setUser(AppUser updated) {
    user = updated;
    notifyListeners();
  }

  void clearError() {
    error = null;
  }

  void _handleUnauthorized() {
    user = null;
    status = AuthStatus.unauthenticated;
    notifyListeners();
  }

  void _setBusy(bool value) {
    busy = value;
    notifyListeners();
  }
}
