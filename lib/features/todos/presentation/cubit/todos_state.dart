import 'package:flutter_starter/features/todos/domain/entities/todo.dart';

/// State exposed by `TodosCubit`.
class TodosState {
  const TodosState({this.todos = const []});

  /// Every stored todo, ordered by id.
  final List<Todo> todos;

  @override
  bool operator ==(Object other) =>
      other is TodosState && _sameTodos(other.todos, todos);

  @override
  int get hashCode => Object.hashAll(todos);

  static bool _sameTodos(List<Todo> a, List<Todo> b) {
    if (a.length != b.length) {
      return false;
    }
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) {
        return false;
      }
    }
    return true;
  }
}
