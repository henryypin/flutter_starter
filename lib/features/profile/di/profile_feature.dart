import 'package:flutter_starter/core/error/failure_message_resolver.dart';
import 'package:flutter_starter/features/profile/data/datasources/demo_profile_data_source.dart';
import 'package:flutter_starter/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:flutter_starter/features/profile/domain/repositories/profile_repository.dart';
import 'package:flutter_starter/features/profile/domain/usecases/load_profile.dart';
import 'package:flutter_starter/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:get_it/get_it.dart';

/// Registers the profile feature: repository, use case, and the [ProfileCubit]
/// factory.
///
/// [ProfileCubit] is a factory because the profile screen creates one instance
/// and closes it on dispose. When [enableDemoData] is set the demo user backs
/// the repository.
void registerProfileFeature(GetIt getIt, {required bool enableDemoData}) {
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      enableDemoData ? const DemoProfileDataSource() : null,
    ),
  );
  getIt.registerLazySingleton<LoadProfile>(
    () => LoadProfile(getIt<ProfileRepository>()),
  );
  getIt.registerFactory<ProfileCubit>(
    () => ProfileCubit(getIt<LoadProfile>(), getIt<FailureMessageResolver>()),
  );
}
