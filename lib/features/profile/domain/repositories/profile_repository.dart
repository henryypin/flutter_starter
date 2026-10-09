import 'package:flutter_starter/core/error/result.dart';
import 'package:flutter_starter/features/profile/domain/entities/user_profile.dart';

/// Profile data access.
abstract interface class ProfileRepository {
  /// Loads the signed-in user's profile.
  Future<Result<UserProfile>> loadProfile();
}
