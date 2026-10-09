import 'package:dio/dio.dart';
import 'package:flutter_starter/app/config/app_config.dart';
import 'package:flutter_starter/core/network/api_client.dart';
import 'package:flutter_starter/core/network/dio_factory.dart';
import 'package:flutter_starter/core/storage/secure_storage.dart';
import 'package:flutter_starter/core/storage/storage_keys.dart';
import 'package:get_it/get_it.dart';

/// Registers the network stack: the shared [Dio] client and [ApiClient].
void registerNetworkModule(GetIt getIt, AppConfig config) {
  getIt.registerLazySingleton<Dio>(
    () {
      final secureStorage = getIt<SecureStorage>();
      return const DioFactory().create(
        baseUrl: config.apiBaseUrl,
        tokenProvider: () => secureStorage.read(key: StorageKeys.accessToken),
      );
    },
    // get_it 9.x supports `dispose`, so the client is closed on reset.
    dispose: (dio) => dio.close(),
  );
  getIt.registerLazySingleton<ApiClient>(() => ApiClient(getIt<Dio>()));
}
