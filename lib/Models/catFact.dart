// To parse this JSON data, do
//
//     final catFact = catFactFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CatFact catFactFromMap(String str) => CatFact.fromMap(json.decode(str));

String catFactToMap(CatFact data) => json.encode(data.toMap());

@immutable
class CatFact {
  CatFact({
    required this.fact,
    required this.length,
  });

  final String fact;
  final int length;

  factory CatFact.fromMap(Map<String, dynamic> json) => CatFact(
        fact: json["fact"],
        length: json["length"],
      );

  Map<String, dynamic> toMap() => {
        "fact": fact,
        "length": length,
      };
}
