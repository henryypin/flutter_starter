import 'package:dio/dio.dart';
import 'package:flutter_starter/core/network/token_provider.dart';

/// Attaches a bearer token to outgoing requests.
///
/// This interceptor does not refresh tokens; it only forwards whatever the
/// [TokenProvider] returns.
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._tokenProvider);

  final TokenProvider _tokenProvider;

  static const String _authorizationHeader = 'Authorization';

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!options.headers.containsKey(_authorizationHeader)) {
      final token = await _tokenProvider();
      if (token != null && token.isNotEmpty) {
        options.headers[_authorizationHeader] = 'Bearer $token';
      }
    }
    handler.next(options);
  }
}
