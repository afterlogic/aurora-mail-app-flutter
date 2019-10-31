import 'dart:convert';

import 'package:aurora_mail/models/api_body.dart';
import 'package:aurora_mail/modules/app_store.dart';
import 'package:aurora_mail/utils/api_utils.dart';
import 'package:aurora_mail/utils/server_error.dart';
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
      {@required String folderName,
      @required List<int> uids}) async {
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
}
