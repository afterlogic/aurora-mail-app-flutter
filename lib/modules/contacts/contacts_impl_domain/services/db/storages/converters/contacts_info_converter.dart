import 'dart:convert';

import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
import 'package:moor_flutter/moor_flutter.dart';

class ContactsInfoConverter extends TypeConverter<List<ContactInfoItem>, String> {
  const ContactsInfoConverter();
  @override
  List<ContactInfoItem> mapToDart(String fromDb) {
    if (fromDb == null) {
      return new List<ContactInfoItem>();
    }
    return json.decode(fromDb) as List<ContactInfoItem>;
  }

  @override
  String mapToSql(List<ContactInfoItem> value) {
    if (value == null) {
      return "[]";
    }

    return json.encode(value);
  }
}
