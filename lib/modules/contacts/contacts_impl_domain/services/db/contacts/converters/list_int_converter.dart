import 'dart:convert';

import 'package:moor_flutter/moor_flutter.dart';

class ListIntConverter extends TypeConverter<List<int>, String> {
  final bool nullable;

  const ListIntConverter({this.nullable = false}) : assert(nullable != null);

  @override
  List<int> mapToDart(String fromDb) {
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
  String mapToSql(List<int> value) {
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
