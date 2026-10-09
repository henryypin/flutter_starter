import 'package:flutter_starter/core/error/result.dart';
import 'package:flutter_starter/features/profile/domain/entities/user_profile.dart';
import 'package:flutter_starter/features/profile/domain/repositories/profile_repository.dart';

/// Loads the signed-in user's profile.
class LoadProfile {
  const LoadProfile(this._repository);

  final ProfileRepository _repository;

  /// Returns the profile, or a [Result] failure when loading fails.
  Future<Result<UserProfile>> call() => _repository.loadProfile();
}
