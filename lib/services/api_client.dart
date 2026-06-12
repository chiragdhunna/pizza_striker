import 'package:dio/dio.dart';

import '../config/app_config.dart';
import '../models/token_pair.dart';
import 'token_store.dart';

/// A friendly, typed error surfaced to the UI.
class ApiException implements Exception {
  ApiException(this.message, {this.statusCode});
  final String message;
  final int? statusCode;

  bool get isUnauthorized => statusCode == 401;

  @override
  String toString() => message;
}

/// Thin wrapper around Dio that:
///  - prefixes the backend base URL,
///  - attaches the JWT access token,
///  - transparently refreshes the token once on a 401 and retries,
///  - converts backend `{"detail": ...}` errors into [ApiException].
class ApiClient {
  ApiClient({String? baseUrl, TokenStore? tokenStore})
      : tokenStore = tokenStore ?? TokenStore() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? AppConfig.baseUrl,
        // Generous timeouts so the first request after a free-tier cold start
        // (Render sleeps the service after ~15 min idle) doesn't fail.
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        sendTimeout: const Duration(seconds: 60),
        headers: {'Content-Type': 'application/json'},
        // We inspect status codes ourselves instead of letting Dio throw.
        validateStatus: (_) => true,
      ),
    );
  }

  late final Dio _dio;
  final TokenStore tokenStore;

  /// Invoked when refreshing fails — lets the app drop the user to login.
  void Function()? onUnauthorized;

  Future<dynamic> getJson(String path, {Map<String, dynamic>? query, bool auth = true}) async =>
      (await _send('GET', path, query: query, auth: auth)).data;

  Future<dynamic> postJson(String path, {dynamic data, bool auth = true}) async =>
      (await _send('POST', path, data: data, auth: auth)).data;

  Future<dynamic> patchJson(String path, {dynamic data, bool auth = true}) async =>
      (await _send('PATCH', path, data: data, auth: auth)).data;

  Future<dynamic> deleteJson(String path, {dynamic data, bool auth = true}) async =>
      (await _send('DELETE', path, data: data, auth: auth)).data;

  Future<Response<dynamic>> _send(
    String method,
    String path, {
    dynamic data,
    Map<String, dynamic>? query,
    bool auth = true,
    bool isRetry = false,
  }) async {
    final headers = <String, dynamic>{};
    if (auth) {
      final token = await tokenStore.accessToken;
      if (token != null) headers['Authorization'] = 'Bearer $token';
    }

    Response<dynamic> resp;
    try {
      resp = await _dio.request<dynamic>(
        path,
        data: data,
        queryParameters: query,
        options: Options(method: method, headers: headers),
      );
    } on DioException catch (e) {
      throw _networkError(e);
    }

    final status = resp.statusCode ?? 0;

    if (status == 401 && auth && !isRetry) {
      if (await _tryRefresh()) {
        return _send(method, path, data: data, query: query, auth: auth, isRetry: true);
      }
      await tokenStore.clear();
      onUnauthorized?.call();
      throw ApiException('Your session expired. Please log in again.', statusCode: 401);
    }

    if (status >= 400) {
      throw ApiException(_extractMessage(resp.data), statusCode: status);
    }
    return resp;
  }

  Future<bool> _tryRefresh() async {
    final refresh = await tokenStore.refreshToken;
    if (refresh == null) return false;
    try {
      final r = await _dio.post<dynamic>(
        '/api/auth/refresh',
        data: {'refresh_token': refresh},
        options: Options(method: 'POST'),
      );
      if (r.statusCode == 200 && r.data is Map) {
        final tokens = TokenPair.fromJson(Map<String, dynamic>.from(r.data as Map));
        await tokenStore.save(tokens.accessToken, tokens.refreshToken);
        return true;
      }
    } catch (_) {
      // fall through
    }
    return false;
  }

  String _extractMessage(dynamic data) {
    if (data is Map && data['detail'] != null) {
      final detail = data['detail'];
      if (detail is String) return detail;
      if (detail is List && detail.isNotEmpty) {
        final first = detail.first;
        if (first is Map && first['msg'] != null) return first['msg'].toString();
      }
    }
    return 'Something went wrong. Please try again.';
  }

  ApiException _networkError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return ApiException('The server took too long to respond.');
      case DioExceptionType.connectionError:
        return ApiException(
          'Could not reach the server. Check that the backend is running and '
          'that the API base URL is correct.',
        );
      default:
        return ApiException('Network error: ${e.message ?? 'unknown'}');
    }
  }
}
