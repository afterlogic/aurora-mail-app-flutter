import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/models/message_info.dart';
import 'package:moor_flutter/moor_flutter.dart';

import '../app_database.dart';
import 'folders_table.dart';

part 'folders_dao.g.dart';

@UseDao(tables: [Folders])
class FoldersDao extends DatabaseAccessor<AppDatabase> with _$FoldersDaoMixin {
  FoldersDao(AppDatabase db) : super(db);

  Future<List<LocalFolder>> getAllFolders(int accountLocalId) {
    return (select(folders)
          ..where((folder) => folder.accountLocalId.equals(accountLocalId)))
        .get();
  }

  Future<List<LocalFolder>> getByType(int type, int accountLocalId) {
    return (select(folders)
          ..where((folder) => folder.accountLocalId.equals(accountLocalId))
          ..where((folder) => folder.type.equals(type)))
        .get();
  }

  Future<Folder> getFolderByLocalId(String guid) async {
    final foundFolders = await (select(folders)
          ..where((folder) => folder.guid.equals(guid)))
        .get();

    return foundFolders.isEmpty
        ? null
        : Folder.getFolderObjectsFromDb(
            foundFolders, foundFolders[0].parentGuid)[0];
  }

//  Stream<List<LocalFolder>> watchAllFolders(int accountLocalId) {
//    return (select(folders)
//          ..where((folder) => folder.accountLocalId.equals(accountLocalId)))
//        .watch();
//  }

  Future<void> addFolders(List<LocalFolder> newFolders) async {
    return batch((b) {
      return b.insertAll(folders, newFolders,mode: InsertMode.insertOrReplace);
    });
  }

  Future<int> setMessagesInfo(String guid, List<MessageInfo> messagesInfo) {
    final messagesInfoInJson = MessageInfo.toJsonString(messagesInfo);
    return (update(folders)..where((f) => f.guid.equals(guid))).write(
      FoldersCompanion(
        messagesInfoInJson: Value(messagesInfoInJson),
      ),
    );
  }

  Future<void> updateFolder(FoldersCompanion foldersCompanion, String guid) {
    return (update(folders)..where((f) => f.guid.equals(guid)))
        .write(foldersCompanion);
  }

  Future<int> deleteFolders([List<LocalFolder> foldersToDelete]) async {
    if (foldersToDelete == null) {
      return delete(folders).go();
    } else {
      final List<String> guid =
          foldersToDelete.map((file) => file.guid).toList();
      return (delete(folders)..where((f) => f.guid.isIn(guid))).go();
    }
  }

  Future<int> deleteFoldersOfUser(int userLocalId) async {
    return (delete(folders)..where((f) => f.userLocalId.equals(userLocalId)))
        .go();
  }
}
