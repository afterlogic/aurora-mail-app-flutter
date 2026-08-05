
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/mail/models/compose_attachment.dart';
import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:aurora_mail/modules/mail/models/temp_attachment_upload.dart';
import 'package:aurora_mail/utils/file_utils.dart';
import 'package:background_downloader/background_downloader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import 'package:share_plus/share_plus.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

class MailApi {
  final Account? account;

  late WebMailApi _mailModule;

  MailApi(
      {required User user,
      required this.account,
      required ApiInterceptor interceptor}) {
    _mailModule = WebMailApi(
      moduleName: WebMailModules.mail,
      hostname: user.hostname,
      token: user.token,
      interceptor: interceptor,
    );
  }

  int get _accountId => account!.accountId;

  Future<bool> changeEventInviteStatus(
      {required String status,
      required String calendarId,
      required String fileName}) async {
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
      "Attendee": account!.email
    });

    final body = new WebMailApiBody(
        method: "SetAppointmentAction", parameters: parameters);

    await module.post(body);
    return true;
  }

  Future<String> getMessagesInfo(
      {required String folderName,
      String? search,
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
      {required String folderName, required List<int> uids}) async {
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
    required String folderFullName,
    required String subject,
    required String? text,
    String? uid,
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
    required String to,
    String cc = "",
    String bcc = "",
    String subject = "",
    required bool isHtml,
    required List<ComposeAttachment> composeAttachments,
    required String? messageText,
    required int? draftUid,
    required String? sentFolderName,
    required String? draftsFolderName,
    AccountIdentity? identity,
    Aliases? alias,
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

  Future<int?> saveMessage({
    required String to,
    String cc = "",
    String bcc = "",
    String subject = "",
    required List<ComposeAttachment> composeAttachments,
    required String? messageText,
    required int? draftUid,
    required String? draftsFolderName,
    bool? isHtml,
    AccountIdentity? identity,
    Aliases? alias,
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
      return res["NewUid"] as int?;
    } else {
      throw WebMailApiError(res);
    }
  }

  Future<void> uploadAttachment(
    File file, {
    required Function(TempAttachmentUpload) onUploadStart,
    required Function(ComposeAttachment) onUploadEnd,
    required Function(dynamic) onError,
  }) async {
    final parameters = json.encode({"AccountID": _accountId});
    final body =
        new WebMailApiBody(method: "UploadAttachment", parameters: parameters);
    final fileName = FileUtils.getFileNameFromPath(file.path);
    final headers = await _mailModule.getAuthHeaders();
    final taskId = Uuid().v4();

    final client = http.Client();
    final progressController = StreamController<UploadProgress>.broadcast();
    var cancelled = false;

    final tempAttachment = new TempAttachmentUpload(
      file,
      name: fileName,
      size: file.lengthSync(),
      taskId: taskId,
      uploadProgress: progressController.stream,
      cancel: ({String? taskId}) {
        cancelled = true;
        client.close();
      },
    );
    onUploadStart(tempAttachment);

    // Deliberately not awaited: like the old flutter_uploader (which just
    // enqueued a native background task and returned immediately), the
    // caller (ComposeBloc._addAttachment) awaits this method between
    // picking each file. If we awaited the network request here, the
    // StartUpload event this triggers via onUploadStart would sit stuck in
    // the bloc's event queue until the whole upload finished, so nothing
    // would show up on screen until then.
    _doUpload(
      file: file,
      headers: headers,
      fields: body.toMap("Mail"),
      tempAttachment: tempAttachment,
      client: client,
      isCancelled: () => cancelled,
      onUploadEnd: onUploadEnd,
      onError: onError,
    ).whenComplete(() {
      progressController.close();
      client.close();
    });
  }

  Future<void> _doUpload({
    required File file,
    required Map<String, String>? headers,
    required Map<String, String> fields,
    required TempAttachmentUpload tempAttachment,
    required http.Client client,
    required bool Function() isCancelled,
    required Function(ComposeAttachment) onUploadEnd,
    required Function(dynamic) onError,
  }) async {
    const maxAttempts = 3;
    // the plain http.Client() used here has no timeout of its own (unlike
    // _mailModule's client, which has a 15s connectionTimeout), so a stalled
    // connection would otherwise hang indefinitely instead of failing fast
    // and retrying
    const perAttemptTimeout = Duration(seconds: 45);

    for (var attempt = 1; attempt <= maxAttempts; attempt++) {
      print("Attachment upload: attempt $attempt/$maxAttempts starting");
      try {
        // a fresh MultipartRequest/MultipartFile is required on every
        // attempt: both are single-use, locked as soon as they're sent once
        final request =
            http.MultipartRequest("POST", Uri.parse(_mailModule.apiUrl));
        request.headers.addAll(headers!);
        request.fields.addAll(fields);
        // matches the field names the server's own web client sends
        // (confirmed from a working browser upload's request payload)
        request.fields["jua-post-type"] = "ajax";
        request.files.add(
            await http.MultipartFile.fromPath("jua-uploader", file.path));

        final streamedResponse =
            await client.send(request).timeout(perAttemptTimeout);
        final responseBody = await streamedResponse.stream
            .bytesToString()
            .timeout(perAttemptTimeout);
        print("Attachment upload: attempt $attempt got response "
            "status=${streamedResponse.statusCode} body=$responseBody");
        final res = json.decode(responseBody);

        if (res is Map &&
            res["Result"] is Map &&
            res["Result"]["Attachment"] is Map) {
          final attachment = res["Result"]["Attachment"];
          final composeAttachment =
              ComposeAttachment.fromNetwork(attachment as Map);
          composeAttachment.guid = tempAttachment.guid;
          composeAttachment.file = tempAttachment.file;
          onUploadEnd(composeAttachment);
        } else {
          print("Attachment upload: unexpected response shape, res=$res");
          onError(WebMailApiError(res));
        }
        return;
      } catch (err) {
        // matches flutter_uploader's cancellation behaviour: no error callback
        if (isCancelled()) return;

        // Some Android devices reset long-lived plain dart:io sockets
        // mid-upload (e.g. on WiFi/mobile handover), surfacing as
        // "ClientException: Software caused connection abort", or the
        // connection just stalls (TimeoutException, from perAttemptTimeout
        // above). The old flutter_uploader never hit this since it used the
        // platform's native (OkHttp) HTTP stack, which handles such
        // handovers/stalls itself. A short retry covers the same case here.
        final isTransientNetworkError = err is http.ClientException ||
            err is SocketException ||
            err is TimeoutException;
        print("Attachment upload: attempt $attempt failed: "
            "${err.runtimeType}: $err");
        if (!isTransientNetworkError || attempt == maxAttempts) {
          onError(WebMailApiError(err));
          print("Attachment upload error: $err");
          return;
        }
        await Future.delayed(Duration(seconds: attempt));
      }
    }
  }

  Future<void> downloadAttachment(
    MailAttachment attachment, {
    required Function() onDownloadStart,
    required Function(String?)? onDownloadEnd,
  }) async {
    final headers = await _mailModule.getAuthHeaders();

    await attachment.startDownload(
      onDownloadStart: () async {
        onDownloadStart();
      },
      onDownloadEnd: (path) => onDownloadEnd!(path),
      onError: () => onDownloadEnd!(null),
    );

    // background_downloader (this version) can only save into one of its own
    // fixed base directories, so download to a private staging location and
    // let DownloadTaskProgress move it to the public Downloads folder once
    // complete.
    final task = DownloadTask(
      url: _mailModule.hostname + '/' + attachment.downloadUrl!,
      filename: attachment.fileName,
      baseDirectory: BaseDirectory.temporary,
      headers: headers,
      updates: Updates.statusAndProgress,
    );
    await FileDownloader().enqueue(task);
    attachment.add(
      task,
      ({required String taskId}) => FileDownloader().cancelTaskWithId(taskId),
    );
  }

  Future<void> shareAttachment(MailAttachment attachment,
      Function(String)? onIosDownloadEnd, Rect? rect) async {
    final request = await HttpClient()
        .getUrl(Uri.parse(_mailModule.hostname + attachment.downloadUrl!));
    final headers = await _mailModule.getAuthHeaders();

    headers.forEach((key, value) {
      request.headers.add(key, value);
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
      await Share.shareXFiles([XFile(file.path)],
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
    required String folderRawName,
    required String trashRawName,
    required List<int> uids,
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
    required String folderRawName,
    required List<int> uids,
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
      {required Folder folder, required List<int> uids, bool? isSeen}) async {
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
    required Folder folder,
    required List<int> uids,
    required bool isStarred,
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
    required String senderEmail,
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
      {required List<int> uids, String? fromFolder, String? toFolder}) async {
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
        "AccountID": account!.accountId
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

  Future<Map<String, dynamic>?> getMessageById(
    String messageId,
    String folder,
    int lastUid,
  ) async {
    final parameters = json.encode(
      {
        "Folder": folder,
        "MessageID": messageId,
        "UidFrom": lastUid,
        "AccountID": account!.accountId
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
