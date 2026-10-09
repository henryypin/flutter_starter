import 'package:flutter_starter/app/config/app_config.dart';
import 'package:flutter_starter/app/di/injector.dart';
import 'package:get_it/get_it.dart';

/// The app's service locator, re-exported for tests.
///
/// Tests may reach the container directly; production code under `lib/` must
/// keep `getIt` inside the approved DI boundaries (see
/// `scripts/di_boundary_guard.sh`).
final GetIt testGetIt = getIt;

/// Registers the full dependency graph for a test run.
///
/// Defaults to [AppConfig.test], which enables demo data and in-memory
/// storage. Call it from `setUp` and reset the container in `tearDown` with
/// `await getIt.reset()`.
Future<void> configureTestDependencies({AppConfig? config}) =>
    configureDependencies(config ?? AppConfig.test());

/// Replaces the container's registration for [T] with [instance].
///
/// Use it after [configureTestDependencies] to swap one real dependency for a
/// fake while leaving the rest of the graph untouched.
Future<void> overrideRegistration<T extends Object>(T instance) async {
  if (getIt.isRegistered<T>()) {
    await getIt.unregister<T>();
  }
  getIt.registerSingleton<T>(instance);
}
