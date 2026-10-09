import 'package:flutter_starter/core/error/result.dart';
import 'package:flutter_starter/features/profile/domain/entities/user_profile.dart';

/// Bundled profile used when `AppConfig.enableDemoData` is set.
class DemoProfileDataSource {
  const DemoProfileDataSource();

  /// Returns the demo user that matches the demo credentials.
  Future<Result<UserProfile>> loadProfile() async =>
      const Success(UserProfile(name: 'Demo User', email: 'demo@example.com'));
}
