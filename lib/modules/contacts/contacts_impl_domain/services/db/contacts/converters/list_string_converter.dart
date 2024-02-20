//@dart=2.9
import 'dart:convert';

import 'package:drift_sqflite/drift_sqflite.dart';
import 'package:drift/drift.dart';

class ListStringConverter extends TypeConverter<List<String>, String> {
  final bool nullable;

  const ListStringConverter({this.nullable = false}) : assert(nullable != null);

  @override
  List<String> mapToDart(String fromDb) {
    if (fromDb == null) {
      if (nullable == true) {
        return null;
      } else {
        return [];
      }
    }
    return List<String>.from(json.decode(fromDb) as Iterable);
  }

  @override
  String mapToSql(List<String> value) {
    if (value == null) {
      if (nullable == true) {
        return null;
      } else {
        return "[]";
      }
    }

    return json.encode(value);
  }
}
