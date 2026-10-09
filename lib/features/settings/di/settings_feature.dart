import 'package:flutter_starter/core/storage/key_value_storage.dart';
import 'package:flutter_starter/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:get_it/get_it.dart';

/// Registers the settings feature: the [SettingsCubit] singleton.
void registerSettingsFeature(GetIt getIt) {
  getIt.registerLazySingleton<SettingsCubit>(
    () => SettingsCubit(getIt<KeyValueStorage>()),
    dispose: (cubit) => cubit.close(),
  );
}
