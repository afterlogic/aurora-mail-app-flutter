import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/folders/folders_dao.dart';
import 'package:aurora_mail/database/folders/folders_table.dart';
import 'package:aurora_mail/database/mail/mail_dao.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/mail/repository/mail_api.dart';
import 'package:flutter/widgets.dart';

class ComposeMethods {
  final _mailDao = new MailDao(DBInstances.appDB);
  final _foldersDao = new FoldersDao(DBInstances.appDB);
  final _mailApi = new MailApi();

  Future<void> sendMessage({
    @required String to,
    @required String cc,
    @required String bcc,
    @required String subject,
    @required String messageText,
    @required int draftUid,
  }) async {
    final folders = await _foldersDao.getAllFolders();

    final draftsFolder = Folders.getFolderOfType(folders, FolderType.drafts);
    final sentFolder = Folders.getFolderOfType(folders, FolderType.sent);

    return _mailApi.sendMessage(
      to: to,
      cc: cc,
      bcc: bcc,
      subject: subject,
      messageText: messageText,
      draftUid: draftUid,
      sentFolderName: sentFolder != null ? sentFolder.fullNameRaw : null,
      draftsFolderName: draftsFolder != null ? draftsFolder.fullNameRaw : null,
    );
  }

  Future<int> saveToDrafts({
    @required String to,
    @required String cc,
    @required String bcc,
    @required String subject,
    @required String messageText,
    @required int draftUid,
  }) async {
    final folders = await _foldersDao.getAllFolders();
    final draftsFolder = Folders.getFolderOfType(folders, FolderType.drafts);

    return _mailApi.saveMessage(
      to: to,
      cc: cc,
      bcc: bcc,
      subject: subject,
      messageText: messageText,
      draftUid: draftUid,
      draftsFolderName: draftsFolder != null ? draftsFolder.fullNameRaw : null,
    );
  }
}
