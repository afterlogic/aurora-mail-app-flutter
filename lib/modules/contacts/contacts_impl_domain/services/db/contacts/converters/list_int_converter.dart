import 'dart:convert';

import 'package:drift_sqflite/drift_sqflite.dart';
import 'package:drift/drift.dart';

class ListIntConverter extends TypeConverter<List<int>, String> {
  final bool nullable;

  const ListIntConverter({this.nullable = false});

  @override
  List<int>? mapToDart(String? fromDb) {
    if (fromDb == null) {
      if (nullable == true) {
        return null;
      } else {
        return [];
      }
    }
    return json.decode(fromDb) as List<int>;
  }

  @override
  String? mapToSql(List<int>? value) {
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
