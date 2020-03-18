import 'dart:io';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/folders/folders_dao.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:aurora_mail/modules/mail/repository/mail_api.dart';
import 'package:crypto_worker/crypto_worker.dart';
import 'package:crypto_worker/src/pgp/pgp_worker.dart';
import 'package:flutter/widgets.dart';

class MessageViewMethods {
  MailApi _mailApi;
  PgpWorker pgpWorker;
  Account account;
  final _foldersDao = FoldersDao(DBInstances.appDB);

  MessageViewMethods({
    @required User user,
    @required this.account,
    this.pgpWorker,
  }) {
    _mailApi = new MailApi(user: user, account: account);
  }

  void downloadAttachment(
    MailAttachment attachment, {
    @required Function(String) onDownloadEnd,
    @required Function() onDownloadStart,
  }) {
    if (Platform.isIOS) {
      _mailApi.shareAttachment(attachment);
    } else {
      _mailApi.downloadAttachment(
        attachment,
        onDownloadEnd: onDownloadEnd,
        onDownloadStart: onDownloadStart,
      );
    }
  }

  EncryptType checkEncrypt(String text) {
    return pgpWorker.encryptType(text);
  }

  Future<Decrypted> decryptBody(
    EncryptType type,
    String password,
    String sender,
    String body,
  ) {
    final encryptDecrypt = pgpWorker.encryptDecrypt(sender, [account.email]);
    if (type == EncryptType.Encrypt) {
      return encryptDecrypt.decrypt(body, password);
    } else {
      return encryptDecrypt.verifySign(body);
    }
  }

  Future<FolderType> getFolderType(String folder) async {
    return Folder.getFolderTypeFromNumber(
        (await _foldersDao.getByName(folder)).type);
  }
}
