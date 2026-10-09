import 'package:flutter_starter/core/error/failure.dart';

/// Turns a [Failure] into English copy safe to show to the user.
class FailureMessageResolver {
  const FailureMessageResolver();

  /// Returns a user-facing message for [failure].
  String resolve(Failure failure) => switch (failure) {
    ValidationFailure(:final message) => message,
    NetworkFailure() => 'Please check your internet connection and try again.',
    ServerFailure() =>
      'Something went wrong on the server. Please try again later.',
    AuthFailure() => 'Your session has expired. Please sign in again.',
    CacheFailure() => 'Saved data could not be loaded.',
    UnknownFailure() => 'An unexpected error occurred. Please try again.',
  };
}
