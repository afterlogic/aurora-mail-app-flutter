import 'dart:convert';

import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/database/account_identity/account_identity_table.dart';
import 'package:aurora_mail/database/accounts/accounts_table.dart';
import 'package:aurora_mail/database/aliases/aliases_table.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/auth/repository/device_id_storage.dart';
import 'package:aurora_mail/modules/settings/screens/debug/default_api_interceptor.dart';
import 'package:http/http.dart' as http;
import 'package:webmail_api_client/webmail_api_client.dart';

class AuthApi {
  Future<Map<String, String>> deviceIdHeader() async {
    return {"X-DeviceId": await DeviceIdStorage.getDeviceId() ?? ''};
  }

  Future<String?> autoDiscoverHostname(String email) async {
    try {
      final dogIndex = email.indexOf("@") + 1;

      final domain = email.substring(dogIndex);

      final url = BuildProperty.autodiscover_url
          .replaceFirst("{domain}", domain)
          .replaceFirst("{email}", email);

      final res = await http.get(Uri.parse(url));
      final resBody = json.decode(res.body);
      return resBody["url"] as String;
    } catch (err) {
      return null;
    }
  }

  Future<User> login(String email, String password, String hostname) async {
    final coreModuleForLogin = WebMailApi(
      moduleName: WebMailModules.core,
      hostname: hostname,
      interceptor: DefaultApiInterceptor.get(),
    );

    final parameters =
        json.encode({"Login": email, "Password": password, "Pattern": ""});

    final body = new WebMailApiBody(method: "Login", parameters: parameters);

    try {
      final response = await coreModuleForLogin.post(
        body,
        getRawResponse: true,
      );
      if (response["ErrorCode"] == 108) {
        throw AllowAccess();
      }
      if (response['Result'] != null &&
          response['Result']['TwoFactorAuth'] != null) {
        final twoFactor = response['Result']['TwoFactorAuth'];
        if (twoFactor == true) {
          throw RequestTwoFactor(
            hostname,
            true,
            false,
            false,
          );
        }

        throw RequestTwoFactor(
          hostname,
          twoFactor["HasAuthenticatorApp"] as bool,
          twoFactor["HasSecurityKey"] as bool,
          twoFactor["HasBackupCodes"] as bool,
        );
      } else if (response['Result'] != null &&
          response['Result']['AuthToken'] is String) {
        if (BuildProperty.supportAllowAccess &&
            response['Result']["AllowAccess"] != 1) {
          throw AllowAccess();
        }
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
    } catch (e) {
      if (e is WebMailApiError && e.code == 108) {
        throw AllowAccess();
      }
      rethrow;
    }
  }

  Future<void> logout(User user) async {
    final coreModuleForLogin = WebMailApi(
      moduleName: WebMailModules.core,
      hostname: user.hostname,
      token: user.token,
      interceptor: DefaultApiInterceptor.get(),
    );

    final body = new WebMailApiBody(module: "Core", method: "Logout");

    final res = await coreModuleForLogin.post(
      body,
      // addedHeaders: await deviceIdHeader(),
    );

    if (res != true) {
      throw WebMailApiError(res);
    }
  }

  Future<List<Account>> getAccounts(User user) async {
    final coreModuleForLogin = WebMailApi(
      moduleName: WebMailModules.mail,
      hostname: user.hostname,
      token: user.token,
      interceptor: DefaultApiInterceptor.get(),
    );

    final parameters = json.encode({"UserId": user.serverId});

    final body =
        new WebMailApiBody(method: "GetAccounts", parameters: parameters);

    final res = await coreModuleForLogin.post(
      body,
      // addedHeaders: await deviceIdHeader(),
    );

    if (res is List) {
      final accounts = Accounts.getAccountsObjFromServer(res, user.localId!);

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
      interceptor: DefaultApiInterceptor.get(),
    );
    final parameters = json.encode({
      "Code": pin,
      "Login": login,
      "Password": password,
    });

    final body = new WebMailApiBody(
        method: "VerifyAuthenticatorAppCode", parameters: parameters);

    final res = await twoFactorModule.post(
      body,
      getRawResponse: true,
      // addedHeaders: await deviceIdHeader(),
    );

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
      interceptor: DefaultApiInterceptor.get(),
    );

    final request = new WebMailApiBody(method: "GetIdentities");
    final res = await mailModule.post(
      request,
      // addedHeaders: await deviceIdHeader(),
    );

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
      interceptor: DefaultApiInterceptor.get(),
    );

    final request = new WebMailApiBody(method: "GetAliases");
    final res = await mailModule.post(
      request,
      // addedHeaders: await deviceIdHeader(),
    );

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

  Future<bool> setPushToken(Map<User, List<String>> userWithAccount, String uid,
      String fbToken) async {
    final map = <String, List<MapEntry<User, List<String>>>>{};
    bool success = true;
    for (var value in userWithAccount.entries) {
      var list = map[value.key.hostname];
      if (list == null) {
        list = [];
        map[value.key.hostname] = list;
      }
      list.add(value);
    }
    for (var entry in map.entries) {
      try {
        final webMailApi = WebMailApi(
          moduleName: WebMailModules.core,
          hostname: entry.key,
          interceptor: DefaultApiInterceptor.get(),
        );
        final parameters = json.encode({
          "Users": entry.value
              .map((item) => {
                    "AuthToken": item.key.token,
                    "Emails": item.value,
                  })
              .toList(),
          "Uid": uid,
          "Token": fbToken,
        });
        final body = new WebMailApiBody(
          module: "PushNotificator",
          method: "SetPushToken",
          parameters: parameters,
        );
        final res = await webMailApi.post(
          body,
          // addedHeaders: await deviceIdHeader(),
        );
        print(res);
      } catch (e, s) {
        success = false;
        print(e);
      }
    }
    return success;
  }

