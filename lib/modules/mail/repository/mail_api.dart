import 'dart:convert';
import 'dart:io';

import 'package:aurora_mail/models/api_body.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/models/compose_attachment.dart';
import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:aurora_mail/modules/mail/models/temp_attachment_upload.dart';
import 'package:aurora_mail/utils/api_utils.dart';
import 'package:aurora_mail/utils/file_utils.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

class MailApi {
  int get _accountId => AuthBloc.currentAccount.accountId;

  Future<String> getMessagesInfo(
      {@required String folderName,
      String search,
      bool useThreading = true,
      String sortBy = "date"}) async {
    final parameters = json.encode({
      "Folder": folderName,
      "AccountID": _accountId,
      "Search": search,
      "UseThreading": useThreading,
      "SortBy": sortBy
    });

    final body = new ApiBody(
        module: "Mail", method: "GetMessagesInfo", parameters: parameters);

    final res = await sendRequest(body);

    if (res["Result"] is List) {
      return json.encode(res["Result"]);
    } else {
      throw WebMailApiError(res);
    }
  }

  Future<List> getMessageBodies(
      {@required String folderName, @required List<int> uids}) async {
    final parameters = json.encode({
      "Folder": folderName,
      "AccountID": _accountId,
      "Uids": uids,
    });

    final body = new ApiBody(
        module: "Mail", method: "GetMessagesBodies", parameters: parameters);

    final res = await sendRequest(body);

    if (res["Result"] is List) {
      return res["Result"] as List;
    } else {
      throw WebMailApiError(res);
    }
  }

  Future<void> sendMessage({
    @required String to,
    String cc = "",
    String bcc = "",
    String subject = "",
    @required List<ComposeAttachment> composeAttachments,
    @required String messageText,
    @required int draftUid,
    @required String sentFolderName,
    @required String draftsFolderName,
  }) async {
    final attachments = new Map();

    composeAttachments.forEach((ca) {
      attachments[ca.tempName] = [ca.fileName, "", "0", "0", ""];
    });

    final parameters = json.encode({
      "AccountID": _accountId,
      "FetcherID": "",
      "IdentityID": "",
      "DraftInfo": [],
      // pass in case it was saved in drafts
      "DraftUid": draftUid,
      "To": to,
      "Cc": cc,
      "Bcc": bcc,
      "Subject": subject,
      "Text": messageText,
      "IsHtml": false,
      "Importance": 3,
      "SendReadingConfirmation": false,
      "Attachments": attachments,
      "InReplyTo": "",
      "References": "",
      "Sensitivity": 0,
      "Method": "SendMessage",
      "ShowReport": false,
      // send for server to save in sent folder
      "SentFolder": sentFolderName,
      // send for server to delete the message from drafts
      "DraftFolder": draftsFolderName
    });

    final body = new ApiBody(
        module: "Mail", method: "SendMessage", parameters: parameters);

    final res = await sendRequest(body);

    if (res["Result"] != true) {
      throw WebMailApiError(res);
    }
  }

  Future<int> saveMessage({
    @required String to,
    String cc = "",
    String bcc = "",
    String subject = "",
    @required List<ComposeAttachment> composeAttachments,
    @required String messageText,
    @required int draftUid,
    @required String draftsFolderName,
  }) async {
    final attachments = new Map();

    composeAttachments.forEach((ca) {
      attachments[ca.tempName] = [ca.fileName, "", "0", "0", ""];
    });
    final parameters = json.encode({
      "AccountID": _accountId,
      "FetcherID": "",
      "IdentityID": "",
      "DraftInfo": [],
      "DraftUid": draftUid,
      "To": to,
      "Cc": cc,
      "Bcc": bcc,
      "Subject": subject,
      "Text": messageText,
      "IsHtml": false,
      "Importance": 3,
      "SendReadingConfirmation": false,
      "Attachments": attachments,
      "InReplyTo": "",
      "References": "",
      "Sensitivity": 0,
      "Method": "SaveMessage",
      "ShowReport": false,
      "DraftFolder": draftsFolderName,
    });

    final body = new ApiBody(
        module: "Mail", method: "SaveMessage", parameters: parameters);

    final res = await sendRequest(body);

    if (res["Result"] is Map) {
      return res["Result"]["NewUid"] as int;
    } else {
      throw WebMailApiError(res);
    }
  }

