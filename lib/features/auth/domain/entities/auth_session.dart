/// The session produced by a successful sign-in.
class AuthSession {
  const AuthSession({required this.accessToken});

  /// Bearer token used to authorise API requests.
  final String accessToken;
}
