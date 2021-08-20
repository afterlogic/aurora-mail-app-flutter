import 'dart:convert';
import 'dart:io';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/folders/folders_dao.dart';
import 'package:aurora_mail/database/white_mail/white_mail_dao.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:aurora_mail/modules/mail/repository/mail_api.dart';
import 'package:crypto_worker/crypto_worker.dart';
import 'package:crypto_worker/src/pgp/pgp_worker.dart';
import 'package:flutter/widgets.dart';

class MessageViewMethods {
  MailApi _mailApi;
  PgpWorker pgpWorker;
  final Account account;
  final User user;
  final _foldersDao = FoldersDao(DBInstances.appDB);
  final _whiteMailDao = WhiteMailDao(DBInstances.appDB);

  MessageViewMethods({
    @required this.user,
    @required this.account,
    this.pgpWorker,
  }) {
    _mailApi = new MailApi(user: user, account: account);
  }

  void downloadAttachment(
    MailAttachment attachment, {
    @required Function(String) onDownloadEnd,
    @required Function() onDownloadStart,
    Rect rect,
  }) {
    if (Platform.isIOS) {
      _mailApi.shareAttachment(attachment, onDownloadEnd, rect);
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
        (await _foldersDao.getByName(folder, account.localId))?.type);
  }

  Future<bool> checkInWhiteList(Message message) async {
    final List<String> emails = (json.decode(message.fromInJson)["@Collection"] as List)
        .map((item) => item["Email"] as String)
        .toList();
    if (message.safety == true) {
      await _whiteMailDao.add(emails);
      return true;
    } else {
      final whiteEmails = await _whiteMailDao.get();
      if (emails.firstWhere(
            (item) => !whiteEmails.contains(item),
            orElse: () => null,
          ) ==
          null) {
        return true;
      } else {
        return false;
      }
    }
  }

  Future addInWhiteList(Message message) async {
    final List<String> emails = (json.decode(message.fromInJson)["@Collection"] as List)
        .map((item) => item["Email"] as String)
        .toList();
    await _whiteMailDao.add(emails);
  }
}
