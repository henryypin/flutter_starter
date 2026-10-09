import 'package:dio/dio.dart';
import 'package:flutter_starter/core/network/auth_interceptor.dart';
import 'package:flutter_starter/core/network/token_provider.dart';

/// Builds configured [Dio] instances.
class DioFactory {
  const DioFactory({
    this.connectTimeout = const Duration(seconds: 15),
    this.receiveTimeout = const Duration(seconds: 15),
  });

  /// Timeout for establishing a connection.
  final Duration connectTimeout;

  /// Timeout for receiving a response.
  final Duration receiveTimeout;

  /// Creates a [Dio] client for [baseUrl] that authorises requests with
  /// [tokenProvider].
  Dio create({required String baseUrl, required TokenProvider tokenProvider}) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        responseType: ResponseType.json,
      ),
    );
    dio.interceptors.add(AuthInterceptor(tokenProvider));
    return dio;
  }
}
