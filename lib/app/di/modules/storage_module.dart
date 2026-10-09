import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_starter/app/config/app_config.dart';
import 'package:flutter_starter/core/storage/adapters/flutter_secure_storage_adapter.dart';
import 'package:flutter_starter/core/storage/adapters/shared_preferences_key_value_storage.dart';
import 'package:flutter_starter/core/storage/in_memory_key_value_storage.dart';
import 'package:flutter_starter/core/storage/in_memory_secure_storage.dart';
import 'package:flutter_starter/core/storage/key_value_storage.dart';
import 'package:flutter_starter/core/storage/secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Registers [SecureStorage] and [KeyValueStorage].
///
/// Uses in-memory fakes when [AppConfig.useInMemoryStorage] is set, otherwise
/// the platform-backed adapters.
Future<void> registerStorageModule(GetIt getIt, AppConfig config) async {
  if (config.useInMemoryStorage) {
    getIt.registerLazySingleton<SecureStorage>(InMemorySecureStorage.new);
    getIt.registerLazySingleton<KeyValueStorage>(InMemoryKeyValueStorage.new);
    return;
  }

  getIt.registerLazySingleton<SecureStorage>(
    () => const FlutterSecureStorageAdapter(FlutterSecureStorage()),
  );
  final preferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<KeyValueStorage>(
    () => SharedPreferencesKeyValueStorage(preferences),
  );
}
