/// Shows short user feedback (toasts, snackbars, ...) from anywhere in the app.
///
/// Implementations must take their dependencies through constructor arguments
/// and stay independent of any service locator.
abstract interface class AppFeedback {
  void showSuccess(String message);

  void showError(String message);

  void showInfo(String message);

  void showWarning(String message);
}
