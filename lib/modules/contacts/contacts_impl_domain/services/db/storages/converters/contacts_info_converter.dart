
import 'dart:convert';

import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
import 'package:drift_sqflite/drift_sqflite.dart';
import 'package:drift/drift.dart';

class ContactsInfoConverter extends TypeConverter<List<ContactInfoItem>, String> {
  final bool nullable;

  const ContactsInfoConverter({this.nullable = true});

  @override
  List<ContactInfoItem> fromSql(String fromDb) {
    final items = json.decode(fromDb) as Iterable;
    final mapped = items.map((i) {
      return ContactInfoItem.fromMap(Map<String, dynamic>.from(i as Map));
    });

    return new List<ContactInfoItem>.from(mapped);
  }

  @override
  String toSql(List<ContactInfoItem> value) {
    final maps = value.map((i) => i.toMap()).toList();

    return json.encode(maps);
  }
}
