import 'package:drift/native.dart';
import 'package:flutter_starter/core/database/app_database.dart';
import 'package:flutter_starter/features/todos/data/repositories/todo_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late TodoRepositoryImpl repository;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    repository = TodoRepositoryImpl(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('adds, toggles, and deletes a todo through the repository', () async {
    await repository.add('  Buy milk  ');
    await repository.add('   ');

    var todos = await repository.watchAll().first;
    expect(todos, hasLength(1));
    expect(todos.single.title, 'Buy milk');
    expect(todos.single.completed, isFalse);

    await repository.toggleCompleted(todos.single);

    todos = await repository.watchAll().first;
    expect(todos.single.completed, isTrue);

    await repository.delete(todos.single);

    todos = await repository.watchAll().first;
    expect(todos, isEmpty);
  });
}
