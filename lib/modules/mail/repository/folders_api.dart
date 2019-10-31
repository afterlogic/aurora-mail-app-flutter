import 'dart:convert';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/models/api_body.dart';
import 'package:aurora_mail/modules/app_store.dart';
import 'package:aurora_mail/utils/api_utils.dart';
import 'package:aurora_mail/utils/server_error.dart';

class FoldersApi {
  int get _accountId => AppStore.authState.accountId;

  Future<List<Map<String, dynamic>>> getFolders() async {
    final parameters = json.encode({"AccountID": _accountId});

    final body = new ApiBody(
        module: "Mail", method: "GetFolders", parameters: parameters);

    final res = await sendRequest(body);

    if (res["Result"] is Map) {
      return new List<Map<String, dynamic>>.from(
          res["Result"]["Folders"]["@Collection"]);
    } else {
      throw ServerError(getErrMsg(res));
    }
  }

  Future<Map> getRelevantFoldersInformation(List<LocalFolder> folders) async {
    final List<String> folderNames = folders.map((f) => f.fullNameRaw).toList();
    final parameters =
        json.encode({"AccountID": _accountId, "Folders": folderNames});

    final body = new ApiBody(
        module: "Mail",
        method: "GetRelevantFoldersInformation",
        parameters: parameters);

    final res = await sendRequest(body);

    if (res["Result"] is Map) {
      return res["Result"]["Counts"];
    } else {
      throw ServerError(getErrMsg(res));
    }
  }
}
