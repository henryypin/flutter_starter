import 'package:flutter_starter/app/config/app_config.dart';
import 'package:flutter_starter/core/error/failure_message_resolver.dart';
import 'package:flutter_starter/core/feedback/app_feedback.dart';
import 'package:flutter_starter/core/feedback/toastification_feedback.dart';
import 'package:flutter_starter/core/logging/app_logger.dart';
import 'package:get_it/get_it.dart';

/// Registers app-wide services: logging, failure copy, and user feedback.
void registerAppModule(GetIt getIt, AppConfig config) {
  getIt.registerLazySingleton<AppLogger>(() => const AppLogger());
  getIt.registerLazySingleton<FailureMessageResolver>(
    () => const FailureMessageResolver(),
  );
  getIt.registerLazySingleton<AppFeedback>(
    () => const ToastificationFeedback(),
  );
}
