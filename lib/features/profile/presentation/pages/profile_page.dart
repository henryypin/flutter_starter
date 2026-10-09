import 'dart:async';

import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/features/profile/domain/entities/user_profile.dart';
import 'package:flutter_starter/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter_starter/features/profile/presentation/cubit/profile_state.dart';

/// Shows the signed-in user's profile.
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.createProfileCubit});

  /// Creates the [ProfileCubit] this screen owns and closes when disposed.
  final ProfileCubit Function() createProfileCubit;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final ProfileCubit _profileCubit;

  @override
  void initState() {
    super.initState();
    _profileCubit = widget.createProfileCubit();
    unawaited(_profileCubit.load());
  }

  @override
  void dispose() {
    unawaited(_profileCubit.close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: BlocSignalBuilder<ProfileCubit, ProfileState>(
        bloc: _profileCubit,
        builder: (context, state) => switch (state.status) {
          ProfileStatus.initial || ProfileStatus.loading => const Center(
            child: CircularProgressIndicator(),
          ),
          ProfileStatus.loaded => _ProfileDetails(profile: state.profile!),
          ProfileStatus.error => Center(
            child: Text(state.errorMessage ?? 'Could not load the profile.'),
          ),
        },
      ),
    );
  }
}

class _ProfileDetails extends StatelessWidget {
  const _ProfileDetails({required this.profile});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.badge),
          title: const Text('Name'),
          subtitle: Text(profile.name),
        ),
        ListTile(
          leading: const Icon(Icons.email),
          title: const Text('Email'),
          subtitle: Text(profile.email),
        ),
      ],
    );
  }
}
