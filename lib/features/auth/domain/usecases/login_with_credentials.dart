import 'package:flutter_starter/core/error/result.dart';
import 'package:flutter_starter/features/auth/domain/entities/auth_session.dart';
import 'package:flutter_starter/features/auth/domain/repositories/auth_repository.dart';

/// Signs a user in with an email and password.
class LoginWithCredentials {
  const LoginWithCredentials(this._repository);

  final AuthRepository _repository;

  /// Attempts the sign-in and returns the resulting [AuthSession].
  Future<Result<AuthSession>> call({
    required String email,
    required String password,
  }) => _repository.login(email: email, password: password);
}
