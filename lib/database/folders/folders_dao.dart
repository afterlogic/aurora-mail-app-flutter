import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/models/message_info.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:moor_flutter/moor_flutter.dart';

import '../app_database.dart';
import 'folders_table.dart';

part 'folders_dao.g.dart';

@UseDao(tables: [Folders])
class FoldersDao extends DatabaseAccessor<AppDatabase> with _$FoldersDaoMixin {
  int get _accountId => AuthBloc.currentAccount.accountId;

  // this constructor is required so that the main database can create an instance
  // of this object.
  FoldersDao(AppDatabase db) : super(db);

  Future<List<LocalFolder>> getAllFolders() {
    return (select(folders)
          ..where((folder) => folder.accountId.equals(_accountId)))
        .get();
  }

  Future<List<LocalFolder>> getByType(int type) {
    return (select(folders)
          ..where((folder) => folder.accountId.equals(_accountId))
          ..where((folder) => folder.type.equals(type)))
        .get();
  }

  Future<Folder> getFolderByLocalId(int localId) async {
    final foundFolders = await (select(folders)
          ..where((folder) => folder.localId.equals(localId)))
        .get();

    return foundFolders.isEmpty
        ? null
        : Folder.getFolderObjectsFromDb(
            foundFolders, foundFolders[0].parentGuid)[0];
  }

  Future<Folder> getFolderByRawName(String fullNameRaw) async {
    final foundFolders = await (select(folders)
          ..where((folder) => folder.fullNameRaw.equals(fullNameRaw)))
        .get();

    return foundFolders.isEmpty
        ? null
        : Folder.getFolderObjectsFromDb(
            foundFolders, foundFolders[0].parentGuid)[0];
  }

  Stream<List<LocalFolder>> watchAllFolders() {
    return (select(folders)
          ..where((folder) => folder.accountId.equals(_accountId)))
        .watch();
  }

  Future<void> addFolders(List<LocalFolder> newFolders) async {
    return batch((b) {
      return b.insertAll(folders, newFolders);
    });
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
      return (delete(folders)..where((f) => f.localId.isIn(ids))).go();
    }
  }
}
