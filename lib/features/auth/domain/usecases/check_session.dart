import 'package:flutter_starter/features/auth/domain/repositories/auth_repository.dart';

/// Reports whether a stored session exists.
class CheckSession {
  const CheckSession(this._repository);

  final AuthRepository _repository;

  /// Returns `true` when the user already has a session.
  Future<bool> call() => _repository.hasSession();
}
