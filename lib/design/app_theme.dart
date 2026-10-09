import 'package:flutter/material.dart';

/// Light and dark [ThemeData] for the app.
abstract final class AppTheme {
  static const Color _seedColor = Color(0xFF3F51B5);

  /// Theme used when the system is in light mode.
  static ThemeData light() => ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: _seedColor),
    useMaterial3: true,
    brightness: Brightness.light,
  );

  /// Theme used when the system is in dark mode.
  static ThemeData dark() => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
    brightness: Brightness.dark,
  );
}
