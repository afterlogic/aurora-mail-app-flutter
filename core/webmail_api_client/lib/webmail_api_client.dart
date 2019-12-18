library webmail_api_client;

import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'webmail_api_body.dart';
import 'webmail_api_error.dart';

export 'webmail_api_body.dart';
export 'webmail_api_error.dart';
export 'webmail_api_modules.dart';

class WebMailApi {
  final String moduleName;
  final String apiUrl;
  final String token;

  const WebMailApi({
    @required this.moduleName,
    @required this.apiUrl,
    this.token,
  }) : assert(moduleName != null && apiUrl != null);

  Future<T> post<T>(WebMailApiBody body, {bool useToken}) async {
    Map<String, String> headers;

    if (useToken == false || token == null) {
      headers = null;
    } else {
      headers = {'Authorization': 'Bearer $token'};
    }

    final rawResponse = await http.post(apiUrl, headers: headers, body: body.toMap(moduleName));

    final res = json.decode(rawResponse.body);

    if (res["Result"] != null && res["Result"] != false) {
      return res["Result"] as T;
    } else {
      throw WebMailApiError(res);
    }
  }
}
