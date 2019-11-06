import 'dart:convert';
import 'dart:io';

import 'package:aurora_mail/models/api_body.dart';
import 'package:aurora_mail/modules/app_store.dart';
import 'package:aurora_mail/modules/mail/models/compose_attachment.dart';
import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:aurora_mail/modules/mail/models/temp_attachment_upload.dart';
import 'package:aurora_mail/utils/api_utils.dart';
import 'package:aurora_mail/utils/error_handling.dart';
import 'package:aurora_mail/utils/file_utils.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_uploader/flutter_uploader.dart';

class MailApi {
  int get _accountId => AppStore.authState.accountId;

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
      throw ServerError(getErrMsg(res));
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
      return res["Result"];
    } else {
      throw ServerError(getErrMsg(res));
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
      throw ServerError(getErrMsg(res));
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

    print("VO: res[Result]: ${res}");
    if (res["Result"] is Map) {
      return res["Result"]["NewUid"];
    } else {
      throw ServerError(getErrMsg(res));
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
    final authState = AppStore.authState;

    final fileName = FileUtils.getFileNameFromPath(file.path);

    final taskId = await uploader.enqueue(
      url: authState.apiUrl,
      files: [
        FileItem(
          filename: fileName,
          savedDir: file.parent.path,
          fieldname: "file",
        )
      ],
      method: UploadMethod.POST,
      headers: getHeader(),
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
        final composeAttachment = ComposeAttachment.fromJsonString(attachment);
        assert(tempAttachment != null && tempAttachment.guid is String);
        composeAttachment.guid = tempAttachment.guid;
        onUploadEnd(composeAttachment);
      } else {
        onError(ServerError(getErrMsg(res)));
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
    final authState = AppStore.authState;
    try {
      await FlutterDownloader.initialize();
    } catch (err) {}
    final downloadsDirectory = await DownloadsPathProvider.downloadsDirectory;

    final taskId = await FlutterDownloader.enqueue(
      url: authState.hostName + attachment.downloadUrl,
      savedDir: downloadsDirectory.path,
      fileName: attachment.fileName,
      headers: getHeader(),
    );

    await attachment.startDownload(
      taskId: taskId,
      cancel: FlutterDownloader.cancel,
      onDownloadStart: () async {
        onDownloadStart();
        // TODO VO: repair progress updating
//        FlutterDownloader.registerCallback(MailAttachment.downloadCallback);
      },
      onDownloadEnd: () =>
          onDownloadEnd("${downloadsDirectory.path}/${attachment.fileName}"),
      onError: () => onDownloadEnd(null),
    );
  }
}
