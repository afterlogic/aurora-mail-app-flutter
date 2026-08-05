
import 'dart:convert';

import 'package:drift/drift.dart';

class ListStringConverter extends TypeConverter<List<String>, String> {
  final bool nullable;

  const ListStringConverter({this.nullable = false});

  @override
  List<String> fromSql(String fromDb) {
    return List<String>.from(json.decode(fromDb) as Iterable);
  }

  @override
  String toSql(List<String> value) {
    return json.encode(value);
  }
}
