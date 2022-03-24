import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/Providers/all_provider.dart';

class MyCustomForm extends ConsumerWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: TextFormField(
        onChanged: (value) => ref.read(newTodoProvider.state).state = value,
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Yeni Bir Görev Ekleyin.',
        ),
      ),
    );
  }
}
