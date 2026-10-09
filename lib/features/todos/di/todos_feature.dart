import 'package:flutter_starter/core/database/app_database.dart';
import 'package:flutter_starter/features/todos/data/repositories/todo_repository_impl.dart';
import 'package:flutter_starter/features/todos/domain/repositories/todo_repository.dart';
import 'package:flutter_starter/features/todos/presentation/cubit/todos_cubit.dart';
import 'package:get_it/get_it.dart';

/// Registers the todos feature: the repository and the [TodosCubit] factory.
///
/// [TodosCubit] is a factory because the todos screen creates one instance and
/// closes it on dispose. Both the repository and the cubit receive their
/// dependencies through constructors.
void registerTodosFeature(GetIt getIt) {
  getIt.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(getIt<AppDatabase>()),
  );
  getIt.registerFactory<TodosCubit>(() => TodosCubit(getIt<TodoRepository>()));
}
