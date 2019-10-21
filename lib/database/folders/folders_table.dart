import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/app_store.dart';
import 'package:flutter/foundation.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:uuid/uuid.dart';

@DataClassName("LocalFolder")
class Folders extends Table {
  IntColumn get localId => integer().autoIncrement()();

  TextColumn get guid => text()();

  TextColumn get parentGuid => text().nullable()();

  IntColumn get accountId => integer()();

  IntColumn get type => integer()();

  IntColumn get order => integer()();

  TextColumn get name => text()();

  TextColumn get fullName => text()();

  TextColumn get fullNameRaw => text()();

  TextColumn get fullNameHash => text()();

  TextColumn get delimiter => text()();

  BoolColumn get isSubscribed => boolean()();

  BoolColumn get isSelectable => boolean()();

  BoolColumn get exists => boolean()();

  BoolColumn get extended => boolean().nullable()();

  BoolColumn get alwaysRefresh => boolean()();

  static Future<List<LocalFolder>> getFolderObjectsFromServerAsync(
      List<Map<String, dynamic>> rawFolders) {
    return compute(getFolderObjectsFromServer, rawFolders);
  }

// returns flat array of items
  static List<LocalFolder> getFolderObjectsFromServer(
      List<Map<String, dynamic>> rawFolders) {
    final uuid = Uuid();

    final flattenedFolders = new List<LocalFolder>();

    void getObj(List<Map<String, dynamic>> rawFolders, String parentGuid) {
      rawFolders.forEach((rawFolder) {
        final guid = uuid.v4();
        flattenedFolders.add(LocalFolder(
          localId: null,
          guid: guid,
          parentGuid: parentGuid,
          accountId: AppStore.authState.accountId,
          type: rawFolder["Type"],
          order: rawFolders.indexOf(rawFolder),
          name: rawFolder["Name"],
          fullName: rawFolder["FullName"],
          fullNameRaw: rawFolder["FullNameRaw"],
          fullNameHash: rawFolder["FullNameHash"],
          delimiter: rawFolder["Delimiter"],
          isSubscribed: rawFolder["IsSubscribed"],
          isSelectable: rawFolder["IsSelectable"],
          exists: rawFolder["Exists"],
          extended: rawFolder["Extended"],
          alwaysRefresh: rawFolder["AlwaysRefresh"],
        ));

        if (rawFolder["SubFolders"] != null) {
          getObj(
              new List<Map<String, dynamic>>.from(
                  rawFolder["SubFolders"]["@Collection"]),
              guid);
        }
      });
    }

    getObj(rawFolders, null);
    return flattenedFolders;
  }
}
