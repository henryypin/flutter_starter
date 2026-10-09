import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/app/router/app_route.dart';
import 'package:flutter_starter/core/feedback/app_feedback.dart';
import 'package:flutter_starter/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_starter/features/auth/presentation/cubit/auth_state.dart';
import 'package:kaisel/kaisel.dart';

/// Email/password sign-in screen.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.authCubit, required this.feedback});

  /// Authentication actions and error copy.
  final AuthCubit authCubit;

  /// Shows the post-sign-in confirmation.
  final AppFeedback feedback;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final router = context.router<AppRoute>();
    final succeeded = await widget.authCubit.login(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (!mounted || !succeeded) {
      return;
    }
    widget.feedback.showSuccess('Signed in.');
    await router.set(const [Home()]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign in')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 16),
            BlocSignalBuilder<AuthCubit, AuthState>(
              bloc: widget.authCubit,
              builder: (context, state) {
                final message = state.errorMessage;
                if (message == null) {
                  return const SizedBox.shrink();
                }
                return Text(
                  message,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                );
              },
            ),
            const SizedBox(height: 16),
            FilledButton(onPressed: _submit, child: const Text('Sign in')),
          ],
        ),
      ),
    );
  }
}
