import 'dart:convert';

import 'package:aurora_mail/database/app_database.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

class PgpApi {
  final Account account;

  final WebMailApi _mailModule;

  int get _accountId => account.accountId;

  PgpApi(User user, this.account)
      : _mailModule = WebMailApi(
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

    final body = new WebMailApiBody(method: "CreateSelfDestrucPublicLink", parameters: parameters);

    final res = await _mailModule.post(body);

    if (res is Map) {
      return res["link"] as String;
    } else {
      throw WebMailApiError(res);
    }
  }
}
