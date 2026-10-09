import 'package:flutter_starter/core/error/result.dart';
import 'package:flutter_starter/features/auth/domain/entities/auth_session.dart';

/// Authentication data access. Implementations own both the credential check
/// and the persistence of the resulting session.
abstract interface class AuthRepository {
  /// Whether a stored session exists.
  Future<bool> hasSession();

  /// Validates [email] and [password], storing the session on success.
  Future<Result<AuthSession>> login({
    required String email,
    required String password,
  });

  /// Clears the stored session.
  Future<void> logout();
}
