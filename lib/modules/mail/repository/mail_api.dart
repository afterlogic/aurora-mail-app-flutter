//@dart=2.9
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/mail/models/compose_attachment.dart';
import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:aurora_mail/modules/mail/models/temp_attachment_upload.dart';
import 'package:aurora_mail/utils/download_directory.dart';
import 'package:aurora_mail/utils/file_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:share/share.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

class MailApi {
  final Account account;

  WebMailApi _mailModule;

  MailApi(
      {@required User user,
      @required this.account,
      ApiInterceptor interceptor}) {
    _mailModule = WebMailApi(
      moduleName: WebMailModules.mail,
      hostname: user.hostname,
      token: user.token,
      interceptor: interceptor,
    );
  }

  int get _accountId => account.accountId;

  Future<bool> changeEventInviteStatus(
      {@required String status,
      @required String calendarId,
      @required String fileName}) async {
    final module = WebMailApi(
      moduleName: WebMailModules.calendarMeetingsPlugin,
      hostname: _mailModule.hostname,
      token: _mailModule.token,
      interceptor: _mailModule.interceptor,
    );

    final parameters = json.encode({
      "AppointmentAction": status,
      "CalendarId": calendarId,
      "File": fileName,
      "Attendee": account.email
    });

    final body = new WebMailApiBody(
        method: "SetAppointmentAction", parameters: parameters);

    final res = await module.post(body);
    return true;
  }

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

    final body =
        new WebMailApiBody(method: "GetMessagesInfo", parameters: parameters);

    final res = await _mailModule.post(body);

    if (res is List) {
      return json.encode(res);
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

    final body =
        new WebMailApiBody(method: "GetMessagesBodies", parameters: parameters);

    final res = await _mailModule.post(body);

    if (res is List) {
      return res;
    } else {
      throw WebMailApiError(res);
    }
  }


  Future<void> sendNote({
    @required String folderFullName,
    @required String subject,
    @required String text,
    String uid,
  }) async {
    final parameters = {
      "AccountID": _accountId,
      "FolderFullName": folderFullName,
      "Subject": subject,
      // with html tags
      "Text": text,
    };

    if(uid != null){
      parameters.addAll({"MessageUid":uid});
    }

    final body = new WebMailApiBody(
        method: "SaveNote",
        module: WebMailModules.notes,
        parameters: json.encode(parameters));

    await _mailModule.post(body);
  }

