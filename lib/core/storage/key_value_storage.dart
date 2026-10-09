/// Stores non-sensitive key/value data such as preferences. Backed by
/// `shared_preferences` in production and by an in-memory implementation in
/// tests.
abstract interface class KeyValueStorage {
  Future<String?> getString(String key);

  Future<void> setString(String key, String value);

  Future<bool?> getBool(String key);

  Future<void> setBool(String key, bool value);

  Future<void> remove(String key);

  Future<void> clear();
}
