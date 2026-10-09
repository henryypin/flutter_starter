import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_starter/core/storage/secure_storage.dart';

/// [SecureStorage] adapter backed by the `flutter_secure_storage` plugin.
class FlutterSecureStorageAdapter implements SecureStorage {
  const FlutterSecureStorageAdapter(this._storage);

  final FlutterSecureStorage _storage;

  @override
  Future<void> write({required String key, required String value}) =>
      _storage.write(key: key, value: value);

  @override
  Future<String?> read({required String key}) => _storage.read(key: key);

  @override
  Future<void> delete({required String key}) => _storage.delete(key: key);

  @override
  Future<void> deleteAll() => _storage.deleteAll();
}
