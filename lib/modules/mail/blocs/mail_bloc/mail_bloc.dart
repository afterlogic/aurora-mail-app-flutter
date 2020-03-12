import 'dart:async';

import 'package:aurora_mail/background/background_helper.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/bloc.dart';
import 'package:aurora_mail/utils/api_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import './bloc.dart';
import 'mail_methods.dart';

class MailBloc extends Bloc<MailEvent, MailState> {
  MailMethods _methods;

  MailBloc({@required User user, @required Account account}) {
    assert(user != null);
    _methods = new MailMethods(user: user, account: account);
    BackgroundHelper.addOnEndAlarmObserver(true, onEndAlarm);
  }

  init(User user, Account account) {
    _methods = new MailMethods(user: user, account: account);
  }

  Folder _selectedFolder;
  MessagesFilter _filter = MessagesFilter.none;

  @override
  MailState get initialState => FoldersEmpty();

  @override
  Future<void> close() async {
    BackgroundHelper.removeOnEndAlarmObserver(onEndAlarm);
    super.close();
  }

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
    if (event is SetStarred) yield* _setStarred(event);
  }

  onEndAlarm(bool hasUpdate) async {
    if (hasUpdate) {
      add(RefreshMessages());
    }
    add(RefreshFolders());
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
              (f) => f.guid == _selectedFolder.guid,
              orElse: () => folders[0]);
        }
        yield FoldersLoaded(
          folders,
          _selectedFolder,
          _filter,
          PostFolderLoadedAction.subscribeToMessages,
        );
        final List<Folder> foldersWithInfo = await _methods.updateFoldersHash(
          _selectedFolder,
        );

        yield FoldersLoaded(foldersWithInfo, _selectedFolder, _filter);

        final guid = _selectedFolder.guid;
        _methods
            .syncFolders(guid: guid, syncSystemFolders: true)
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

    _selectedFolder = folders.firstWhere((f) => f.guid == _selectedFolder.guid,
        orElse: () => folders[0]);

    yield FoldersLoaded(
      folders,
      _selectedFolder,
      _filter,
      PostFolderLoadedAction.stopMessagesRefresh,
    );
  }

  Stream<MailState> _refreshFolders(RefreshFolders event) async* {
    if (event.updateOther) {
      BackgroundHelper.onStartAlarm();
    }
    try {
      yield FoldersLoading();

      final newFolders = await _methods.refreshFolders();
      final List<Folder> foldersWithInfo =
          await _methods.updateFoldersHash(_selectedFolder);

      if (_selectedFolder == null && newFolders.isNotEmpty) {
        yield FoldersLoaded(foldersWithInfo, _selectedFolder, _filter);

        final guid = _selectedFolder.guid;
        _methods
            .syncFolders(guid: guid, syncSystemFolders: true)
            .then((v) => add(UpdateFolders()));
      } else {
        yield FoldersEmpty();
      }

      yield FoldersLoaded(newFolders, _selectedFolder, _filter);
    } catch (err, s) {
      yield FoldersError(formatError(err, s));
    }
    if (event.updateOther) {
      BackgroundHelper.onEndAlarm(false);
    }
  }

  Stream<MailState> _refreshMessages(RefreshMessages event) async* {
    if (event.updateOther) {
      BackgroundHelper.onStartAlarm();
    }
    try {
      final guid = _selectedFolder.guid;
      final List<Folder> foldersWithInfo = await _methods.updateFoldersHash(
        _selectedFolder,
        forceCurrentFolderUpdate: true,
      );

      yield FoldersLoaded(foldersWithInfo, _selectedFolder, _filter);

      _methods
          .syncFolders(guid: guid, syncSystemFolders: true)
          .then((v) => add(UpdateFolders()));
    } catch (err, s) {
      yield FoldersError(formatError(err, s));
    }
    if (event.updateOther) {
      BackgroundHelper.onEndAlarm(false);
    }
  }

  Stream<MailState> _selectFolder(SelectFolder event) async* {
    try {
      final List<Folder> folders = await _methods.getFolders();
      _selectedFolder = event.folder;
      _filter = event.filter;
      yield FoldersLoaded(
        folders,
        _selectedFolder,
        event.filter,
        PostFolderLoadedAction.subscribeToMessages,
      );

      final guid = event.folder.guid;
      _methods.syncFolders(guid: guid).then((v) => add(UpdateFolders()));
    } catch (err, s) {
      yield FoldersError(formatError(err, s));
    }
  }

  Stream<MailState> _checkFoldersMessagesChanges(
      CheckFoldersMessagesChanges event) async* {
    try {
      final state = this.state;
      if (state is FoldersLoaded) {
        yield state.copyWith(isProgress: true);
      } else {
        yield FoldersLoading();
      }
      final folders = await _methods.updateFoldersHash(_selectedFolder);

      final guid = _selectedFolder.guid;
      await _methods.syncFolders(guid: guid, syncSystemFolders: true);

      yield FoldersLoaded(
        folders,
        _selectedFolder,
        _filter,
      );
    } catch (err, s) {
      yield FoldersError(formatError(err, s));
    }
  }

  Stream<MailState> _setSeen(SetSeen event) async* {
    _methods.setMessagesSeen(
      folder: _selectedFolder,
      messages: event.messages,
      isSeen: event.isSeen,
    );
  }

  Stream<MailState> _setStarred(SetStarred event) async* {
    _methods.setMessagesStarred(
      folder: _selectedFolder,
      messages: event.messages,
      isStarred: event.isStarred,
    );
  }

  Future<Message> getFullMessage(Message item) {
    return _methods.getMessage(item);
  }
}
