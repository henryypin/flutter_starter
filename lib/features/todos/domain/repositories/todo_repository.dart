import 'package:flutter_starter/features/todos/domain/entities/todo.dart';

/// Todo data access backed by the local database.
abstract interface class TodoRepository {
  /// Emits every todo, ordered by id, whenever the table changes.
  Stream<List<Todo>> watchAll();

  /// Inserts a todo with [title]. Blank titles are ignored.
  Future<void> add(String title);

  /// Flips the completed flag of [todo].
  Future<void> toggleCompleted(Todo todo);

  /// Removes [todo].
  Future<void> delete(Todo todo);
}
