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

  Future<void> addFolders(List<LocalFolder> newFolders) async {
    return into(folders).insertAll(newFolders);
  }

  Future<int> deleteFolders([List<LocalFolder> filesToDelete]) async {
    if (filesToDelete == null) {
      return delete(folders).go();
    } else {
      final List<int> ids = filesToDelete.map((file) => file.localId).toList();
      return (delete(folders)
        ..where((file) => isIn(file.localId, ids))).go();
    }
  }
}
