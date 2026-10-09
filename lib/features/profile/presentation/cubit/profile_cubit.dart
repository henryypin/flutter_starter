import 'package:bloc_signals/bloc_signals.dart';
import 'package:flutter_starter/core/error/failure_message_resolver.dart';
import 'package:flutter_starter/features/profile/domain/usecases/load_profile.dart';
import 'package:flutter_starter/features/profile/presentation/cubit/profile_state.dart';

/// Loads and exposes the signed-in user's profile.
///
/// Registered as a factory: the profile screen creates one instance, loads it,
/// and closes it when the screen is disposed.
class ProfileCubit extends CubitSignal<ProfileState> {
  ProfileCubit(this._loadProfile, this._failureMessageResolver)
    : super(initialState: const ProfileState());

  final LoadProfile _loadProfile;
  final FailureMessageResolver _failureMessageResolver;

  /// Loads the profile and emits loading, loaded, or error.
  Future<void> load() async {
    emit(const ProfileState(status: ProfileStatus.loading));

    final result = await _loadProfile();
    if (result.isSuccess) {
      emit(
        ProfileState(status: ProfileStatus.loaded, profile: result.valueOrNull),
      );
      return;
    }

    final failure = result.failureOrNull;
    emit(
      ProfileState(
        status: ProfileStatus.error,
        errorMessage: failure == null
            ? null
            : _failureMessageResolver.resolve(failure),
      ),
    );
  }
}
