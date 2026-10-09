import 'package:drift/native.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter_starter/app/config/app_config.dart';
import 'package:flutter_starter/core/database/app_database.dart';
import 'package:get_it/get_it.dart';

/// Registers [AppDatabase] with an executor that matches [config].
///
/// In-memory storage (used by tests) opens an in-memory database; every other
/// environment opens a file-backed one. The container closes the database when
/// it is reset.
void registerDatabaseModule(GetIt getIt, AppConfig config) {
  getIt.registerLazySingleton<AppDatabase>(
    () => AppDatabase(
      config.useInMemoryStorage
          ? NativeDatabase.memory()
          : driftDatabase(name: 'flutter_starter'),
    ),
    dispose: (database) => database.close(),
  );
}
