import 'package:flutter/widgets.dart';
import 'package:flutter_starter/app/app.dart';
import 'package:flutter_starter/app/config/app_config.dart';
import 'package:flutter_starter/app/di/injector.dart';
import 'package:flutter_starter/app/router/app_router.dart';
import 'package:flutter_starter/core/feedback/app_feedback.dart';
import 'package:flutter_starter/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_starter/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter_starter/features/settings/presentation/cubit/settings_cubit.dart';

/// Boots the app: wires dependencies, restores auth and settings, then starts
/// the widget tree with every dependency injected through constructors.
Future<void> bootstrap(AppConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies(config);

  final authCubit = getIt<AuthCubit>();
  final settingsCubit = getIt<SettingsCubit>();
  await authCubit.checkSession();
  await settingsCubit.initialize();

  final router = createAppRouter(
    isAuthenticated: () => authCubit.stateValue.isAuthenticated,
    authCubit: authCubit,
    settingsCubit: settingsCubit,
    createProfileCubit: () => getIt<ProfileCubit>(),
    feedback: getIt<AppFeedback>(),
  );

  runApp(App(router: router, settingsCubit: settingsCubit));
}
