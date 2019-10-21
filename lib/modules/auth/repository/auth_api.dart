import 'dart:convert';

import 'package:aurora_mail/models/api_body.dart';
import 'package:aurora_mail/modules/app_store.dart';
import 'package:aurora_mail/utils/api_utils.dart';
import 'package:aurora_mail/utils/custom_exception.dart';
import 'package:http/http.dart' as http;

class AuthApi {
  Future<Map<String, dynamic>> login(String email, String password) async {
    final parameters =
        json.encode({"Login": email, "Password": password, "Pattern": ""});

    final body =
        new ApiBody(module: "Core", method: "Login", parameters: parameters)
            .toMap();

    final res = await http.post(AppStore.authState.apiUrl, body: body);

    final resBody = json.decode(res.body);
    if (resBody['Result'] != null && resBody['Result']['AuthToken'] is String) {
      return resBody;
    } else {
      throw CustomException(getErrMsg(resBody));
    }
  }
}