  Future<void> uploadAttachment(
    File file, {
    @required Function(TempAttachmentUpload) onUploadStart,
    @required Function(ComposeAttachment) onUploadEnd,
    @required Function(dynamic) onError,
  }) async {
    final uploader = FlutterUploader();

    final parameters = json.encode({"AccountID": _accountId});

    final body = new ApiBody(
        module: "Mail", method: "UploadAttachment", parameters: parameters);

    final fileName = FileUtils.getFileNameFromPath(file.path);

    final taskId = await uploader.enqueue(
      url: AuthBloc.apiUrl,
      files: [
        FileItem(
          filename: fileName,
          savedDir: file.parent.path,
          fieldname: "file",
        )
      ],
      method: UploadMethod.POST,
      headers: getHeaderWithToken(),
      data: body.toMap(),
      showNotification: true,
      tag: fileName,
    );

    final tempAttachment = new TempAttachmentUpload(
      name: fileName,
      size: file.lengthSync(),
      taskId: taskId,
      uploadProgress: uploader.progress,
      cancel: uploader.cancel,
    );
    onUploadStart(tempAttachment);

    uploader.result.listen((result) {
      final res = json.decode(result.response);
      if (res["Result"] is Map) {
        final attachment = res["Result"]["Attachment"];
        final composeAttachment = ComposeAttachment.fromJsonString(attachment as Map);
        assert(tempAttachment != null && tempAttachment.guid is String);
        composeAttachment.guid = tempAttachment.guid;
        onUploadEnd(composeAttachment);
      } else {
        onError(WebMailApiError(res));
      }
    }, onError: (err) {
      print("Attachment upload error: $err");
    });
  }

  Future<void> downloadAttachment(
    MailAttachment attachment, {
    @required Function() onDownloadStart,
    @required Function(String) onDownloadEnd,
  }) async {
    try {
      await FlutterDownloader.initialize();
    } catch (err) {}
    final downloadsDirectories = await getExternalStorageDirectories(type: StorageDirectory.downloads);
    final downloadsDirectory = downloadsDirectories[0];


    final taskId = await FlutterDownloader.enqueue(
      url: AuthBloc.hostName + attachment.downloadUrl,
      savedDir: downloadsDirectory.path,
      fileName: attachment.fileName,
      headers: getHeaderWithToken(),
    );

    await attachment.startDownload(
      taskId: taskId,
      cancel: FlutterDownloader.cancel,
      onDownloadStart: () async {
        onDownloadStart();
        // TODO repair progress updating
//        FlutterDownloader.registerCallback(MailAttachment.downloadCallback);
      },
      onDownloadEnd: () =>
          onDownloadEnd("${downloadsDirectory.path}/${attachment.fileName}"),
      onError: () => onDownloadEnd(null),
    );
  }

  Future<List<ComposeAttachment>> saveAttachmentsAsTempFiles(
      List<MailAttachment> attachments) async {
    final hashes = attachments.map((a) => a.hash).toList();
    final parameters = json.encode({
      "Attachments": hashes,
      "AccountID": _accountId,
    });

    final body = new ApiBody(
        module: "Mail",
        method: "SaveAttachmentsAsTempFiles",
        parameters: parameters);

    final res = await sendRequest(body);

    if (res["Result"] is Map) {
      return ComposeAttachment.fromMailAttachment(attachments, res["Result"] as Map);
    } else {
      throw WebMailApiError(res);
    }
  }

  Future<void> deleteMessages({
    @required Folder folder,
    @required List<int> uids,
  }) async {
    final parameters = json.encode({
      "Folder": folder.fullNameRaw,
      "AccountID": _accountId,
      "Uids": uids.join(","),
    });

    final body = new ApiBody(
        module: "Mail", method: "DeleteMessages", parameters: parameters);

    final res = await sendRequest(body);

    if (res["Result"] != true) {
      throw WebMailApiError(res);
    }
  }

  Future<void> setMessagesSeen({
    @required Folder folder,
    @required List<int> uids,
  }) async {
    final parameters = json.encode({
      "Folder": folder.fullNameRaw,
      "AccountID": _accountId,
      "Uids": uids.join(","),
      "SetAction": true,
    });

    final body = new ApiBody(
        module: "Mail", method: "SetMessagesSeen", parameters: parameters);

    final res = await sendRequest(body);

    if (res["Result"] != true) {
      throw WebMailApiError(res);
    }
  }

  Future<void> setMessagesFlagged({
    @required Folder folder,
    @required List<int> uids,
    @required bool isStarred,
  }) async {
    final parameters = json.encode({
      "Folder": folder.fullNameRaw,
      "AccountID": _accountId,
      "Uids": uids.join(","),
      "SetAction": isStarred,
    });

    final body = new ApiBody(
        module: "Mail", method: "SetMessageFlagged", parameters: parameters);

    final res = await sendRequest(body);

    if (res["Result"] != true) {
      throw WebMailApiError(res);
    }
  }
}
