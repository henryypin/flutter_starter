/// Stores sensitive values such as tokens. Backed by platform secure storage
/// in production and by an in-memory implementation in tests.
abstract interface class SecureStorage {
  Future<void> write({required String key, required String value});

  Future<String?> read({required String key});

  Future<void> delete({required String key});

  Future<void> deleteAll();
}
