import 'package:drift/drift.dart';
import 'package:flutter_starter/core/database/app_database.dart';
import 'package:flutter_starter/features/todos/domain/entities/todo.dart';
import 'package:flutter_starter/features/todos/domain/repositories/todo_repository.dart';

/// [TodoRepository] backed by the local Drift [AppDatabase].
///
/// Maps database rows to the plain [Todo] entity so the domain and UI never see
/// Drift types.
class TodoRepositoryImpl implements TodoRepository {
  const TodoRepositoryImpl(this._database);

  final AppDatabase _database;

  @override
  Stream<List<Todo>> watchAll() {
    final query = _database.select(_database.todos)
      ..orderBy([(todo) => OrderingTerm(expression: todo.id)]);
    return query.watch().map(
      (rows) => rows.map(_toEntity).toList(growable: false),
    );
  }

  @override
  Future<void> add(String title) async {
    final trimmed = title.trim();
    if (trimmed.isEmpty) {
      return;
    }
    await _database
        .into(_database.todos)
        .insert(TodosCompanion.insert(title: trimmed));
  }

  @override
  Future<void> toggleCompleted(Todo todo) async {
    await (_database.update(_database.todos)
          ..where((row) => row.id.equals(todo.id)))
        .write(TodosCompanion(completed: Value(!todo.completed)));
  }

  @override
  Future<void> delete(Todo todo) async {
    await (_database.delete(
      _database.todos,
    )..where((row) => row.id.equals(todo.id))).go();
  }

  Todo _toEntity(TodoRow row) =>
      Todo(id: row.id, title: row.title, completed: row.completed);
}
