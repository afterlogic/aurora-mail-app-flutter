import 'dart:convert';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/models/api_body.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/utils/api_utils.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

class FoldersApi {
  int get _accountId => AuthBloc.currentAccount.accountId;

  Future<List<Map<String, dynamic>>> getFolders() async {
    final parameters = json.encode({"AccountID": _accountId});

    final body = new ApiBody(
        module: "Mail", method: "GetFolders", parameters: parameters);

    final res = await sendRequest(body);

    if (res["Result"] is Map) {
      return new List<Map<String, dynamic>>.from(res["Result"]["Folders"]["@Collection"] as List);
    } else {
      throw WebMailApiError(res);
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
      return res["Result"]["Counts"] as Map;
    } else {
      throw WebMailApiError(res);
    }
  }
}
