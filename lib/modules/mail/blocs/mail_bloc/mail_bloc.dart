//@dart=2.9
import 'dart:async';

import 'package:aurora_logger/aurora_logger.dart';
import 'package:aurora_mail/background/background_helper.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/bloc.dart';
import 'package:aurora_mail/utils/api_utils.dart';
import 'package:bloc/bloc.dart';

import './bloc.dart';
import 'mail_methods.dart';

class MailBloc extends Bloc<MailEvent, MailState> {
  MailMethods _methods;
  User _user;
  Account _account;
  final updateMessageCounter = UpdateMessageCounter();
  static String selectedFolderGuid;

  MailBloc({
    User user,
    Account account,
  }) : super(FoldersEmpty()) {
    assert(user != null);
    init(user, account);
    BackgroundHelper.addOnEndAlarmObserver(true, onEndAlarm);
  }

  User get user => _user;

  Account get account => _account;

  Folder get selectedFolder => _selectedFolder;

  init(User user, Account account) {
    _user = user;
    _account = account;
    _methods?.close();
    _methods = new MailMethods(
      user: user,
      account: account,
      updateMessageCounter: updateMessageCounter,
    );
  }

  Folder _selectedFolder;
  MessagesFilter _filter = MessagesFilter.none;

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
    if (event is SelectFolderByName) yield* _selectFolderByName(event);
  }

  onEndAlarm(bool hasUpdate) async {
    if (hasUpdate) {
      add(RefreshMessages(null));
    }
  }

  Stream<MailState> _fetchFolders(FetchFolders event) async* {
    selectedFolderGuid = _selectedFolder?.guid;
    final previous = state;
    if (state is! FoldersLoaded) yield FoldersLoading();

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
        selectedFolderGuid = _selectedFolder?.guid;
        yield FoldersLoaded(
          folders,
          _selectedFolder,
          _filter,
          PostFolderLoadedAction.subscribeToMessages,
        );
        final List<Folder> foldersWithInfo = await _methods.updateFoldersHash(
          _selectedFolder,
        );

        yield FoldersLoaded(
          foldersWithInfo,
          _selectedFolder,
          _filter,
        );

        final guid = _selectedFolder.guid;
        _methods
            .syncFolders(guid: guid, syncSystemFolders: true)
            .then((v) => add(UpdateFolders()));
      } else {
        yield FoldersEmpty();
      }
    } catch (err, s) {
      logger.error(err, s);
      yield FoldersError(formatError(err, s));
      if (previous is FoldersLoaded) {
        yield previous;
      }
    }
  }

  Stream<MailState> _updateFolders(UpdateFolders event) async* {
    final List<Folder> folders = await _methods.getFolders();

    _selectedFolder = folders.firstWhere(
      (f) => f.guid == _selectedFolder.guid,
      orElse: () => folders[0],
    );

    yield FoldersLoaded(
      folders,
      _selectedFolder,
      _filter,
      PostFolderLoadedAction.stopMessagesRefresh,
    );
  }

  Stream<MailState> _refreshFolders(RefreshFolders event) async* {
    final previous = state;
    try {
      if (state is! FoldersLoaded) yield FoldersLoading();

      final newFolders = await _methods.refreshFolders();

      final List<Folder> foldersWithInfo =
          await _methods.updateFoldersHash(_selectedFolder);

      if (_selectedFolder == null && newFolders.isNotEmpty) {
        yield FoldersLoaded(
          foldersWithInfo,
          _selectedFolder,
          _filter,
        );

        final guid = _selectedFolder.guid;
        _methods
            .syncFolders(guid: guid, syncSystemFolders: true)
            .then((v) => add(UpdateFolders()));
      } else {
        yield FoldersEmpty();
      }

      yield FoldersLoaded(newFolders, _selectedFolder, _filter);
    } catch (err, s) {
      logger.error(err, s);

      yield FoldersError(formatError(err, s));
      if (previous is FoldersLoaded) {
        yield previous;
      }
    }
  }

  Stream<MailState> _refreshMessages(RefreshMessages event) async* {
    final previous = state;
    try {
      final guid = _selectedFolder.guid;
      await _methods.updateFolderHash(_selectedFolder);
      _methods
          .syncFolders(
            guid: guid,
            syncSystemFolders: true,
            forceUpdateMessagesInfo: true,
          )
          .then((v) {
            add(UpdateFolders());
          })
          .catchError((e, s) => logger.log("message update error: $e"))
          .whenComplete(() {
            event.completer?.complete();
          });
    } catch (err, s) {
      logger.error(err, s);

      yield FoldersError(formatError(err, s));
      if (previous is FoldersLoaded) {
        yield previous;
      }
    }
  }

  Stream<MailState> _selectFolder(SelectFolder event) async* {
    try {
      selectedFolderGuid = event.folder.guid;
      final List<Folder> folders = state is FoldersLoaded
          ? (state as FoldersLoaded).folders
          : await _methods.getFolders();

      _selectedFolder = event.folder;
      _filter = event.filter;

      yield FoldersLoaded(
        folders,
        _selectedFolder,
        event.filter,
        PostFolderLoadedAction.subscribeToMessages,
      );

      final guid = event.folder.guid;
      _methods
          .syncFolders(
            guid: guid,
            syncSystemFolders: false,
          )
          .then((v) => add(UpdateFolders()));
    } catch (err, s) {
      logger.error(err, s);

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
        if (state is! FoldersLoaded) yield FoldersLoading();
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
      logger.error(err, s);

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

  Stream<MailState> _selectFolderByName(SelectFolderByName event) async* {
    final folder = await _methods.getFolderByName(event.name);
    add(SelectFolder(folder));
  }

  Future<Message> getFullMessage(int localId) {
    return _methods.getMessage(localId);
  }

  Future<LocalFolder> getFolderByType(FolderType folderType) {
    return _methods.getFolderByType(folderType);
  }

  Future<Folder> updateFolder(Folder selectedFolder) {
    return _methods.getFolder(selectedFolder.guid);
  }

  Future<Message> getMessageByLocalId(int uid) {
    return _methods.getMessage(uid);
  }

  Future<Message> getMessageById(String messageId, String folder) {
    return _methods.getMessageById(messageId, folder);
  }
}

class UpdateMessageCounter {
  Folder folder;
  int total;
  int current;
  Function onUpdate;

  void empty() {
    folder = null;
    total = null;
    current = null;
    onUpdate?.call();
  }

  void update(Folder folder, int total, int current) {
    this.folder = folder;
    this.total = total;
    this.current = current;
    onUpdate?.call();
  }
}
