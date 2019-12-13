import 'package:flutter/widgets.dart';

class ContactsStorage {
  final int sqliteId;
  final String id;
  final String name;
  final int cTag;
  final bool display;
  List<ContactInfoItem> contactsInfo;

  ContactsStorage({
    @required this.sqliteId,
    @required this.id,
    @required this.name,
    @required this.cTag,
    @required this.display,
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

  Map<String, dynamic> toMap() {
    return {
      'uuid': this.uuid,
      'eTag': this.eTag,
      'hasBody': this.hasBody,
    };
  }

  factory ContactInfoItem.fromMap(Map<String, dynamic> map) {
    return new ContactInfoItem(
      uuid: map['uuid'] as String,
      eTag: map['eTag'] as String,
      hasBody: map['hasBody'] as bool,
    );
  }
}
