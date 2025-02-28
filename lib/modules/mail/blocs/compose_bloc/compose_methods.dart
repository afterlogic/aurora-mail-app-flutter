//@dart=2.9
import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/folders/folders_dao.dart';
import 'package:aurora_mail/database/folders/folders_table.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/mappers/contact_mapper.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/contacts/contacts_dao.dart';
import 'package:aurora_mail/modules/mail/models/compose_attachment.dart';
import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:aurora_mail/modules/mail/models/temp_attachment_upload.dart';
import 'package:aurora_mail/modules/mail/repository/mail_api.dart';
import 'package:aurora_mail/modules/settings/screens/debug/default_api_interceptor.dart';
import 'package:crypto_worker/crypto_worker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_uploader/flutter_uploader.dart';

class ComposeMethods {
  final Account account;
  final PgpWorker pgpWorker;
  final _foldersDao = new FoldersDao(DBInstances.appDB);
  final _contactsDao = new ContactsDao(DBInstances.appDB);
  MailApi _mailApi;

  ComposeMethods({
    @required User user,
    @required this.account,
    @required this.pgpWorker,
  }) {
    _mailApi = new MailApi(
      user: user,
      account: account,
      interceptor: DefaultApiInterceptor.get(),
    );
  }

  Future<void> sendNote({
    @required String folderFullName,
    @required String subject,
    @required String text,
    String uid,

  }) async {
    return _mailApi.sendNote(
        folderFullName: folderFullName, subject: subject, text: text, uid: uid);
  }

  Future<void> sendMessage({
    @required String to,
    @required String cc,
    @required String bcc,
    @required bool isHtml,
    @required String subject,
    @required List<ComposeAttachment> composeAttachments,
    @required String messageText,
    @required int draftUid,
    Account sender,
    AccountIdentity identity,
    Aliases alias,
  }) async {
    final folders = await _foldersDao.getAllFolders(account.localId);

    final draftsFolder = Folders.getFolderOfType(folders, FolderType.drafts);
    final sentFolder = Folders.getFolderOfType(folders, FolderType.sent);

    return _mailApi.sendMessage(
        to: to,
        cc: cc,
        bcc: bcc,
        subject: subject,
        isHtml: isHtml,
        composeAttachments: composeAttachments,
        messageText: messageText,
        draftUid: draftUid,
        sentFolderName: sentFolder != null ? sentFolder.fullNameRaw : null,
        draftsFolderName:
            draftsFolder != null ? draftsFolder.fullNameRaw : null,
        identity: identity,
        alias: alias);
  }

  Future<int> saveToDrafts({
    @required String to,
    @required String cc,
    @required String bcc,
    @required String subject,
    @required List<ComposeAttachment> composeAttachments,
    @required String messageText,
    @required int draftUid,
    bool isHtml,
    AccountIdentity identity,
    Aliases alias,
  }) async {
    final folders = await _foldersDao.getAllFolders(account.localId);
    final draftsFolder = Folders.getFolderOfType(folders, FolderType.drafts);

    return _mailApi.saveMessage(
      to: to,
      cc: cc,
      bcc: bcc,
      subject: subject,
      isHtml: isHtml,
      composeAttachments: composeAttachments,
      messageText: messageText,
      draftUid: draftUid,
      draftsFolderName: draftsFolder != null ? draftsFolder.fullNameRaw : null,
      identity: identity,
      alias: alias,
    );
  }

  Future uploadFile(
    File file, {
    @required Function(TempAttachmentUpload) onUploadStart,
    @required Function(ComposeAttachment) onUploadEnd,
    @required Function(dynamic) onError,
  }) async {
    if (file == null) return null;

    await _mailApi.uploadAttachment(file,
        onUploadStart: onUploadStart,
        onUploadEnd: onUploadEnd,
        onError: onError);
  }

  Future<List<ComposeAttachment>> getComposeAttachments(
    List<MailAttachment> attachments,
  ) async {
    // filter out inline attachments
    final filteredAttachments = attachments.where((a) => !a.isInline).toList();
    if (filteredAttachments.isEmpty) return new List<ComposeAttachment>();
    return _mailApi.saveAttachmentsAsTempFiles(filteredAttachments);
  }

  Future<List<ComposeAttachment>> saveContactsAsTempFiles(
      List<Contact> contacts) {
    final futures = contacts.map((c) => _mailApi.saveContactAsTempFile(c));
    return Future.wait(futures);
  }

  Future<String> encrypt(
    bool sign,
    bool encrypt,
    String pass,
    List<String> contacts,
    String body,
    String sender,
  ) async {
    try {
      final encryptDecrypt = pgpWorker.encryptDecrypt(
        sign ? sender : null,
        contacts,
      );

      if (encrypt) {
        return await encryptDecrypt.encrypt(body, sign ? pass : null);
      } else if (sign) {
        return await encryptDecrypt.sign(body, pass);
      }
      return "";
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  uploadEmlAttachments(
    Message message, {
    Function(TempAttachmentUpload tempAttachment) onUploadStart,
    Function(ComposeAttachment attachment) onUploadEnd,
    Function(dynamic) onError,
  }) async {
    final taskId = Random().nextInt(1000).toString();
    final completer = Completer<UploadTaskProgress>();
    final tempAttachment = new TempAttachmentUpload(
      null,
      name: message.subject + ".eml",
      size: 1,
      taskId: taskId,
      uploadProgress: completer.future.asStream().asBroadcastStream(),
      cancel: ({String taskId}) {},
    );
    onUploadStart(tempAttachment);
    try {
      final attachment = await _mailApi.uploadEmlAttachments(message);
      attachment.guid = tempAttachment.guid;
      attachment.file = tempAttachment.file;
      completer.complete(
        UploadTaskProgress(taskId, 100, UploadTaskStatus.complete),
      );
      tempAttachment.size = attachment.size;
      onUploadEnd(attachment);
    } catch (e) {
      onError(e);
      completer.complete(
        UploadTaskProgress(taskId, 0, UploadTaskStatus.failed),
      );
    }
  }

  Future<List<Contact>> getContacts(String email) async {
    return ContactMapper.listFromDB(
        await _contactsDao.getContactsByEmail(email));
  }

  Future<List<ComposeAttachment>> getMessageAttachment(Message message) {
    return getComposeAttachments(
        MailAttachment.fromJsonString(message.attachmentsInJson));
  }
}
