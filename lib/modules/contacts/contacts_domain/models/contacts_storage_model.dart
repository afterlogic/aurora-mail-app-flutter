import 'package:flutter/widgets.dart';

class ContactsStorage {
  final int sqliteId;
  final String id;
  final String name;
  final int cTag;
  List<ContactInfoItem> contactsInfo;

  ContactsStorage({
    @required this.sqliteId,
    @required this.id,
    @required this.name,
    @required this.cTag,
    @required this.contactsInfo,
  });
}

class ContactInfoItem {
  final String uuid;
  String eTag;
  bool hasBody;

  ContactInfoItem({
    @required this.uuid,
    @required this.eTag,
    this.hasBody = false,
  });
}
