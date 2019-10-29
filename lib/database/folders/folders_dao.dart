import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/models/message_info.dart';
import 'package:moor_flutter/moor_flutter.dart';

import '../app_database.dart';
import 'folders_table.dart';

part 'folders_dao.g.dart';

@UseDao(tables: [Folders])
class FoldersDao extends DatabaseAccessor<AppDatabase> with _$FoldersDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  FoldersDao(AppDatabase db) : super(db);

  Future<List<LocalFolder>> getAllFolders(int accountId) {
    return (select(folders)
          ..where((folder) => folder.accountId.equals(accountId)))
        .get();
  }

  Future<Folder> getFolder(int localId) async {
    final foundFolders = await (select(folders)
          ..where((folder) => folder.localId.equals(localId)))
        .get();

    return foundFolders.isEmpty
        ? null
        : Folder.getFolderObjectsFromDb(
            foundFolders, foundFolders[0].parentGuid)[0];
  }

  Stream<List<LocalFolder>> watchAllFolders(int accountId) {
    return (select(folders)
          ..where((folder) => folder.accountId.equals(accountId)))
        .watch();
  }

  Future<void> addFolders(List<LocalFolder> newFolders) async {
    return into(folders).insertAll(newFolders);
  }

  Future<int> setMessagesInfo(int localId, List<MessageInfo> messagesInfo) {
    final messagesInfoInJson = MessageInfo.toJsonString(messagesInfo);
    return (update(folders)..where((f) => f.localId.equals(localId))).write(
      FoldersCompanion(
        messagesInfoInJson: Value(messagesInfoInJson),
      ),
    );
  }

  Future<void> updateFolder(FoldersCompanion foldersCompanion, int id) {
    return (update(folders)..where((f) => f.localId.equals(id)))
        .write(foldersCompanion);
  }

  Future<int> deleteFolders([List<LocalFolder> filesToDelete]) async {
    if (filesToDelete == null) {
      return delete(folders).go();
    } else {
      final List<int> ids = filesToDelete.map((file) => file.localId).toList();
      return (delete(folders)..where((f) => isIn(f.localId, ids))).go();
    }
  }
}
