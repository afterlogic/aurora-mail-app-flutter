import 'dart:async';

import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/utils/error_handling.dart';
import 'package:bloc/bloc.dart';

import './bloc.dart';
import 'mail_methods.dart';

class MailBloc extends Bloc<MailEvent, MailState> {
  final _methods = new MailMethods();

  Folder _selectedFolder;
  bool _isStarredFilterEnabled = false;

  @override
  MailState get initialState => FoldersEmpty();

  @override
  Stream<MailState> mapEventToState(
    MailEvent event,
  ) async* {
    if (event is FetchFolders) yield* _fetchFolders(event);
    if (event is UpdateFolders) yield* _updateFolders(event);
    if (event is RefreshFolders) yield* _refreshFolders(event);
    if (event is RefreshMessages) yield* _refreshMessages(event);
    if (event is SelectFolder) yield* _selectFolder(event);
    if (event is CheckFoldersMessagesChanges)
      yield* _checkFoldersMessagesChanges(event);
    if (event is SetSeen) yield* _setSeen(event);
  }

  Stream<MailState> _fetchFolders(FetchFolders event) async* {
    yield FoldersLoading();

    try {
      final List<Folder> folders = await _methods.getFolders();

      if (folders.isNotEmpty) {
        if (_selectedFolder == null) {
          _selectedFolder = folders[0];
        } else {
          _selectedFolder = folders.firstWhere(
              (f) => f.localId == _selectedFolder.localId,
              orElse: () => folders[0]);
        }
        yield FoldersLoaded(
          folders,
          _selectedFolder,
          _isStarredFilterEnabled,
          PostFolderLoadedAction.subscribeToMessages,
        );
        final List<Folder> foldersWithInfo = await _methods.updateFoldersHash(
          _selectedFolder,
        );

        yield FoldersLoaded(foldersWithInfo, _selectedFolder, _isStarredFilterEnabled);

        final id = _selectedFolder.localId;
        _methods
            .syncFolders(localId: id, syncSystemFolders: true)
            .then((v) => add(UpdateFolders()));
      } else {
        yield FoldersEmpty();
      }
    } catch (err, s) {
      yield FoldersError(formatError(err, s));
    }
  }

  Stream<MailState> _updateFolders(UpdateFolders event) async* {
    final List<Folder> folders = await _methods.getFolders();

    _selectedFolder = folders.firstWhere(
        (f) => f.localId == _selectedFolder.localId,
        orElse: () => folders[0]);

    yield FoldersLoaded(
      folders,
      _selectedFolder,
      _isStarredFilterEnabled,
      PostFolderLoadedAction.stopMessagesRefresh,
    );
  }

  Stream<MailState> _refreshFolders(RefreshFolders event) async* {
    try {
      yield FoldersLoading();

      final newFolders = await _methods.refreshFolders();
      if (_selectedFolder == null && newFolders.isNotEmpty) {
        final List<Folder> foldersWithInfo =
            await _methods.updateFoldersHash(_selectedFolder);

        yield FoldersLoaded(foldersWithInfo, _selectedFolder,_isStarredFilterEnabled);

        final id = _selectedFolder.localId;
        _methods
            .syncFolders(localId: id, syncSystemFolders: true)
            .then((v) => add(UpdateFolders()));
      } else {
        yield FoldersEmpty();
      }

      yield FoldersLoaded(newFolders, _selectedFolder, _isStarredFilterEnabled);
    } catch (err, s) {
      yield FoldersError(formatError(err, s));
    }
  }

  Stream<MailState> _refreshMessages(RefreshMessages event) async* {
    try {
      final id = _selectedFolder.localId;
      final List<Folder> foldersWithInfo = await _methods.updateFoldersHash(
        _selectedFolder,
        forceCurrentFolderUpdate: true,
      );

      yield FoldersLoaded(foldersWithInfo, _selectedFolder, _isStarredFilterEnabled);

      _methods
          .syncFolders(localId: id, syncSystemFolders: true)
          .then((v) => add(UpdateFolders()));
    } catch (err, s) {
      yield FoldersError(formatError(err, s));
    }
  }

  Stream<MailState> _selectFolder(SelectFolder event) async* {
    try {
      final List<Folder> folders = await _methods.getFolders();
      _selectedFolder = event.folder;
      _isStarredFilterEnabled = event.isStarredFolder;
      yield FoldersLoaded(
        folders,
        _selectedFolder,
        event.isStarredFolder,
        PostFolderLoadedAction.subscribeToMessages,
      );

      final id = event.folder.localId;
      _methods.syncFolders(localId: id).then((v) => add(UpdateFolders()));
    } catch (err, s) {
      yield FoldersError(formatError(err, s));
    }
  }

  Stream<MailState> _checkFoldersMessagesChanges(
      CheckFoldersMessagesChanges event) async* {
    try {
      await _methods.updateFoldersHash(_selectedFolder);

      final id = _selectedFolder.localId;
      _methods.syncFolders(localId: id, syncSystemFolders: true);
    } catch (err, s) {
      yield FoldersError(formatError(err, s));
    }
  }

  Stream<MailState> _setSeen(SetSeen event) async* {
    await _methods.setMessagesSeen(folder: _selectedFolder, uids: event.uids);
    add(RefreshMessages());
  }
}
