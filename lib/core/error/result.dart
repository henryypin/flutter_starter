import 'package:flutter_starter/core/error/failure.dart';

/// Outcome of an operation: either [Success] with a value or [Failed] with a
/// [Failure]. Used to return errors without throwing exceptions.
sealed class Result<T> {
  const Result();

  /// Whether this result holds a value.
  bool get isSuccess => this is Success<T>;

  /// Whether this result holds a [Failure].
  bool get isFailure => this is Failed<T>;

  /// The value when successful, otherwise `null`.
  T? get valueOrNull => switch (this) {
    Success<T>(:final value) => value,
    Failed<T>() => null,
  };

  /// The failure when unsuccessful, otherwise `null`.
  Failure? get failureOrNull => switch (this) {
    Success<T>() => null,
    Failed<T>(:final failure) => failure,
  };
}

/// A successful [Result] carrying [value].
final class Success<T> extends Result<T> {
  const Success(this.value);

  final T value;
}

/// A failed [Result] carrying a [failure] and the optional [stackTrace] from
/// the original error.
final class Failed<T> extends Result<T> {
  const Failed(this.failure, [this.stackTrace]);

  final Failure failure;
  final StackTrace? stackTrace;
}
