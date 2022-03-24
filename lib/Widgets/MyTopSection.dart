import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/Providers/all_provider.dart';

class MyTopSection extends ConsumerWidget {
  const MyTopSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int notComplatedCount =
        ref.watch(todosNotComplateCountProvider.state).state;
    TodoListFilter todoFilter = ref.watch(todoListFilter);

    TextStyle styleFilter(TodoListFilter _todoListFilter) {
      return TextStyle(
          fontWeight: todoFilter == _todoListFilter
              ? FontWeight.bold
              : FontWeight.normal,
          color: todoFilter == _todoListFilter ? Colors.purple : Colors.black);
    }

    return Container(
      padding: EdgeInsets.only(top: 15, left: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              notComplatedCount > 0
                  ? notComplatedCount.toString() + " Tane Görev Tamamlanmamış."
                  : "Tüm Görevler Tamamlanmış.",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  ref.read(todoListFilter.state).state = TodoListFilter.all;
                },
                child: Text("Tüm", style: styleFilter(TodoListFilter.all)),
              ),
              TextButton(
                  onPressed: () {
                    ref.read(todoListFilter.state).state =
                        TodoListFilter.active;
                  },
                  child: Text(
                    "Aktif",
                    style: styleFilter(TodoListFilter.active),
                  )),
              TextButton(
                  onPressed: () {
                    ref.read(todoListFilter.state).state =
                        TodoListFilter.complated;
                  },
                  child: Text(
                    "Tamamlanmışlar",
                    style: styleFilter(TodoListFilter.complated),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
