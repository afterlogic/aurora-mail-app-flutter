library webmail_api_client;

import 'dart:async';
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
  final String hostname;
  final String token;
  static Function(String) onRequest;
  static Function(String) onError;

  String get apiUrl => "$hostname/?Api/";

  Map<String, String> get headerWithToken => {'Authorization': 'Bearer $token'};

  WebMailApi({
    @required this.moduleName,
    @required this.hostname,
    this.token,
  }) : assert(moduleName != null && hostname != null);

  static final _authErrorStreamCtrl = StreamController<void>.broadcast();

  // fired when token is invalid (e.g. to send user back to login)
  static Stream<void> get authErrorStream =>
      _authErrorStreamCtrl.stream.asBroadcastStream();

  static Map<String, String> getHeaderWithToken(String token) {
    return {'Authorization': 'Bearer $token'};
  }

  // getRawResponse in case AuthenticatedUserId is required, which is outside Result objects
  Future post(WebMailApiBody body,
      {bool useToken, bool getRawResponse = false}) async {
    Map<String, String> headers;

    if (useToken == false || token == null) {
      headers = null;
    } else {
      headers = {'Authorization': 'Bearer $token'};
    }
    if (onRequest != null)
      onRequest("URL:$apiUrl\nBODY:${body.toMap(moduleName)}");

    final rawResponse =
        await http.post(apiUrl, headers: headers, body: body.toMap(moduleName));

    final res = json.decode(rawResponse.body);

    if (res["Result"] != null && (res["Result"] != false || getRawResponse)) {
      if (getRawResponse)
        return res;
      else
        return res["Result"];
    } else {
      if (onError != null) onError("${rawResponse.body}");
      if (res["ErrorCode"] == 102) {
        _authErrorStreamCtrl.add(102);
      }
      throw WebMailApiError(res);
    }
  }
}