  Future<SecurityKeyBegin> verifySecurityKeyBegin(
    String host,
    String login,
    String password,
  ) async {
    final mailModule = WebMailApi(
      moduleName: "TwoFactorAuth",
      hostname: host,
      interceptor: DefaultApiInterceptor.get(),
    );

    final request = new WebMailApiBody(
        method: "VerifySecurityKeyBegin",
        parameters: jsonEncode({
          "Login": login,
          "Password": password,
        }));
    final res = await mailModule.post(
      request,
      // addedHeaders: await deviceIdHeader(),
    );

    if (res is Map) {
      final map = res["publicKey"];
      return SecurityKeyBegin(
        host,
        (map["timeout"] as num).toDouble(),
        map["challenge"] as String,
        map["rpId"] as String,
        (map["allowCredentials"] as List)
            .map((e) => e["id"] as String)
            .toList(),
      );
    } else {
      throw WebMailApiError(res);
    }
  }

  Future<User> verifySecurityKeyFinish(
    String host,
    String login,
    String password,
    Map attestation,
  ) async {
    final mailModule = WebMailApi(
      moduleName: "TwoFactorAuth",
      hostname: host,
      interceptor: DefaultApiInterceptor.get(),
    );

    final request = new WebMailApiBody(
        method: "VerifySecurityKeyFinish",
        parameters: jsonEncode({
          "Login": login,
          "Password": password,
          "Attestation": attestation,
        }));
    final res = await mailModule.post(
      request,
      getRawResponse: true,
      // addedHeaders: await deviceIdHeader(),
    );
    if (res["Result"] is! Map ||
        !(res["Result"] as Map).containsKey("AuthToken")) {
      throw WebMailApiError(res);
    }
    final userId = res['AuthenticatedUserId'] as int;
    final token = res["Result"]["AuthToken"] as String;

    return User(
      localId: null,
      serverId: userId,
      token: token,
      hostname: host,
      emailFromLogin: login,
    );
  }

  Future<User> verifyCode(
    String hostname,
    String code,
    String login,
    String password,
  ) async {
    final twoFactorModule = WebMailApi(
      moduleName: WebMailModules.twoFactorAuth,
      hostname: hostname,
      interceptor: DefaultApiInterceptor.get(),
    );
    final parameters = json.encode({
      "BackupCode": code,
      "Login": login,
      "Password": password,
    });

    final body =
        new WebMailApiBody(method: "VerifyBackupCode", parameters: parameters);

    final res = await twoFactorModule.post(
      body,
      getRawResponse: true,
      // addedHeaders: await deviceIdHeader(),
    );

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

  Future saveDevice(
    String deviceId,
    String deviceName,
    String hostname,
    String token,
  ) async {
    final twoFactorModule = WebMailApi(
      moduleName: WebMailModules.twoFactorAuth,
      hostname: hostname,
      token: token,
      interceptor: DefaultApiInterceptor.get(),
    );
    final parameters = json.encode({
      "DeviceId": deviceId,
      "DeviceName": deviceName,
    });

    final body =
        new WebMailApiBody(method: "SetDeviceName", parameters: parameters);

    final res = await twoFactorModule.post(
      body,
      // addedHeaders: await deviceIdHeader(),
    );

    print(res);
  }

  Future trustDevice(
    String? deviceId,
    String deviceName,
    String hostname,
    String token,
  ) async {
    final twoFactorModule = WebMailApi(
      moduleName: WebMailModules.twoFactorAuth,
      hostname: hostname,
      token: token,
      interceptor: DefaultApiInterceptor.get(),
    );
    final parameters = json.encode({
      "DeviceId": deviceId,
      "DeviceName": deviceName,
    });

    final body =
        new WebMailApiBody(method: "TrustDevice", parameters: parameters);

    final res = await twoFactorModule.post(
      body,
      // addedHeaders: await deviceIdHeader(),
    );

    print(res);
  }

  Future<int> getTwoFactorSettings(String hostname) async {
    final twoFactorModule = WebMailApi(
      moduleName: WebMailModules.twoFactorAuth,
      hostname: hostname,
      interceptor: DefaultApiInterceptor.get(),
    );
    final body = new WebMailApiBody(method: "GetSettings");

    final res = await twoFactorModule.post(
      body,
      // addedHeaders: await deviceIdHeader(),
    );

    return (res["TrustDevicesForDays"] as num).toInt();
  }
}

class RequestTwoFactor extends Error {
  final String host;
  final bool hasAuthenticatorApp;
  final bool hasSecurityKey;
  final bool hasBackupCodes;

  RequestTwoFactor(this.host, this.hasAuthenticatorApp, this.hasSecurityKey,
      this.hasBackupCodes);
}

class AllowAccess extends Error {
  AllowAccess();
}

class InvalidPin extends Error {}

class SecurityKeyBegin {
  final String host;
  final double timeout;
  final String challenge;
  final String rpId;
  final List<String> allowCredentials;

  SecurityKeyBegin(
    this.host,
    this.timeout,
    this.challenge,
    this.rpId,
    this.allowCredentials,
  );
}
