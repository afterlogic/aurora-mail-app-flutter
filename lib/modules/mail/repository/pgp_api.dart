import 'dart:convert';

import 'package:aurora_mail/database/app_database.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

class PgpApi {
  final Account account;
  final User user;
  final WebMailApi _pgpModule;

  int get _accountId => account.accountId;

  PgpApi(this.user, this.account)
      : _pgpModule = WebMailApi(
          moduleName: WebMailModules.openPgp,
          hostname: user.hostname,
          token: user.token,
        );

  Future<String> createSelfDestructLink(
    String subject,
    String message,
    String toEmail,
    bool useKeyBase,
    int lifeTime,
  ) async {
    final parameters = json.encode({
      "Subject": subject,
      "Data": message,
      "RecipientEmail": toEmail,
      "PgpEncryptionMode": useKeyBase ? "key" : "password",
      "LifetimeHrs": lifeTime
    });

    final body = new WebMailApiBody(
      method: "CreateSelfDestrucPublicLink",
      parameters: parameters,
    );

    final res = await _pgpModule.post(body);

    if (res is Map) {
      return user.hostname + "/" + (res["link"] as String) + "#self-destruct";
    } else {
      throw WebMailApiError(res);
    }
  }
}
