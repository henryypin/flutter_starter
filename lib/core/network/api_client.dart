import 'package:dio/dio.dart';
import 'package:flutter_starter/core/error/result.dart';
import 'package:flutter_starter/core/network/network_error_mapper.dart';

/// Small HTTP client that returns [Result] values instead of throwing.
class ApiClient {
  const ApiClient(this._dio, [this._errorMapper = const NetworkErrorMapper()]);

  final Dio _dio;
  final NetworkErrorMapper _errorMapper;

  /// Sends a GET request to [path].
  Future<Result<Map<String, dynamic>>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) => _request(
    () => _dio.get<Map<String, dynamic>>(
      path,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    ),
  );

  /// Sends a POST request with [data] to [path].
  Future<Result<Map<String, dynamic>>> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) => _request(
    () => _dio.post<Map<String, dynamic>>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    ),
  );

  Future<Result<Map<String, dynamic>>> _request(
    Future<Response<Map<String, dynamic>>> Function() send,
  ) async {
    try {
      final response = await send();
      return Success(response.data ?? const <String, dynamic>{});
    } on Object catch (error, stackTrace) {
      return Failed<Map<String, dynamic>>(_errorMapper.map(error), stackTrace);
    }
  }
}
