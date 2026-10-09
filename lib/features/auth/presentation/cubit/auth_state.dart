/// Session lifecycle tracked by `AuthCubit`.
enum AuthStatus { unknown, unauthenticated, authenticated }

/// State exposed by `AuthCubit`.
class AuthState {
  const AuthState({this.status = AuthStatus.unknown, this.errorMessage});

  final AuthStatus status;

  /// User-facing copy for a failed sign-in, cleared on the next attempt.
  final String? errorMessage;

  /// Whether the user currently has a session.
  bool get isAuthenticated => status == AuthStatus.authenticated;

  @override
  bool operator ==(Object other) =>
      other is AuthState &&
      other.status == status &&
      other.errorMessage == errorMessage;

  @override
  int get hashCode => Object.hash(status, errorMessage);
}
