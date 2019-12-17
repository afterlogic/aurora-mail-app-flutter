import 'dart:convert';

import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
import 'package:moor_flutter/moor_flutter.dart';

class ContactsInfoConverter
    extends TypeConverter<List<ContactInfoItem>, String> {
  const ContactsInfoConverter();

  @override
  List<ContactInfoItem> mapToDart(String fromDb) {
    if (fromDb == null) {
      return new List<ContactInfoItem>();
    }

    final items = json.decode(fromDb);
    final mapped =
        items.map((i) => ContactInfoItem.fromMap(Map<String, dynamic>.from(i)));

    return new List<ContactInfoItem>.from(mapped);
  }

  @override
  String mapToSql(List<ContactInfoItem> value) {
    if (value == null) {
      return "[]";
    }

    final maps = value.map((i) => i.toMap()).toList();

    return json.encode(maps);
  }
}
