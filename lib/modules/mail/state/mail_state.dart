import 'package:aurora_mail/database/folders/folders_dao.dart';
import 'package:aurora_mail/database/mail/mail_dao.dart';
import 'package:aurora_mail/modules/app_store.dart';
import 'package:aurora_mail/modules/mail/repository/mail_api.dart';
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

  Future<void> onSetMessagesInfoToFolder(String folderName) async {
    final rawInfo = await _mailApi.getMessagesInfo(
      folderName: folderName,
      accountId: _authState.accountId,
    );

    await _foldersDao.setMessagesInfo(folderName, rawInfo);
  }
}
