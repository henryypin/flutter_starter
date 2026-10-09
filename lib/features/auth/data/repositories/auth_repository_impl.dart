import 'package:flutter_starter/core/error/failure.dart';
import 'package:flutter_starter/core/error/result.dart';
import 'package:flutter_starter/core/storage/secure_storage.dart';
import 'package:flutter_starter/core/storage/storage_keys.dart';
import 'package:flutter_starter/features/auth/data/datasources/demo_auth_data_source.dart';
import 'package:flutter_starter/features/auth/domain/entities/auth_session.dart';
import 'package:flutter_starter/features/auth/domain/repositories/auth_repository.dart';

/// [AuthRepository] that keeps the session in [SecureStorage] and checks
/// credentials against the optional [DemoAuthDataSource].
///
/// Without a demo source (non-demo environments) there is no live API yet, so
/// sign-in is reported as unavailable.
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._secureStorage, [this._demoDataSource]);

  final SecureStorage _secureStorage;
  final DemoAuthDataSource? _demoDataSource;

  @override
  Future<bool> hasSession() async {
    final token = await _secureStorage.read(key: StorageKeys.accessToken);
    return token != null && token.isNotEmpty;
  }

  @override
  Future<Result<AuthSession>> login({
    required String email,
    required String password,
  }) async {
    final demoDataSource = _demoDataSource;
    if (demoDataSource == null) {
      return const Failed<AuthSession>(
        AuthFailure('No authentication service is configured.'),
      );
    }

    final result = await demoDataSource.login(email: email, password: password);
    final session = result.valueOrNull;
    if (session == null) {
      return result;
    }

    await _secureStorage.write(
      key: StorageKeys.accessToken,
      value: session.accessToken,
    );
    return result;
  }

  @override
  Future<void> logout() async {
    await _secureStorage.delete(key: StorageKeys.accessToken);
    await _secureStorage.delete(key: StorageKeys.userId);
  }
}
