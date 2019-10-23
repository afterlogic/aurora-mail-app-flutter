import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/mail/mail_dao.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/app_store.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'mail_state.g.dart';

class MailState = _MailState with _$MailState;

abstract class _MailState with Store {
  final _mailDao = new MailDao(AppStore.appDb);

  final scaffoldKey = GlobalKey<ScaffoldState>();

  Stream<List<Message>> onWatchMessages(Folder folder) {
    return _mailDao.watchMessages(folder.fullNameRaw);
  }
}
