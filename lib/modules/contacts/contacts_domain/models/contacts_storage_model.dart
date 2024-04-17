//@dart=2.9
import 'package:flutter/widgets.dart';

class ContactsStorage {
  final int sqliteId;
  final String id;
  final int userLocalId;
  final String name;
  final String uniqueName;
  final int cTag;
  final bool display;
  final String displayName;
  final String ownerMail;
  final bool isShared;
  // access codes - 1 == write, 2 == read
  final int accessCode;
  List<ContactInfoItem> contactsInfo;

  ContactsStorage({
    @required this.sqliteId,
    @required this.id,
    @required this.userLocalId,
    @required this.name,
    @required this.uniqueName,
    @required this.cTag,
    @required this.display,
    @required this.displayName,
    this.ownerMail,
    this.isShared,
    this.accessCode,
    @required this.contactsInfo,
  }) : assert(userLocalId != null);

  ContactsStorage copyWith({
    int sqliteId,
    String id,
    String name,
    String uniqueName,
    int cTag,
    bool display,
    String displayName,
    List<ContactInfoItem> contactsInfo,
  }) {
    return new ContactsStorage(
      sqliteId: sqliteId ?? this.sqliteId,
      id: id ?? this.id,
      userLocalId: userLocalId ?? this.userLocalId,
      name: name ?? this.name,
      uniqueName: uniqueName ?? this.uniqueName,
      cTag: cTag ?? this.cTag,
      display: display ?? this.display,
      displayName: displayName ?? this.displayName,
      ownerMail: ownerMail,
      isShared: isShared,
      accessCode: accessCode,
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
  }) : assert(storage != null);

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

  ContactInfoItem copyWith({
    String uuid,
    String storage,
    String eTag,
    bool hasBody,
    bool needsUpdate,
  }) {
    return new ContactInfoItem(
      uuid: uuid ?? this.uuid,
      storage: storage ?? this.storage,
      eTag: eTag ?? this.eTag,
      hasBody: hasBody ?? this.hasBody,
      needsUpdate: needsUpdate ?? this.needsUpdate,
    );
  }
}
