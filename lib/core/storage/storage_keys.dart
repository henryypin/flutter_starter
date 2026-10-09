/// Keys used with [SecureStorage] and [KeyValueStorage]. A single place keeps
/// every stored key spelled the same way.
abstract final class StorageKeys {
  /// Bearer token for authenticated requests.
  static const String accessToken = 'access_token';

  /// Currently signed-in user identifier.
  static const String userId = 'user_id';

  /// Whether the user has completed onboarding.
  static const String onboardingCompleted = 'onboarding_completed';

  /// Selected light/dark theme mode.
  static const String themeMode = 'theme_mode';
}
