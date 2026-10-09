import 'package:flutter_starter/features/auth/domain/repositories/auth_repository.dart';

/// Clears the stored session.
class Logout {
  const Logout(this._repository);

  final AuthRepository _repository;

  /// Removes the persisted session.
  Future<void> call() => _repository.logout();
}
