import 'package:flutter_starter/app/config/app_config.dart';
import 'package:flutter_starter/app/di/modules/app_module.dart';
import 'package:flutter_starter/app/di/modules/database_module.dart';
import 'package:flutter_starter/app/di/modules/network_module.dart';
import 'package:flutter_starter/app/di/modules/storage_module.dart';
import 'package:flutter_starter/features/auth/di/auth_feature.dart';
import 'package:flutter_starter/features/profile/di/profile_feature.dart';
import 'package:flutter_starter/features/settings/di/settings_feature.dart';
import 'package:flutter_starter/features/todos/di/todos_feature.dart';
import 'package:get_it/get_it.dart';

/// The single service locator for the app.
///
/// `get_it` is only referenced inside `lib/app/di/**` and `lib/app/bootstrap.dart`;
/// everything else receives its dependencies through constructors.
final GetIt getIt = GetIt.instance;

/// Registers every dependency for [config].
///
/// Resets the container first so the function can be called again, for example
/// between tests.
Future<void> configureDependencies(AppConfig config) async {
  await getIt.reset();
  registerAppModule(getIt, config);
  await registerStorageModule(getIt, config);
  registerDatabaseModule(getIt, config);
  registerNetworkModule(getIt, config);
  registerAuthFeature(getIt, enableDemoData: config.enableDemoData);
  registerProfileFeature(getIt, enableDemoData: config.enableDemoData);
  registerSettingsFeature(getIt);
  registerTodosFeature(getIt);
}
