import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/Managers/TodoManager.dart';
import 'package:todoapp/Models/Todo.dart';
import 'package:todoapp/Models/catFact.dart';

final httpClientProvider =
    Provider<Dio>((ref) => Dio(BaseOptions(baseUrl: "https://catfact.ninja/")));
//autoDispose kullanılabilir keepAlive() diye bir methoda sahip
final catFactsProvider =
    FutureProvider.family<List<CatFact>, Map<String, dynamic>>(
        (ref, limitDegeri) async {
  final _dio = ref.watch(httpClientProvider);
  final _result = await _dio.get("facts", queryParameters: limitDegeri);

  List<Map<String, dynamic>> _mapData = List.from(_result.data['data']);
  List<CatFact> _catFactList = _mapData.map((e) => CatFact.fromMap(e)).toList();
  return _catFactList;
});
final catFactProvider = Provider<Widget>((ref) {
  var _liste =
      ref.watch(catFactsProvider(const {'limit': 7, 'max_length': 100}));
  var rng = Random();
  Widget _widget = _liste.when(data: (liste) {
    return Text(
      liste[rng.nextInt(5)].fact,
      style: TextStyle(
        fontSize: 12,
      ),
    );
  }, error: (err, stack) {
    return Center(
      child: Text("Bağlantı Kurulamadı ${err.toString()}"),
    );
  }, loading: () {
    return Center(
      child: CircularProgressIndicator(),
    );
  });
  return _widget;
});
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
