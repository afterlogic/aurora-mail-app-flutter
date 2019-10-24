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

  IntColumn get folderOrder => integer()();

  IntColumn get count => integer().named("messages_count").nullable()();

  IntColumn get unread => integer().nullable()();

  TextColumn get name => text()();

  TextColumn get fullName => text()();

  TextColumn get fullNameRaw => text()();

  TextColumn get fullNameHash => text()();

  TextColumn get delimiter => text()();

  BoolColumn get needsInfoUpdate => boolean()();

  BoolColumn get isSystemFolder => boolean()();

  BoolColumn get isSubscribed => boolean()();

  BoolColumn get isSelectable => boolean()();

  BoolColumn get folderExists => boolean()();

  BoolColumn get extended => boolean().nullable()();

  BoolColumn get alwaysRefresh => boolean()();

  TextColumn get messagesInfoInJson => text().nullable()();

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
        final t = rawFolder["Type"];
        flattenedFolders.add(LocalFolder(
          localId: null,
          guid: guid,
          parentGuid: parentGuid,
          accountId: AppStore.authState.accountId,
          type: rawFolder["Type"],
          folderOrder: rawFolders.indexOf(rawFolder),
          name: rawFolder["Name"],
          fullName: rawFolder["FullName"],
          fullNameRaw: rawFolder["FullNameRaw"],
          fullNameHash: rawFolder["FullNameHash"],
          delimiter: rawFolder["Delimiter"],
          needsInfoUpdate: true,
          // the folder is system if it's inbox, sent or drafts
          isSystemFolder: t == 1 || t == 2 || t == 3,
          isSubscribed: rawFolder["IsSubscribed"],
          isSelectable: rawFolder["IsSelectable"],
          folderExists: rawFolder["Exists"],
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
