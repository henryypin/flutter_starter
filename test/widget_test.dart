import 'package:flutter/material.dart';
import 'package:flutter_starter/app/di/injector.dart';
import 'package:flutter_starter/app/router/app_router.dart';
import 'package:flutter_starter/core/feedback/app_feedback.dart';
import 'package:flutter_starter/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_starter/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter_starter/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:flutter_starter/features/todos/presentation/cubit/todos_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/test_dependencies.dart';

void main() {
  setUp(() async {
    await configureTestDependencies();
  });

  tearDown(() async {
    await getIt.reset();
  });

  testWidgets('failed login shows Invalid email or password', (
    WidgetTester tester,
  ) async {
    final authCubit = getIt<AuthCubit>();
    final settingsCubit = getIt<SettingsCubit>();

    final router = createAppRouter(
      isAuthenticated: () => authCubit.stateValue.isAuthenticated,
      authCubit: authCubit,
      settingsCubit: settingsCubit,
      createProfileCubit: () => getIt<ProfileCubit>(),
      createTodosCubit: () => getIt<TodosCubit>(),
      feedback: getIt<AppFeedback>(),
    );

    await tester.pumpWidget(MaterialApp.router(routerConfig: router));

    await tester.enterText(
      find.widgetWithText(TextField, 'Email'),
      'someone@example.com',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Password'),
      'wrong-password',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Sign in'));
    await tester.pumpAndSettle();

    expect(find.text('Invalid email or password'), findsOneWidget);
  });
}
