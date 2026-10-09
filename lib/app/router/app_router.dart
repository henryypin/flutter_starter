import 'package:flutter_starter/app/router/app_route.dart';
import 'package:flutter_starter/core/feedback/app_feedback.dart';
import 'package:flutter_starter/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_starter/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_starter/features/home/presentation/pages/home_page.dart';
import 'package:flutter_starter/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter_starter/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter_starter/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:flutter_starter/features/settings/presentation/pages/settings_page.dart';
import 'package:kaisel/kaisel.dart';

/// Builds the app's [KaiselRouterConfig].
///
/// The auth gate arrives as the [isAuthenticated] callback and the page
/// dependencies arrive as constructors, so this file never touches the service
/// locator.
KaiselRouterConfig<AppRoute> createAppRouter({
  required bool Function() isAuthenticated,
  required AuthCubit authCubit,
  required SettingsCubit settingsCubit,
  required ProfileCubit Function() createProfileCubit,
  required AppFeedback feedback,
}) {
  final initial = isAuthenticated() ? const Home() : const Login();

  return KaiselRouterConfig<AppRoute>(
    initial: initial,
    guards: [_authGuard(isAuthenticated)],
    builder: (context, route) => switch (route) {
      Home() => HomePage(authCubit: authCubit, feedback: feedback),
      Login() => LoginPage(authCubit: authCubit, feedback: feedback),
      Settings() => SettingsPage(settingsCubit: settingsCubit),
      Profile() => ProfilePage(createProfileCubit: createProfileCubit),
    },
  );
}

/// Redirects to [Login] whenever a protected route is requested while signed
/// out. [Login] itself is always allowed through.
KaiselGuard<AppRoute> _authGuard(bool Function() isAuthenticated) {
  return (current, proposed) {
    final requiresAuth = proposed.any((route) => route is! Login);
    if (requiresAuth && !isAuthenticated()) {
      return const [Login()];
    }
    return proposed;
  };
}
