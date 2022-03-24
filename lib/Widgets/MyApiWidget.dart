import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/Models/catFact.dart';
import 'package:todoapp/Providers/all_provider.dart';

class MyApiWidget extends ConsumerWidget {
  const MyApiWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 240,
      child: ref.watch(catFactProvider),
    );
  }
}
