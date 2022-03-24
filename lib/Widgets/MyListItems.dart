import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/Models/Todo.dart';
import 'package:todoapp/Providers/all_provider.dart';

class MyListItems extends ConsumerStatefulWidget {
  const MyListItems({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyListItemsState();
}

class _MyListItemsState extends ConsumerState<MyListItems> {
  late FocusNode _textFocusNode;
  late TextEditingController _textEditingController;
  bool _hasFocus = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textFocusNode = FocusNode();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _textFocusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (isFocused) {
        if (!isFocused) {
          setState(() {
            _hasFocus = false;
          });
          ref.read(todosProvider.notifier).updateTodo(
              ref.watch(currentTodo).id, _textEditingController.text);
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 10, left: 5, right: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color:
                  ref.watch(currentTodo).completed ? Colors.green : Colors.red,
              blurRadius: 6,
              offset: Offset(1, 2),
            ),
          ],
        ),
        child: Dismissible(
          key: ValueKey(ref.watch(currentTodo).id),
          onDismissed: (_) {
            ref
                .read(todosProvider.notifier)
                .removeTodo(ref.watch(currentTodo).id);
          },
          child: ListTile(
            leading: Icon(
              ref.watch(currentTodo).completed
                  ? Icons.filter_drama_sharp
                  : Icons.dark_mode_sharp,
              color: Colors.purple,
            ),
            title: _hasFocus
                ? TextField(
                    controller: _textEditingController,
                    focusNode: _textFocusNode,
                  )
                : Text(ref.watch(currentTodo).description),
            trailing: FittedBox(
              fit: BoxFit.fitWidth,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _hasFocus = true;
                          _textFocusNode.requestFocus();
                          _textEditingController.text =
                              ref.watch(currentTodo).description;
                        });
                      },
                      icon: Icon(Icons.mode_edit_outline_rounded)),
                  IconButton(
                      onPressed: () {
                        ref
                            .read(todosProvider.notifier)
                            .toggle(ref.watch(currentTodo).id);
                      },
                      icon: Icon(Icons.check, color: Colors.green)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
