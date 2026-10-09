import 'dart:developer' as developer;

/// Thin wrapper around `dart:developer` logging. No logging package is used.
class AppLogger {
  const AppLogger({this.name = 'flutter_starter'});

  /// Logger name reported to the developer tooling.
  final String name;

  static const int _debugLevel = 500;
  static const int _infoLevel = 800;
  static const int _warningLevel = 900;
  static const int _errorLevel = 1000;

  void debug(String message, {Object? error, StackTrace? stackTrace}) =>
      _log('DEBUG', _debugLevel, message, error, stackTrace);

  void info(String message, {Object? error, StackTrace? stackTrace}) =>
      _log('INFO', _infoLevel, message, error, stackTrace);

  void warning(String message, {Object? error, StackTrace? stackTrace}) =>
      _log('WARN', _warningLevel, message, error, stackTrace);

  void error(String message, {Object? error, StackTrace? stackTrace}) =>
      _log('ERROR', _errorLevel, message, error, stackTrace);

  void _log(
    String level,
    int levelValue,
    String message,
    Object? error,
    StackTrace? stackTrace,
  ) {
    developer.log(
      message,
      name: '$name.$level',
      level: levelValue,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
