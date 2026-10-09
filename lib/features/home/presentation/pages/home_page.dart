import 'package:flutter/material.dart';
import 'package:flutter_starter/app/router/app_route.dart';
import 'package:flutter_starter/core/feedback/app_feedback.dart';
import 'package:flutter_starter/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:kaisel/kaisel.dart';

/// Signed-in landing screen with links to the other screens.
class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.authCubit, required this.feedback});

  /// Used to sign the user out.
  final AuthCubit authCubit;

  /// Shows the sign-out confirmation.
  final AppFeedback feedback;

  Future<void> _signOut(BuildContext context) async {
    final router = context.router<AppRoute>();
    await authCubit.logout();
    feedback.showInfo('Signed out.');
    await router.set(const [Login()]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () => context.router<AppRoute>().push(const Profile()),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => context.router<AppRoute>().push(const Settings()),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sign out'),
            onTap: () => _signOut(context),
          ),
        ],
      ),
    );
  }
}
