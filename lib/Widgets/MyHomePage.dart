import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:todoapp/Widgets/MyCustomForm.dart';
import 'package:todoapp/Widgets/MyFloatingActionButton.dart';
import 'package:todoapp/Widgets/MyListView.dart';
import 'package:todoapp/Widgets/MyTopSection.dart';
import 'package:todoapp/Widgets/MyApiWidget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// List<String> todoList = ref.watch(todoListProvider);
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: Center(
          child: Text(
            widget.title,
            style: TextStyle(
                fontSize: 50, fontWeight: FontWeight.w300, letterSpacing: 20),
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            MyCustomForm(),
            MyTopSection(),
            Expanded(child: Container(height: 200, child: MyListView())),
            MyApiWidget()
          ],
        ),
      ),
      floatingActionButton: MyFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
