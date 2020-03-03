import 'dart:convert';

import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/database/account_identity/account_identity_table.dart';
import 'package:aurora_mail/database/accounts/accounts_table.dart';
import 'package:aurora_mail/database/aliases/aliases_table.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:http/http.dart' as http;
import 'package:webmail_api_client/webmail_api_client.dart';

class AuthApi {
  Future<String> autoDiscoverHostname(String email) async {
    try {
      final url = "${BuildProperty.autodiscover_url}?email=$email";
      final res = await http.get(url);
      final resBody = json.decode(res.body);
      return resBody["url"] as String;
    } catch (err) {
      return null;
    }
  }

  Future<User> login(String email, String password, String hostname) async {
    final coreModuleForLogin =
        WebMailApi(moduleName: WebMailModules.core, hostname: hostname);

    final parameters =
        json.encode({"Login": email, "Password": password, "Pattern": ""});

    final body = new WebMailApiBody(method: "Login", parameters: parameters);

    final response = await coreModuleForLogin.post(body, getRawResponse: true);
    if (response['Result'] != null &&
        response['Result']['TwoFactorAuth'] != null) {
      throw RequestTwoFactor(hostname);
    } else if (response['Result'] != null &&
        response['Result']['AuthToken'] is String) {
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

    final body =
        new WebMailApiBody(method: "GetAccounts", parameters: parameters);

    final res = await coreModuleForLogin.post(body);

    if (res is List) {
      final accounts = Accounts.getAccountsObjFromServer(res, user.localId);

      return accounts;
    } else {
      throw WebMailApiError(res);
    }
  }

  Future<User> verifyPin(
    String hostname,
    String pin,
    String login,
    String password,
  ) async {
    final twoFactorModule = WebMailApi(
      moduleName: WebMailModules.twoFactorAuth,
      hostname: hostname,
    );
    final parameters = json.encode({
      "Pin": pin,
      "Login": login,
      "Password": password,
    });

    final body =
        new WebMailApiBody(method: "VerifyPin", parameters: parameters);

    final res = await twoFactorModule.post(body, getRawResponse: true);

    if (res["Result"] is! Map ||
        !(res["Result"] as Map).containsKey("AuthToken")) {
      throw InvalidPin();
    }
    final userId = res['AuthenticatedUserId'] as int;
    final token = res["Result"]["AuthToken"] as String;

    return User(
      localId: null,
      serverId: userId,
      token: token,
      hostname: hostname,
      emailFromLogin: login,
    );
  }

  Future<List<AccountIdentity>> getIdentity(User user) async {
    final mailModule = WebMailApi(
      moduleName: WebMailModules.mail,
      hostname: user.hostname,
      token: user.token,
    );

    final request = new WebMailApiBody(method: "GetIdentities");
    final res = await mailModule.post(request);

    if (res is List) {
      return res
          .map(
            (map) =>
                AccountIdentityMap.fromNetwork(map as Map<String, dynamic>),
          )
          .toList();
    } else {
      throw WebMailApiError(res);
    }
  }

  Future<List<Aliases>> getAliases(User user) async {
    final mailModule = WebMailApi(
      moduleName: "CpanelIntegrator",
      hostname: user.hostname,
      token: user.token,
    );

    final request = new WebMailApiBody(method: "GetAliases");
    final res = await mailModule.post(request);

    if (res is Map) {
      return (res["ObjAliases"] as List)
          .map(
            (map) => AliasesMap.fromNetwork(map as Map<String, dynamic>),
          )
          .toList();
    } else {
      throw WebMailApiError(res);
    }
  }
}

class RequestTwoFactor extends Error {
  final String host;

  RequestTwoFactor(this.host);
}

class InvalidPin extends Error {}
