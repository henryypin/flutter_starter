import 'package:flutter_starter/features/profile/domain/entities/user_profile.dart';

/// Lifecycle of the profile screen's data.
enum ProfileStatus { initial, loading, loaded, error }

/// State exposed by `ProfileCubit`.
class ProfileState {
  const ProfileState({
    this.status = ProfileStatus.initial,
    this.profile,
    this.errorMessage,
  });

  final ProfileStatus status;

  /// The loaded profile when [status] is [ProfileStatus.loaded].
  final UserProfile? profile;

  /// User-facing failure copy when [status] is [ProfileStatus.error].
  final String? errorMessage;

  @override
  bool operator ==(Object other) =>
      other is ProfileState &&
      other.status == status &&
      other.profile == profile &&
      other.errorMessage == errorMessage;

  @override
  int get hashCode => Object.hash(status, profile, errorMessage);
}
