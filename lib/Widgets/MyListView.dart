import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/Models/Todo.dart';
import 'package:todoapp/Providers/all_provider.dart';
import 'package:todoapp/Widgets/MyListItems.dart';

class MyListView extends ConsumerWidget {
  const MyListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TodoListFilter filter = ref.watch(todoListFilter);
    List<Todo> todos = ref.watch(filtredTodos);
    return ListView.builder(
      itemCount: todos.length + 1,
      itemBuilder: (BuildContext context, int index) {
        return index == todos.length
            ? SizedBox(
                height: 40,
              )
            : ProviderScope(
                overrides: [
                  currentTodo.overrideWithValue(todos[index]),
                ],
                child: MyListItems(),
              );
      },
    );
  }
}
