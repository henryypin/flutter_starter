import 'package:bloc_signals/bloc_signals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/core/storage/key_value_storage.dart';
import 'package:flutter_starter/core/storage/storage_keys.dart';

/// Holds the selected [ThemeMode] and persists it with [KeyValueStorage].
class SettingsCubit extends CubitSignal<ThemeMode> {
  SettingsCubit(this._keyValueStorage) : super(initialState: ThemeMode.system);

  final KeyValueStorage _keyValueStorage;

  /// Loads the stored theme mode, keeping [ThemeMode.system] when unset.
  Future<void> initialize() async {
    final stored = await _keyValueStorage.getString(StorageKeys.themeMode);
    emit(_decode(stored));
  }

  /// Stores [mode] and emits it.
  Future<void> setThemeMode(ThemeMode mode) async {
    await _keyValueStorage.setString(StorageKeys.themeMode, mode.name);
    emit(mode);
  }

  static ThemeMode _decode(String? value) => value == null
      ? ThemeMode.system
      : ThemeMode.values.asNameMap()[value] ?? ThemeMode.system;
}
