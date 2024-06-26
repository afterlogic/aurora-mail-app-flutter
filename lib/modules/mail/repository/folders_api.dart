//@dart=2.9
import 'dart:convert';

import 'package:aurora_mail/database/app_database.dart';
import 'package:flutter/foundation.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

class FoldersApi {
  final Account account;
  final User user;

  int get _accountId => account.entityId;

  WebMailApi _mailModule;

  FoldersApi({
    @required this.account,
    @required this.user,
    ApiInterceptor interceptor,
  }) {
    _mailModule = WebMailApi(
      moduleName: WebMailModules.mail,
      hostname: user.hostname,
      token: user.token,
      interceptor: interceptor,
    );
  }

  Future<Map<String, dynamic>> getFolders() async {
    final parameters = json.encode({"AccountID": _accountId});

    final body =
        new WebMailApiBody(method: "GetFolders", parameters: parameters);

    final res = await _mailModule.post(body);

    if (res is Map) {
      return res as Map<String, dynamic>;
    } else {
      throw WebMailApiError(res);
    }
  }

  Future<Map> getRelevantFoldersInformation(List<String> fullNamesRaw) async {
    final parameters =
        json.encode({"AccountID": _accountId, "Folders": fullNamesRaw});

    final body = new WebMailApiBody(
        method: "GetRelevantFoldersInformation", parameters: parameters);

    final res = await _mailModule.post(body);

    if (res["Counts"] is Map) {
      return res["Counts"] as Map;
    } else {
      throw WebMailApiError(res);
    }
  }
}
