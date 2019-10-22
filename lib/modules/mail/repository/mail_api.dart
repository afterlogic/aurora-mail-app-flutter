import 'dart:convert';

import 'package:aurora_mail/models/api_body.dart';
import 'package:aurora_mail/utils/api_utils.dart';
import 'package:aurora_mail/utils/custom_exception.dart';
import 'package:flutter/widgets.dart';

class MailApi {
  Future<String> getMessagesInfo(
      {@required String folderName,
      @required int accountId,
      String search,
      bool useThreading = true,
      String sortBy = "date"}) async {
    final parameters = json.encode({
      "Folder": folderName,
      "AccountID": accountId,
      "Search": search,
      "UseThreading": useThreading,
      "SortBy": sortBy
    });

    final body = new ApiBody(
        module: "Mail", method: "GetMessagesInfo", parameters: parameters);

    final res = await sendRequest(body);

    if (res["Result"] is Map) {
      return json.encode(res["Result"]);
    } else {
      throw CustomException(getErrMsg(res));
    }
  }
}
