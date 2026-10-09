import 'package:bloc_signals/bloc_signals.dart';
import 'package:flutter_starter/core/error/failure_message_resolver.dart';
import 'package:flutter_starter/features/auth/domain/usecases/check_session.dart';
import 'package:flutter_starter/features/auth/domain/usecases/login_with_credentials.dart';
import 'package:flutter_starter/features/auth/domain/usecases/logout.dart';
import 'package:flutter_starter/features/auth/presentation/cubit/auth_state.dart';

/// Owns the authentication state and exposes the auth actions to the UI.
class AuthCubit extends CubitSignal<AuthState> {
  AuthCubit(
    this._checkSession,
    this._login,
    this._logout,
    this._failureMessageResolver,
  ) : super(initialState: const AuthState());

  final CheckSession _checkSession;
  final LoginWithCredentials _login;
  final Logout _logout;
  final FailureMessageResolver _failureMessageResolver;

  /// Restores the session from storage and emits the resulting status.
  Future<void> checkSession() async {
    final hasSession = await _checkSession();
    emit(
      AuthState(
        status: hasSession
            ? AuthStatus.authenticated
            : AuthStatus.unauthenticated,
      ),
    );
  }

  /// Signs in with [email] and [password], returning whether it succeeded.
  Future<bool> login({required String email, required String password}) async {
    final result = await _login(email: email, password: password);
    if (result.isSuccess) {
      emit(const AuthState(status: AuthStatus.authenticated));
      return true;
    }

    final failure = result.failureOrNull;
    emit(
      AuthState(
        status: AuthStatus.unauthenticated,
        errorMessage: failure == null
            ? null
            : _failureMessageResolver.resolve(failure),
      ),
    );
    return false;
  }

  /// Clears the session and emits the signed-out status.
  Future<void> logout() async {
    await _logout();
    emit(const AuthState(status: AuthStatus.unauthenticated));
  }
}
