/// Deployment environment the app was built for.
enum AppEnvironment { development, staging, production, test }

/// Runtime configuration selected once at startup and passed to the DI
/// container. Keeps environment-specific values out of the feature code.
class AppConfig {
  const AppConfig({
    required this.environment,
    required this.apiBaseUrl,
    required this.enableDemoData,
    required this.useInMemoryStorage,
  });

  /// Base URL used by the network layer.
  final String apiBaseUrl;

  /// Currently selected environment.
  final AppEnvironment environment;

  /// Whether features may fall back to bundled demo data.
  final bool enableDemoData;

  /// Whether storage is backed by in-memory fakes instead of plugins.
  final bool useInMemoryStorage;

  /// Local development configuration with demo data enabled.
  factory AppConfig.development() => const AppConfig(
    environment: AppEnvironment.development,
    apiBaseUrl: 'https://dev.api.example.com',
    enableDemoData: true,
    useInMemoryStorage: false,
  );

  /// Staging configuration that talks to a real backend.
  factory AppConfig.staging() => const AppConfig(
    environment: AppEnvironment.staging,
    apiBaseUrl: 'https://staging.api.example.com',
    enableDemoData: false,
    useInMemoryStorage: false,
  );

  /// Production configuration that talks to a real backend.
  factory AppConfig.production() => const AppConfig(
    environment: AppEnvironment.production,
    apiBaseUrl: 'https://api.example.com',
    enableDemoData: false,
    useInMemoryStorage: false,
  );

  /// Test configuration with demo data and in-memory storage.
  factory AppConfig.test() => const AppConfig(
    environment: AppEnvironment.test,
    apiBaseUrl: 'https://test.api.example.com',
    enableDemoData: true,
    useInMemoryStorage: true,
  );

  /// Builds a config from the `ENV` compile-time define, defaulting to
  /// [AppConfig.development] for unknown values.
  factory AppConfig.fromEnvironment([
    String environment = const String.fromEnvironment('ENV'),
  ]) {
    switch (environment.toLowerCase()) {
      case 'staging':
        return AppConfig.staging();
      case 'production':
        return AppConfig.production();
      case 'test':
        return AppConfig.test();
      case 'development':
      default:
        return AppConfig.development();
    }
  }
}
