import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/app/router/app_route.dart';
import 'package:flutter_starter/design/app_theme.dart';
import 'package:flutter_starter/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:kaisel/kaisel.dart';
import 'package:toastification/toastification.dart';

/// Root widget. Everything it needs is passed in through the constructor; no
/// service locator is read here.
class App extends StatelessWidget {
  const App({super.key, required this.router, required this.settingsCubit});

  /// App-lifetime router.
  final KaiselRouterConfig<AppRoute> router;

  /// Supplies the persisted [ThemeMode].
  final SettingsCubit settingsCubit;

  @override
  Widget build(BuildContext context) {
    return BlocSignalBuilder<SettingsCubit, ThemeMode>(
      bloc: settingsCubit,
      builder: (context, themeMode) => ToastificationWrapper(
        child: MaterialApp.router(
          title: 'Flutter Starter',
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: themeMode,
          routerConfig: router,
        ),
      ),
    );
  }
}
