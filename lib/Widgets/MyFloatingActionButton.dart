import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/Models/Todo.dart';
import 'package:todoapp/Providers/all_provider.dart';

class MyFloatingActionButton extends ConsumerWidget {
  MyFloatingActionButton({Key? key}) : super(key: key);
  var rng = Random();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () {
        final String newTodo = ref.watch(newTodoProvider.state).state;
        if (newTodo != "") {
          ref.read(todosProvider.notifier).addTodo(
                newTodo,
              );
          ref.read(newTodoProvider.state).state = "";
        }
      },
      backgroundColor: Colors.purple,
      child: const Icon(Icons.add),
    );
  }
}
