import 'package:dio/dio.dart';
import 'package:dio_brotli_transformer/dio_brotli_transformer.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:pizza_striker/api_base.dart';

class DioFactory {
  DioFactory({this.baseUrl = apiBase});

  final String baseUrl;

  final _storage = const FlutterSecureStorage();

  Future<String?> getAuthToken() {
    return _storage.read(key: 'authToken');
  }

  Dio create() {
    final dio = Dio(_configureOptions());

    dio.options.contentType = Headers.jsonContentType;

    dio.interceptors.add(PrettyDioLogger(
      requestBody: true,
      requestHeader: true,
      compact: false,
    ));

    dio.interceptors.add(RetryInterceptor(
      dio: dio,
      logPrint: print,
      retries: 3,
      retryDelays: [
        Duration.zero,
      ],
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final authToken = await getAuthToken();

        if (authToken != null) {
          options.headers['Authorization'] = 'Bearer $authToken';
        }

        return handler.next(options);
      },
      onError: (DioException error, handler) async {
        // todo: will finish this
        return handler.next(error);
      },
    ));

    dio.transformer = DioBrotliTransformer();

    return dio;
  }

  BaseOptions _configureOptions() => BaseOptions(
        baseUrl: baseUrl,
        receiveTimeout: const Duration(
          milliseconds: 15000,
        ),
        connectTimeout: const Duration(
          milliseconds: 15000,
        ),
        sendTimeout: const Duration(
          milliseconds: 15000,
        ),
        headers: <String, dynamic>{
          'accept-encoding': 'br',
        },
      );
}