  Future<void> sendMessage({
    @required String to,
    String cc = "",
    String bcc = "",
    String subject = "",
    @required bool isHtml,
    @required List<ComposeAttachment> composeAttachments,
    @required String messageText,
    @required int draftUid,
    @required String sentFolderName,
    @required String draftsFolderName,
    AccountIdentity identity,
    Aliases alias,
  }) async {
    final attachments = new Map();

    composeAttachments.forEach((ca) {
      attachments[ca.tempName] = [ca.fileName, "", "0", "0", ""];
    });

    final parameters = json.encode({
      "AccountID": _accountId,
      "IdentityID": identity?.entityId ?? "",
      "AliasID": alias?.entityId ?? "",
      "FetcherID": "",
      "DraftInfo": [],
      // pass in case it was saved in drafts
      "DraftUid": draftUid,
      "To": to,
      "Cc": cc,
      "Bcc": bcc,
      "Subject": subject,
      "Text": messageText,
      "IsHtml": isHtml,
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

    final body =
        new WebMailApiBody(method: "SendMessage", parameters: parameters);

    final res = await _mailModule.post(body);

    if (res != true) {
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
    bool isHtml,
    AccountIdentity identity,
    Aliases alias,
  }) async {
    final attachments = new Map();

    composeAttachments.forEach((ca) {
      attachments[ca.tempName] = [ca.fileName, "", "0", "0", ""];
    });
    final parameters = json.encode({
      "AccountID": _accountId,
      "IdentityID": identity?.entityId ?? "",
      "AliasID": alias?.entityId ?? "",
      "FetcherID": "",
      "DraftInfo": [],
      "DraftUid": draftUid,
      "To": to,
      "Cc": cc,
      "Bcc": bcc,
      "Subject": subject,
      "Text": messageText,
      "IsHtml": isHtml,
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

    final body =
        new WebMailApiBody(method: "SaveMessage", parameters: parameters);

    final res = await _mailModule.post(body);

    if (res is Map) {
      return res["NewUid"] as int;
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
    var _onUploadEnd = onUploadEnd;
    final uploader = FlutterUploader();
    final parameters = json.encode({"AccountID": _accountId});
    final body =
        new WebMailApiBody(method: "UploadAttachment", parameters: parameters);
    final fileName = FileUtils.getFileNameFromPath(file.path);
    final headers = await _mailModule.getAuthHeaders();

    final taskId = await uploader.enqueue(MultipartFormDataUpload(
      url: _mailModule.apiUrl,
      files: [
        FileItem(
          path: file.path,
          field: "file",
        )
      ],
      method: UploadMethod.POST,
      headers: headers as Map<String, String>,
      data: body.toMap("Mail"),
      tag: fileName,
    ));

    final tempAttachment = new TempAttachmentUpload(
      file,
      name: fileName,
      size: file.lengthSync(),
      taskId: taskId,
      uploadProgress: uploader.progress,
      cancel: uploader.cancel,
    );
    onUploadStart(tempAttachment);
    uploader.result.listen((result) {
      if (result.taskId == tempAttachment.taskId) {
        final res = json.decode(result.response);
        if (res is Map &&
            res["Result"] is Map &&
            res["Result"]["Attachment"] is Map) {
          final attachment = res["Result"]["Attachment"];
          final composeAttachment =
              ComposeAttachment.fromNetwork(attachment as Map);
          assert(tempAttachment != null && tempAttachment.guid is String);
          composeAttachment.guid = tempAttachment.guid;
          composeAttachment.file = tempAttachment.file;
          _onUploadEnd(composeAttachment);
          _onUploadEnd = null;
        } else {
          onError(WebMailApiError(res));
        }
      }
    }, onError: (err) {
      if (err?.status == UploadTaskStatus.canceled ||
          err?.code == "flutter_upload_cancelled") {
        return;
      }
      onError(WebMailApiError(err));
      print("Attachment upload error: $err");
    });
  }

  Future<void> downloadAttachment(
    MailAttachment attachment, {
    @required Function() onDownloadStart,
    @required Function(String) onDownloadEnd,
  }) async {
    final downloadsDirectory = await getDownloadDirectory();
    final headers = await _mailModule.getAuthHeaders();

    await attachment.startDownload(
      onDownloadStart: () async {
        onDownloadStart();
        // TODO repair progress updating
//        FlutterDownloader.registerCallback(MailAttachment.downloadCallback);
      },
      onDownloadEnd: () =>
          onDownloadEnd("${downloadsDirectory}/${attachment.fileName}"),
      onError: () => onDownloadEnd(null),
    );

    print(_mailModule.hostname + '/' + attachment.downloadUrl);
    print(downloadsDirectory);
    print(attachment.fileName);
    print(headers);
    final _fileNameRegex = RegExp(r'(.+?)(?:\.[^.]*$|$)');
    final _fileName = _fileNameRegex.firstMatch(attachment.fileName).group(1);

    final taskId = await FlutterDownloader.enqueue(
      url: _mailModule.hostname + '/' + attachment.downloadUrl,
      savedDir: downloadsDirectory,
      fileName: _fileName,
      saveInPublicStorage: true,
      headers: headers as Map<String, String>,
    );
    attachment.add(taskId, FlutterDownloader.cancel);
  }

  Future<void> shareAttachment(MailAttachment attachment,
      Function(String) onIosDownloadEnd, Rect rect) async {
    final request = await HttpClient()
        .getUrl(Uri.parse(_mailModule.hostname + attachment.downloadUrl));
    final headers = await _mailModule.getAuthHeaders();

    headers.forEach((key, value) {
      request.headers.add(key as String, value);
    });

    final response = await request.close();
    Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    if (onIosDownloadEnd != null) {
      onIosDownloadEnd(utf8.decode(bytes));
    } else {
      final name = attachment.fileName;
      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/$name').create();
      await file.writeAsBytes(bytes);
      await Share.shareFiles([file.path],
          subject: attachment.fileName, sharePositionOrigin: rect);
    }
  }

  Future<List<ComposeAttachment>> saveAttachmentsAsTempFiles(
      List<MailAttachment> attachments) async {
    final hashes = attachments.map((a) => a.hash).toList();
    final parameters = json.encode({
      "Attachments": hashes,
      "AccountID": _accountId,
    });

    final body = new WebMailApiBody(
        module: "Mail",
        method: "SaveAttachmentsAsTempFiles",
        parameters: parameters);

    final res = await _mailModule.post(body);

    if (res is Map) {
      return ComposeAttachment.fromMailAttachment(attachments, res);
    } else {
      throw WebMailApiError(res);
    }
  }

  Future<ComposeAttachment> saveContactAsTempFile(Contact contact) async {
    final parameters = json.encode({
      "UUID": contact.uuid,
      "FileName": "contact-${contact.viewEmail}.vcf",
    });

    final body = new WebMailApiBody(
        module: "Contacts",
        method: "SaveContactAsTempFile",
        parameters: parameters);

    final res = await _mailModule.post(body);

    if (res is Map) {
      return ComposeAttachment.fromNetwork(res);
    } else {
      throw WebMailApiError(res);
    }
  }

  Future<void> moveToTrash({
    @required String folderRawName,
    @required String trashRawName,
    @required List<int> uids,
  }) async {
    final parameters = json.encode({
      "Folder": folderRawName,
      "ToFolder": trashRawName,
      "AccountID": _accountId,
      "Uids": uids.join(","),
    });

    final body =
        new WebMailApiBody(method: "MoveMessages", parameters: parameters);

    final res = await _mailModule.post(body);

    if (res != true) {
      throw WebMailApiError(res);
    }
  }

  Future<void> deleteMessages({
    @required String folderRawName,
    @required List<int> uids,
  }) async {
    final parameters = json.encode({
      "Folder": folderRawName,
      "AccountID": _accountId,
      "Uids": uids.join(","),
    });

    final body =
        new WebMailApiBody(method: "DeleteMessages", parameters: parameters);

    final res = await _mailModule.post(body);

    if (res != true) {
      throw WebMailApiError(res);
    }
  }

  Future<void> setMessagesSeen(
      {@required Folder folder, @required List<int> uids, bool isSeen}) async {
    final parameters = json.encode({
      "Folder": folder.fullNameRaw,
      "AccountID": _accountId,
      "Uids": uids.join(","),
      "SetAction": isSeen,
    });

    final body =
        new WebMailApiBody(method: "SetMessagesSeen", parameters: parameters);

    final res = await _mailModule.post(body);

    if (res != true) {
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

    final body =
        new WebMailApiBody(method: "SetMessageFlagged", parameters: parameters);

    final res = await _mailModule.post(body);

    if (res != true) {
      throw WebMailApiError(res);
    }
  }

  Future<void> setEmailSafety({
    @required String senderEmail,
  }) async {
    final parameters = json.encode({
      "AccountID": _accountId,
      "Email": senderEmail,
    });

    final body =
        new WebMailApiBody(method: "SetEmailSafety", parameters: parameters);

    final res = await _mailModule.post(body);

    if (res != true) {
      throw WebMailApiError(res);
    }
  }

  Future moveMessage(
      {List<int> uids, String fromFolder, String toFolder}) async {
    final parameters = json.encode({
      "Folder": fromFolder,
      "ToFolder": toFolder,
      "AccountID": _accountId,
      "Uids": uids.join(","),
    });

    final body =
        new WebMailApiBody(method: "MoveMessages", parameters: parameters);

    final res = await _mailModule.post(body);

    if (res != true) {
      throw WebMailApiError(res);
    }
  }

  Future clearFolder(String folder) async {
    final parameters = json.encode({
      "Folder": folder,
      "AccountID": _accountId,
    });

    final body =
        new WebMailApiBody(method: "ClearFolder", parameters: parameters);

    final res = await _mailModule.post(body);

    if (res != true) {
      throw WebMailApiError(res);
    }
  }

  Future<ComposeAttachment> uploadEmlAttachments(Message message) async {
    final parameters = json.encode(
      {
        "MessageFolder": message.folder,
        "MessageUid": message.uid,
        "FileName": "${message.subject}.eml",
        "AccountID": account.accountId
      },
    );

    final body = new WebMailApiBody(
        method: "SaveMessageAsTempFile", parameters: parameters);

    final res = await _mailModule.post(body);

    if (res is Map) {
      return ComposeAttachment.fromNetwork(res);
    } else {
      throw WebMailApiError(res);
    }
  }

  Future<Map<String, dynamic>> getMessageById(
    String messageId,
    String folder,
    int lastUid,
  ) async {
    final parameters = json.encode(
      {
        "Folder": folder,
        "MessageID": messageId,
        "UidFrom": lastUid,
        "AccountID": account.accountId
      },
    );

    final body = new WebMailApiBody(
        method: "GetMessageByMessageID", parameters: parameters);

    var res = await _mailModule.post(body, getRawResponse: true);
    res = res["Result"];
    if (res is Map<String, dynamic>) {
      return res;
    } else {
      if (res is bool) {
        return null;
      }
      throw WebMailApiError(res);
    }
  }
}
