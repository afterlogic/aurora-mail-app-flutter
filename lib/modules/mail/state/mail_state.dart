import 'dart:convert';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/folders/folders_dao.dart';
import 'package:aurora_mail/database/mail/mail_dao.dart';
import 'package:aurora_mail/database/mail/mail_table.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/models/loading_enum.dart';
import 'package:aurora_mail/modules/app_store.dart';
import 'package:aurora_mail/modules/mail/repository/mail_api.dart';
import 'package:aurora_mail/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'mail_state.g.dart';

class MailState = _MailState with _$MailState;

abstract class _MailState with Store {
  final _mailApi = new MailApi();
  final _mailDao = new MailDao(AppStore.appDb);
  final _foldersDao = new FoldersDao(AppStore.appDb);
  final _foldersState = AppStore.foldersState;
  final _authState = AppStore.authState;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @observable
  LoadingType isMessagesLoading = LoadingType.none;

  Future<void> onSetMessagesInfoToFolder(Folder folder,
      {Function(String) onError}) async {
    isMessagesLoading = LoadingType.hidden;
    try {
      if (folder.messagesInfo == null) {
        final rawInfo = await _mailApi.getMessagesInfo(
          folderName: folder.fullNameRaw,
          accountId: _authState.accountId,
        );

        await _foldersDao.setMessagesInfo(folder.fullNameRaw, rawInfo);
      }
      _syncMessagesChunk(folder);
    } catch (err, s) {
      print("onSetMessagesInfoToFolder: err: ${err}");
      print("onSetMessagesInfoToFolder: s: ${s}");
      onError(err.toString());
      isMessagesLoading = LoadingType.none;
    }
  }

  Future<void> _syncMessagesChunk(Folder selectedFolder) async {
    try {
      final folderName = selectedFolder.fullNameRaw;

      final folder = await _foldersDao.getFolder(selectedFolder.localId);

      final String infoInJson = folder[0].messagesInfoInJson;

      final uidsAndUpdateInfo = _takeChunk(infoInJson);
      final uids = uidsAndUpdateInfo["uids"];
      final updatedInfo = uidsAndUpdateInfo["updatedInfo"];

      final rawBodies = await _mailApi.getMessageBodies(
          folderName: folderName, accountId: _authState.accountId, uids: uids);

      final messages = Mail.getMessageObjFromServer(rawBodies, updatedInfo);

      _mailDao.addMessages(messages);

      final String encodedInfo = json.encode(updatedInfo);

      await _foldersDao.setMessagesInfo(folderName, encodedInfo);

      isMessagesLoading = LoadingType.visible;
      _syncMessagesChunk(_foldersState.selectedFolder);
    } catch (err, s) {
      // TODO VO: Load messages from Inbox, Sent, Drafts if the current folder is fully synced
      isMessagesLoading = LoadingType.none;
    }
  }

  // returns list of uids to load
  Map<String, List> _takeChunk(String encodedInfo) {
    final uids = new List<int>();
    final List info = json.decode(encodedInfo);
    int iteration = 0;

    void updateInfoObjAndGetUid(List messagesInfo, [int parentUid]) {
      for (final info in messagesInfo) {
        if (iteration < MESSAGES_PER_CHUNK) {
          if (info["hasBody"] != true) {
            info["hasBody"] = true;
            info["parentUid"] = parentUid;
            uids.add(info["uid"]);
            iteration++;
          }

          if (info["thread"] is List) {
            updateInfoObjAndGetUid(info["thread"], info["uid"]);
          }
        }
      }
    }

    updateInfoObjAndGetUid(info);
    assert(iteration <= MESSAGES_PER_CHUNK);

    return {
      "uids": uids,
      "updatedInfo": info,
    };
  }

  Stream<List<Message>> onWatchMessages() {
    return _mailDao.watchMessages(_foldersState.selectedFolder.fullNameRaw);
  }
}
