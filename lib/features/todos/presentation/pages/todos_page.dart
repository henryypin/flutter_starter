import 'dart:async';

import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/features/todos/presentation/cubit/todos_cubit.dart';
import 'package:flutter_starter/features/todos/presentation/cubit/todos_state.dart';

/// Lists stored todos and lets the user add, complete, and delete them.
class TodosPage extends StatefulWidget {
  const TodosPage({super.key, required this.createTodosCubit});

  /// Creates the [TodosCubit] this screen owns and closes when disposed.
  final TodosCubit Function() createTodosCubit;

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  late final TodosCubit _todosCubit;
  final TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _todosCubit = widget.createTodosCubit();
  }

  @override
  void dispose() {
    _titleController.dispose();
    unawaited(_todosCubit.close());
    super.dispose();
  }

  void _add() {
    unawaited(_todosCubit.add(_titleController.text));
    _titleController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todos')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'New todo'),
                    onSubmitted: (_) => _add(),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(onPressed: _add, child: const Text('Add')),
              ],
            ),
          ),
          Expanded(
            child: BlocSignalBuilder<TodosCubit, TodosState>(
              bloc: _todosCubit,
              builder: (context, state) {
                if (state.todos.isEmpty) {
                  return const Center(child: Text('No todos yet.'));
                }
                return ListView.builder(
                  itemCount: state.todos.length,
                  itemBuilder: (context, index) {
                    final todo = state.todos[index];
                    return CheckboxListTile(
                      value: todo.completed,
                      title: Text(todo.title),
                      onChanged: (_) =>
                          unawaited(_todosCubit.toggleCompleted(todo)),
                      secondary: IconButton(
                        icon: const Icon(Icons.delete),
                        tooltip: 'Delete',
                        onPressed: () => unawaited(_todosCubit.delete(todo)),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
