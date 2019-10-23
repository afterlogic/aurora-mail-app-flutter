import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/folders/folders_dao.dart';
import 'package:aurora_mail/database/folders/folders_table.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/models/loading_enum.dart';
import 'package:aurora_mail/modules/app_store.dart';
import 'package:aurora_mail/modules/mail/repository/folders_api.dart';
import 'package:mobx/mobx.dart';

part 'folders_state.g.dart';

class FoldersState = _FoldersState with _$FoldersState;

abstract class _FoldersState with Store {
  final _foldersApi = new FoldersApi();
  final _foldersDao = new FoldersDao(AppStore.appDb);

  List<Folder> currentFolders = new List();

  @observable
  LoadingType isFoldersLoading = LoadingType.none;

  @observable
  Folder selectedFolder;

  Future<void> onGetFolders(
      {Function(String) onError,
      LoadingType loading = LoadingType.visible}) async {
    try {
      isFoldersLoading = loading;
      final accountId = AppStore.authState.accountId;

      List<LocalFolder> localFolders =
          await _foldersDao.getAllFolders(accountId);

      // if folders or if refreshed
      if (localFolders == null ||
          localFolders.isEmpty ||
          loading == LoadingType.refresh) {
        final rawFolders = await _foldersApi.getFolders(accountId);

        final newFolders =
            await Folders.getFolderObjectsFromServerAsync(rawFolders);
        await _foldersDao.deleteFolders();
        await _foldersDao.addFolders(newFolders);

        localFolders = await _foldersDao.getAllFolders(accountId);
      }

      currentFolders = Folder.getFolderObjectsFromDb(localFolders);
      selectedFolder = currentFolders[0];
      _watchFolders(accountId);
    } catch (err, s) {
      print("onGetFolders err: $err");
      print("onGetFolders s: $s");
      onError(err.toString());
    } finally {
      isFoldersLoading = LoadingType.none;
    }
  }

  Future _watchFolders(int accountId) async {
    await for (final newFolders in _foldersDao.watchAllFolders(accountId)) {
      currentFolders = Folder.getFolderObjectsFromDb(newFolders);
      if (selectedFolder == null) selectedFolder = currentFolders[0];
    }
  }
}
