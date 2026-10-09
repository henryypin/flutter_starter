import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/features/settings/presentation/cubit/settings_cubit.dart';

/// Lets the user pick the app's theme mode.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key, required this.settingsCubit});

  /// Theme mode state and actions.
  final SettingsCubit settingsCubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: BlocSignalBuilder<SettingsCubit, ThemeMode>(
        bloc: settingsCubit,
        builder: (context, mode) => ListView(
          children: [
            const ListTile(title: Text('Theme')),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SegmentedButton<ThemeMode>(
                segments: const [
                  ButtonSegment(value: ThemeMode.system, label: Text('System')),
                  ButtonSegment(value: ThemeMode.light, label: Text('Light')),
                  ButtonSegment(value: ThemeMode.dark, label: Text('Dark')),
                ],
                selected: {mode},
                onSelectionChanged: (selection) =>
                    settingsCubit.setThemeMode(selection.first),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
