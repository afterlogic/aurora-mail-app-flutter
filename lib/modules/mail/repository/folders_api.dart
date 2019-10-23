import 'dart:convert';

import 'package:aurora_mail/models/api_body.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/utils/api_utils.dart';
import 'package:aurora_mail/utils/custom_exception.dart';

class FoldersApi {
  Future<List<Map<String, dynamic>>> getFolders(int accountId) async {
    final parameters = json.encode({"AccountID": accountId});

    final body = new ApiBody(
        module: "Mail", method: "GetFolders", parameters: parameters);

    final res = await sendRequest(body);

    if (res["Result"] is Map) {
      return new List<Map<String, dynamic>>.from(
          res["Result"]["Folders"]["@Collection"]);
    } else {
      throw CustomException(getErrMsg(res));
    }
  }

  Future<Map> getRelevantFoldersInformation(
      int accountId, List<Folder> folders) async {

    final List<String> folderNames = folders.map((f) => f.fullNameRaw).toList();
    final parameters =
        json.encode({"AccountID": accountId, "Folders": folderNames});

    final body = new ApiBody(
        module: "Mail",
        method: "GetRelevantFoldersInformation",
        parameters: parameters);

    final res = await sendRequest(body);

    if (res["Result"] is Map) {
      return res["Result"]["Counts"];
    } else {
      throw CustomException(getErrMsg(res));
    }
  }
}
