import 'dart:async';

import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/mail/bloc/mail_methods.dart';
import 'package:bloc/bloc.dart';

import 'bloc.dart';

class MailBloc extends Bloc<MailEvent, MailState> {
  final _methods = new MailMethods();

  Folder _selectedFolder;

  @override
  MailState get initialState => FoldersEmpty();

  @override
  Stream<MailState> mapEventToState(
    MailEvent event,
  ) async* {
    if (event is FetchFolders) yield* _fetchFolders(event);
    if (event is RefreshFolders) yield* _refreshFolders(event);
    if (event is SelectFolder) yield* _selectFolder(event);
    if (event is CheckFoldersUpdateByTimer)
      yield* _checkFoldersUpdateByTimer(event);
    if (event is RefreshMessages) yield* _refreshMessages(event);
  }

  Stream<MailState> _fetchFolders(FetchFolders event) async* {
    yield FoldersLoading();

    try {
      final List<Folder> folders = await _methods.getFolders();

      if (folders.isNotEmpty) {
        _selectedFolder = folders[0];
        yield FoldersLoaded(folders, _selectedFolder);
        yield SubscribedToMessages(
            _methods.subscribeToMessages(_selectedFolder));
        final List<Folder> foldersWithInfo = await _methods.updateFoldersHash(
          _selectedFolder,
        );

        yield FoldersLoaded(foldersWithInfo, _selectedFolder);

//        yield MessagesSyncing();
//        await _methods.syncFolders(
//            localId: _selectedFolder.localId, syncSystemFolders: true);
//        yield MessagesSynced();
        _methods.syncFolders(
            localId: _selectedFolder.localId, syncSystemFolders: true);
      } else {
        yield FoldersEmpty();
      }
    } catch (err) {
      yield MailError(err.toString());
    }
  }

  Stream<MailState> _refreshFolders(RefreshFolders event) async* {
    try {
      yield FoldersLoading();

      final newFolders = await _methods.refreshFolders();
      if (_selectedFolder == null && newFolders.isNotEmpty) {
        final List<Folder> foldersWithInfo =
            await _methods.updateFoldersHash(_selectedFolder);

        yield FoldersLoaded(foldersWithInfo, _selectedFolder);

//        yield MessagesSyncing();
//        await _methods.syncFolders(
//            localId: _selectedFolder.localId, syncSystemFolders: true);
//        yield MessagesSynced();
        _methods.syncFolders(
            localId: _selectedFolder.localId, syncSystemFolders: true);
      } else {
        yield FoldersEmpty();
      }

      yield FoldersLoaded(newFolders, _selectedFolder);
    } catch (err) {
      yield MailError(err.toString());
    }
  }

  Stream<MailState> _selectFolder(SelectFolder event) async* {
    try {
      final List<Folder> folders = await _methods.getFolders();
      _selectedFolder = event.folder;
      yield FoldersLoaded(folders, _selectedFolder);
      yield SubscribedToMessages(_methods.subscribeToMessages(_selectedFolder));

//      yield MessagesSyncing();
//      await _methods.syncFolders(localId: event.folder.localId);
//      yield MessagesSynced();
      _methods.syncFolders(localId: event.folder.localId);
    } catch (err) {
      yield MailError(err.toString());
    }
  }

  Stream<MailState> _checkFoldersUpdateByTimer(
      CheckFoldersUpdateByTimer event) async* {
    try {
      await _methods.updateFoldersHash(_selectedFolder);
//      yield MessagesSyncing();
//      await _methods.syncFolders(
//          localId: _selectedFolder.localId, syncSystemFolders: true);
//      yield MessagesSynced();
      _methods.syncFolders(
          localId: _selectedFolder.localId, syncSystemFolders: true);
    } catch (err) {
      yield MailError(err.toString());
    }
  }

  Stream<MailState> _refreshMessages(RefreshMessages event) async* {
    try {
      final List<Folder> foldersWithInfo = await _methods.updateFoldersHash(
        _selectedFolder,
        forceCurrentFolderUpdate: true,
      );

      yield FoldersLoaded(foldersWithInfo, _selectedFolder);

//      yield MessagesSyncing();
//      await _methods.syncFolders(
//          localId: _selectedFolder.localId, syncSystemFolders: true);
//      yield MessagesSynced();
      _methods.syncFolders(
          localId: _selectedFolder.localId, syncSystemFolders: true);
    } catch (err) {
      yield MailError(err.toString());
    }
  }
}
