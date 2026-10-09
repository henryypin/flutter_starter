import 'package:flutter_starter/core/error/failure.dart';
import 'package:flutter_starter/core/error/result.dart';
import 'package:flutter_starter/features/auth/domain/entities/auth_session.dart';

/// Bundled credentials used when `AppConfig.enableDemoData` is set.
class DemoAuthDataSource {
  const DemoAuthDataSource();

  /// Email accepted by the demo source.
  static const String demoEmail = 'demo@example.com';

  /// Password accepted by the demo source.
  static const String demoPassword = 'password';

  static const String _accessToken = 'demo-access-token';

  /// Returns a session for [email] / [password] when they match the demo
  /// credentials, otherwise a [ValidationFailure] with user-facing copy.
  Future<Result<AuthSession>> login({
    required String email,
    required String password,
  }) async {
    if (email == demoEmail && password == demoPassword) {
      return const Success(AuthSession(accessToken: _accessToken));
    }
    return const Failed<AuthSession>(
      ValidationFailure('Invalid email or password'),
    );
  }
}
