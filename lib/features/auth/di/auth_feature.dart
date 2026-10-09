import 'package:flutter_starter/core/error/failure_message_resolver.dart';
import 'package:flutter_starter/core/storage/secure_storage.dart';
import 'package:flutter_starter/features/auth/data/datasources/demo_auth_data_source.dart';
import 'package:flutter_starter/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_starter/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_starter/features/auth/domain/usecases/check_session.dart';
import 'package:flutter_starter/features/auth/domain/usecases/login_with_credentials.dart';
import 'package:flutter_starter/features/auth/domain/usecases/logout.dart';
import 'package:flutter_starter/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:get_it/get_it.dart';

/// Registers the auth feature: repository, use cases, and the [AuthCubit].
///
/// When [enableDemoData] is set the demo credentials back the repository.
void registerAuthFeature(GetIt getIt, {required bool enableDemoData}) {
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      getIt<SecureStorage>(),
      enableDemoData ? const DemoAuthDataSource() : null,
    ),
  );
  getIt.registerLazySingleton<CheckSession>(
    () => CheckSession(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<LoginWithCredentials>(
    () => LoginWithCredentials(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<Logout>(() => Logout(getIt<AuthRepository>()));
  getIt.registerLazySingleton<AuthCubit>(
    () => AuthCubit(
      getIt<CheckSession>(),
      getIt<LoginWithCredentials>(),
      getIt<Logout>(),
      getIt<FailureMessageResolver>(),
    ),
    dispose: (cubit) => cubit.close(),
  );
}
