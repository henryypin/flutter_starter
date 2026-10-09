import 'package:flutter_starter/core/storage/key_value_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// [KeyValueStorage] adapter backed by the `shared_preferences` plugin.
class SharedPreferencesKeyValueStorage implements KeyValueStorage {
  const SharedPreferencesKeyValueStorage(this._preferences);

  final SharedPreferences _preferences;

  @override
  Future<String?> getString(String key) async => _preferences.getString(key);

  @override
  Future<void> setString(String key, String value) =>
      _preferences.setString(key, value);

  @override
  Future<bool?> getBool(String key) async => _preferences.getBool(key);

  @override
  Future<void> setBool(String key, bool value) =>
      _preferences.setBool(key, value);

  @override
  Future<void> remove(String key) => _preferences.remove(key);

  @override
  Future<void> clear() => _preferences.clear();
}
