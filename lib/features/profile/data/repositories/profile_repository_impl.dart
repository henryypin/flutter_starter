import 'package:flutter_starter/core/error/failure.dart';
import 'package:flutter_starter/core/error/result.dart';
import 'package:flutter_starter/features/profile/data/datasources/demo_profile_data_source.dart';
import 'package:flutter_starter/features/profile/domain/entities/user_profile.dart';
import 'package:flutter_starter/features/profile/domain/repositories/profile_repository.dart';

/// [ProfileRepository] backed by the optional [DemoProfileDataSource].
///
/// Without a demo source (non-demo environments) there is no profile API yet,
/// so loading is reported as unavailable.
class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl([this._demoDataSource]);

  final DemoProfileDataSource? _demoDataSource;

  @override
  Future<Result<UserProfile>> loadProfile() async {
    final demoDataSource = _demoDataSource;
    if (demoDataSource == null) {
      return const Failed<UserProfile>(
        UnknownFailure('No profile service is configured.'),
      );
    }
    return demoDataSource.loadProfile();
  }
}
