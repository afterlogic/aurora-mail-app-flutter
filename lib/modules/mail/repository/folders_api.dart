import 'dart:convert';

import 'package:aurora_mail/database/app_database.dart';
import 'package:flutter/foundation.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

class FoldersApi {
  final Account account;
  final User user;

  int get _accountId => account.accountId;

  WebMailApi _mailModule;

  FoldersApi({
    @required this.account,
    @required this.user,
  }) {
    _mailModule = WebMailApi(
      moduleName: WebMailModules.mail,
      hostname: user.hostname,
      token: user.token,
    );
  }

  Future<List<Map<String, dynamic>>> getFolders() async {
    final parameters = json.encode({"AccountID": _accountId});

    final body = new WebMailApiBody(method: "GetFolders", parameters: parameters);

    final res = await _mailModule.post(body);

    if (res is Map) {
      return new List<Map<String, dynamic>>.from(res["Folders"]["@Collection"] as List);
    } else {
      throw WebMailApiError(res);
    }
  }

  Future<Map> getRelevantFoldersInformation(List<LocalFolder> folders) async {
    final List<String> folderNames = folders.map((f) => f.fullNameRaw).toList();
    final parameters =
        json.encode({"AccountID": _accountId, "Folders": folderNames});

    final body = new WebMailApiBody(method: "GetRelevantFoldersInformation", parameters: parameters);

    final res = await _mailModule.post(body);

    if (res["Counts"] is Map) {
      return res["Counts"] as Map;
    } else {
      throw WebMailApiError(res);
    }
  }
}
