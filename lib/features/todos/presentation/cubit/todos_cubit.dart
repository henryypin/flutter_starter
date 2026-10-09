import 'dart:async';

import 'package:bloc_signals/bloc_signals.dart';
import 'package:flutter_starter/features/todos/domain/entities/todo.dart';
import 'package:flutter_starter/features/todos/domain/repositories/todo_repository.dart';
import 'package:flutter_starter/features/todos/presentation/cubit/todos_state.dart';

/// Watches the stored todos and exposes add, toggle, and delete actions.
///
/// Registered as a factory: the todos screen creates one instance and closes it
/// when the screen is disposed, which cancels the watch subscription.
class TodosCubit extends CubitSignal<TodosState> {
  TodosCubit(this._repository) : super(initialState: const TodosState()) {
    _subscription = _repository.watchAll().listen(_onTodos);
  }

  final TodoRepository _repository;
  late final StreamSubscription<List<Todo>> _subscription;

  void _onTodos(List<Todo> todos) => emit(TodosState(todos: todos));

  /// Inserts a todo titled [title]; blank titles are ignored.
  Future<void> add(String title) => _repository.add(title);

  /// Flips the completed flag of [todo].
  Future<void> toggleCompleted(Todo todo) => _repository.toggleCompleted(todo);

  /// Removes [todo].
  Future<void> delete(Todo todo) => _repository.delete(todo);

  @override
  Future<void> close() async {
    await _subscription.cancel();
    await super.close();
  }
}
