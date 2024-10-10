import 'package:dio/dio.dart';
import 'package:dio_brotli_transformer/dio_brotli_transformer.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  DioFactory({this.baseUrl = ''});

  final String baseUrl;

  final _storage = const FlutterSecureStorage();

  Future<String?> getAuthToken() {
    return _storage.read(key: 'authToken');
  }

  Dio create() {
    final dio = Dio(_configureOptions());

    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      request: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      compact: false,
    ));

    dio.interceptors.add(RetryInterceptor(
      dio: dio,
      retries: 3,
      retryDelays: [
        Duration.zero,
      ],
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        final authToken = getAuthToken();

        if (authToken != null) {
          options.headers['Authorization'] = 'Bearer $authToken';
        }

        return handler.next(options);
      },
      onError: (error, handler) {
        return handler.next(error);
      },
    ));

    dio.transformer = DioBrotliTransformer();

    return dio;
  }

  BaseOptions _configureOptions() {
    return BaseOptions(
      baseUrl: baseUrl,
      receiveTimeout: const Duration(seconds: 150),
      connectTimeout: const Duration(seconds: 150),
      sendTimeout: const Duration(seconds: 150),
      headers: <String, dynamic>{'accept-encoding': 'br'},
    );
  }
}
