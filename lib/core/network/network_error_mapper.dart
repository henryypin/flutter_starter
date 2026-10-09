import 'package:dio/dio.dart';
import 'package:flutter_starter/core/error/failure.dart';

/// Maps arbitrary errors, mainly [DioException], to domain [Failure]s.
class NetworkErrorMapper {
  const NetworkErrorMapper();

  /// Maps [error] to the closest matching [Failure].
  Failure map(Object error) {
    if (error is Failure) {
      return error;
    }
    if (error is DioException) {
      return _mapDioException(error);
    }
    return UnknownFailure('An unexpected error occurred.', cause: error);
  }

  Failure _mapDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return NetworkFailure('The request timed out.', cause: error);
      case DioExceptionType.connectionError:
        return NetworkFailure('Could not reach the server.', cause: error);
      case DioExceptionType.badCertificate:
        return NetworkFailure(
          'The server certificate is not trusted.',
          cause: error,
        );
      case DioExceptionType.cancel:
        return NetworkFailure('The request was cancelled.', cause: error);
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode == 401 || statusCode == 403) {
          return AuthFailure('The request was not authorised.', cause: error);
        }
        return ServerFailure(
          'The server returned an error (${statusCode ?? 'unknown'}).',
          statusCode: statusCode,
          cause: error,
        );
      case DioExceptionType.unknown:
        return UnknownFailure(
          error.message ?? 'An unexpected error occurred.',
          cause: error,
        );
    }
  }
}
