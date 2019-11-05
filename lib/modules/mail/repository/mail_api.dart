import 'dart:convert';

import 'package:aurora_mail/models/api_body.dart';
import 'package:aurora_mail/modules/app_store.dart';
import 'package:aurora_mail/utils/api_utils.dart';
import 'package:aurora_mail/utils/error_handling.dart';
import 'package:flutter/widgets.dart';

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
    @required String messageText,
    @required int draftUid,
    @required String sentFolderName,
    @required String draftsFolderName,
  }) async {
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
      // TODO
      "Attachments": null,
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
    @required String messageText,
    @required int draftUid,
    @required String draftsFolderName,
  }) async {
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
      "Attachments": null, // TODO
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
}
