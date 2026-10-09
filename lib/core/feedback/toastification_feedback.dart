import 'package:flutter/widgets.dart';
import 'package:flutter_starter/core/feedback/app_feedback.dart';
import 'package:toastification/toastification.dart';

/// [AppFeedback] implementation backed by the `toastification` package.
///
/// When no [context] is provided the toast is shown through the global
/// overlay, which requires a `ToastificationWrapper` above the app.
class ToastificationFeedback implements AppFeedback {
  const ToastificationFeedback({
    this.context,
    this.duration = const Duration(seconds: 3),
  });

  /// Optional context used to resolve the overlay for the toast.
  final BuildContext? context;

  /// How long each toast stays on screen.
  final Duration duration;

  @override
  void showSuccess(String message) =>
      _show(ToastificationType.success, message);

  @override
  void showError(String message) => _show(ToastificationType.error, message);

  @override
  void showInfo(String message) => _show(ToastificationType.info, message);

  @override
  void showWarning(String message) =>
      _show(ToastificationType.warning, message);

  void _show(ToastificationType type, String message) {
    toastification.show(
      context: context,
      type: type,
      title: Text(message),
      autoCloseDuration: duration,
    );
  }
}
