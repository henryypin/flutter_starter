import 'package:dio/dio.dart';
import 'package:flutter_starter/app/config/app_config.dart';
import 'package:flutter_starter/app/di/injector.dart';
import 'package:flutter_starter/core/error/failure_message_resolver.dart';
import 'package:flutter_starter/core/error/result.dart';
import 'package:flutter_starter/core/feedback/app_feedback.dart';
import 'package:flutter_starter/core/logging/app_logger.dart';
import 'package:flutter_starter/core/network/api_client.dart';
import 'package:flutter_starter/core/storage/in_memory_key_value_storage.dart';
import 'package:flutter_starter/core/storage/in_memory_secure_storage.dart';
import 'package:flutter_starter/core/storage/key_value_storage.dart';
import 'package:flutter_starter/core/storage/secure_storage.dart';
import 'package:flutter_starter/features/auth/data/datasources/demo_auth_data_source.dart';
import 'package:flutter_starter/features/auth/domain/entities/auth_session.dart';
import 'package:flutter_starter/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_starter/features/auth/domain/usecases/check_session.dart';
import 'package:flutter_starter/features/auth/domain/usecases/login_with_credentials.dart';
import 'package:flutter_starter/features/auth/domain/usecases/logout.dart';
import 'package:flutter_starter/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_starter/features/profile/domain/repositories/profile_repository.dart';
import 'package:flutter_starter/features/profile/domain/usecases/load_profile.dart';
import 'package:flutter_starter/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter_starter/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/test_dependencies.dart';

void main() {
  final config = AppConfig.test();

  setUp(() async {
    await configureDependencies(config);
  });

  tearDown(() async {
    await getIt.reset();
  });

  test('registers the expected types for the test environment', () {
    expect(getIt.isRegistered<AppLogger>(), isTrue);
    expect(getIt.isRegistered<FailureMessageResolver>(), isTrue);
    expect(getIt.isRegistered<AppFeedback>(), isTrue);
    expect(getIt.isRegistered<SecureStorage>(), isTrue);
    expect(getIt.isRegistered<KeyValueStorage>(), isTrue);
    expect(getIt.isRegistered<Dio>(), isTrue);
    expect(getIt.isRegistered<ApiClient>(), isTrue);
    expect(getIt.isRegistered<AuthRepository>(), isTrue);
    expect(getIt.isRegistered<CheckSession>(), isTrue);
    expect(getIt.isRegistered<LoginWithCredentials>(), isTrue);
    expect(getIt.isRegistered<Logout>(), isTrue);
    expect(getIt.isRegistered<AuthCubit>(), isTrue);
    expect(getIt.isRegistered<ProfileRepository>(), isTrue);
    expect(getIt.isRegistered<LoadProfile>(), isTrue);
    expect(getIt.isRegistered<ProfileCubit>(), isTrue);
    expect(getIt.isRegistered<SettingsCubit>(), isTrue);
  });

  test('AuthCubit and SettingsCubit are singletons', () {
    expect(identical(getIt<AuthCubit>(), getIt<AuthCubit>()), isTrue);
    expect(identical(getIt<SettingsCubit>(), getIt<SettingsCubit>()), isTrue);
  });

  test('ProfileCubit is a factory', () {
    final first = getIt<ProfileCubit>();
    final second = getIt<ProfileCubit>();
    addTearDown(first.close);
    addTearDown(second.close);

    expect(identical(first, second), isFalse);
  });

  test('test environment selects the demo auth source', () async {
    final repository = getIt<AuthRepository>();

    final success = await repository.login(
      email: DemoAuthDataSource.demoEmail,
      password: DemoAuthDataSource.demoPassword,
    );
    expect(success, isA<Success<AuthSession>>());

    final failure = await repository.login(
      email: 'someone@example.com',
      password: 'wrong-password',
    );
    expect(failure.failureOrNull?.message, 'Invalid email or password');
  });

  test('test environment selects in-memory storage', () {
    expect(getIt<SecureStorage>(), isA<InMemorySecureStorage>());
    expect(getIt<KeyValueStorage>(), isA<InMemoryKeyValueStorage>());
  });

  test('configureDependencies can run twice', () async {
    await configureDependencies(config);

    expect(getIt.isRegistered<AuthCubit>(), isTrue);
    expect(getIt<SecureStorage>(), isA<InMemorySecureStorage>());
  });

  test('overrideRegistration replaces a resolved dependency', () async {
    final feedback = _FakeFeedback();
    await overrideRegistration<AppFeedback>(feedback);

    expect(identical(getIt<AppFeedback>(), feedback), isTrue);
  });
}

/// [AppFeedback] stand-in that records nothing, used to prove
/// [overrideRegistration] swaps the registered instance.
class _FakeFeedback implements AppFeedback {
  @override
  void showError(String message) {}

  @override
  void showInfo(String message) {}

  @override
  void showSuccess(String message) {}

  @override
  void showWarning(String message) {}
}
