import 'dart:convert';

import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/database/accounts/accounts_table.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:http/http.dart' as http;
import 'package:webmail_api_client/webmail_api_client.dart';

class AuthApi {
  Future<String> autoDiscoverHostname(String email) async {
    try {
      final url = "$AUTO_DISCOVER_URL?email=$email";
      final res = await http.get(url);
      final resBody = json.decode(res.body);
      return resBody["url"] as String;
    } catch (err) {
      return null;
    }
  }

  Future<User> login(String email, String password, String hostname) async {
    final coreModuleForLogin = WebMailApi(moduleName: WebMailModules.core, hostname: hostname);

    final parameters = json.encode({"Login": email, "Password": password, "Pattern": ""});

    final body = new WebMailApiBody(method: "Login", parameters: parameters);

    final response = await coreModuleForLogin.post(body, getRawResponse: true);

    if (response['Result'] != null && response['Result']['AuthToken'] is String) {
      final token = response['Result']['AuthToken'] as String;
      final id = response['AuthenticatedUserId'] as int;

      return new User(
        localId: null,
        serverId: id,
        token: token,
        hostname: hostname,
        emailFromLogin: email,
      );
    } else {
      throw WebMailApiError(response);
    }
  }

  Future<void> logout(User user) async {
    final coreModuleForLogin = WebMailApi(
      moduleName: WebMailModules.core,
      hostname: user.hostname,
      token: user.token,
    );

    final body = new WebMailApiBody(module: "Core", method: "Logout");

    final res = await coreModuleForLogin.post(body);

    if (res != true) {
      throw WebMailApiError(res);
    }
  }

  Future<List<Account>> getAccounts(User user) async {
    final coreModuleForLogin = WebMailApi(
      moduleName: WebMailModules.mail,
      hostname: user.hostname,
      token: user.token,
    );

    final parameters = json.encode({"UserId": user.serverId});

    final body = new WebMailApiBody(method: "GetAccounts", parameters: parameters);

    final res = await coreModuleForLogin.post(body);

    if (res is List) {
      final accounts = Accounts.getAccountsObjFromServer(res, user.localId);

      return accounts;
    } else {
      throw WebMailApiError(res);
    }
  }
}
