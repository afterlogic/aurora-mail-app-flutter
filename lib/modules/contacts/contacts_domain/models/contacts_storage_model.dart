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

  ContactsStorage copyWith({
    int sqliteId,
    String id,
    String name,
    int cTag,
    bool display,
    List<ContactInfoItem> contactsInfo,
  }) {
    return new ContactsStorage(
      sqliteId: sqliteId ?? this.sqliteId,
      id: id ?? this.id,
      name: name ?? this.name,
      cTag: cTag ?? this.cTag,
      display: display ?? this.display,
      contactsInfo: contactsInfo ?? this.contactsInfo,
    );
  }
}

class ContactInfoItem {
  final String uuid;
  final String storage;
  String get uuidPlusStorage => uuid + storage;
  String eTag;
  bool hasBody;
  bool needsUpdate;

  ContactInfoItem({
    @required this.uuid,
    @required this.storage,
    @required this.eTag,
    this.hasBody = false,
    this.needsUpdate = false,
  }) : assert (storage != null);

  Map<String, dynamic> toMap() {
    return {
      'uuid': this.uuid,
      'storage': this.storage,
      'eTag': this.eTag,
      'hasBody': this.hasBody,
      'needsUpdate': this.needsUpdate,
    };
  }

  factory ContactInfoItem.fromMap(Map<String, dynamic> map) {
    return new ContactInfoItem(
      uuid: map['uuid'] as String,
      storage: map['storage'] as String,
      eTag: map['eTag'] as String,
      hasBody: map['hasBody'] as bool,
      needsUpdate: map['needsUpdate'] as bool,
    );
  }
}
