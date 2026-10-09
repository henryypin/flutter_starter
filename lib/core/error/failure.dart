/// Domain-level error type returned by repositories and services instead of
/// throwing. Carries a short technical [message] and an optional [cause].
sealed class Failure {
  const Failure(this.message, {this.cause});

  /// Short technical description of what went wrong.
  final String message;

  /// The underlying error object, when available.
  final Object? cause;
}

/// Input did not pass validation.
final class ValidationFailure extends Failure {
  const ValidationFailure(super.message, {super.cause});
}

/// The device could not reach the network or the request timed out.
final class NetworkFailure extends Failure {
  const NetworkFailure(super.message, {super.cause});
}

/// The server answered with an error status.
final class ServerFailure extends Failure {
  const ServerFailure(super.message, {this.statusCode, super.cause});

  /// HTTP status code returned by the server, when known.
  final int? statusCode;
}

/// The caller is not authenticated or not allowed to perform the action.
final class AuthFailure extends Failure {
  const AuthFailure(super.message, {super.cause});
}

/// Local storage could not be read or written.
final class CacheFailure extends Failure {
  const CacheFailure(super.message, {super.cause});
}

/// Any error that does not match a more specific category.
final class UnknownFailure extends Failure {
  const UnknownFailure(super.message, {super.cause});
}
