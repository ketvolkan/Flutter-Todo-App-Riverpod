import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/Managers/TodoManager.dart';
import 'package:todoapp/Models/Todo.dart';

final titleProvider = Provider((ref) => "TodoApp");
final newTodoProvider = StateProvider<String>((ref) => "");
final todosProvider = StateNotifierProvider<TodosNotifier, List<Todo>>((ref) {
  return TodosNotifier();
});
enum TodoListFilter { all, active, complated }
final todoListFilter = StateProvider<TodoListFilter>((ref) {
  return TodoListFilter.all;
});
final todosNotComplateCountProvider = StateProvider<int>((ref) {
  var todos = ref.watch(todosProvider);
  todos = [
    for (final todo in todos)
      if (todo.completed != true) todo,
  ];
  return todos.length;
});
final filtredTodos = Provider<List<Todo>>(
  (ref) {
    var todos = ref.watch(todosProvider);
    var filter = ref.watch(todoListFilter);
    if (filter == TodoListFilter.active) {
      todos = ref.watch(todosProvider);
      todos = [
        for (final todo in todos)
          if (todo.completed != true) todo
      ];
    } else if (filter == TodoListFilter.complated) {
      todos = ref.watch(todosProvider);
      todos = [
        for (final todo in todos)
          if (todo.completed != false) todo
      ];
    } else {
      todos = ref.watch(todosProvider);
    }
    return todos;
  },
);
final currentTodo = Provider<Todo>((ref) {
  throw UnimplementedError();
});
