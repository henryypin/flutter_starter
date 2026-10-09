import 'package:drift/drift.dart';

part 'app_database.g.dart';

/// The todos table stored in the local SQL database.
@DataClassName('TodoRow')
class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();

  BoolColumn get completed => boolean().withDefault(const Constant(false))();
}

/// The app's single local database.
///
/// The executor is passed in by the DI layer so tests can open an in-memory
/// database while the app opens a file-backed one.
@DriftDatabase(tables: [Todos])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;
}
