/// A single todo item shown on the todos screen.
class Todo {
  const Todo({required this.id, required this.title, required this.completed});

  /// Row id assigned by the database.
  final int id;

  /// Text of the todo.
  final String title;

  /// Whether the todo is done.
  final bool completed;

  @override
  bool operator ==(Object other) =>
      other is Todo &&
      other.id == id &&
      other.title == title &&
      other.completed == completed;

  @override
  int get hashCode => Object.hash(id, title, completed);
}
