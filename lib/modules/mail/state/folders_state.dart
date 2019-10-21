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

  Future<void> onGetFolders(
      {Function(String) onError,
      LoadingType loading = LoadingType.visible}) async {
    try {
      isFoldersLoading = loading;
      final accountId = AppStore.authState.accountId;
      final rawFolders = await _foldersApi.getFolders(accountId);

      final newFolders =
          await Folders.getFolderObjectsFromServerAsync(rawFolders);
      await _foldersDao.addFolders(newFolders);

      final localFolders = await _foldersDao.getAllFolders(accountId);

      currentFolders = Folder.getFolderObjectsFromDb(localFolders);
    } catch (err, s) {
      print("onGetFolders err: $err");
      print("onGetFolders s: $s");
      onError(err.toString());
    } finally {
      isFoldersLoading = LoadingType.none;
    }
  }
}
