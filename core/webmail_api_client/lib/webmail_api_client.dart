library webmail_api_client;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:aurora_mail/modules/auth/repository/device_id_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

import 'webmail_api_body.dart';
import 'webmail_api_error.dart';

export 'webmail_api_body.dart';
export 'webmail_api_error.dart';
export 'webmail_api_modules.dart';

class ApiInterceptor extends ChangeNotifier {
  bool _logResponse;
  Function(String)? onRequest;
  Function(String)? onError;
  Function(String)? onResponse;

  ApiInterceptor([this._logResponse = false]);

  bool get logResponse => _logResponse;

  void set logResponse(bool value) {
    if (value != _logResponse) {
      _logResponse = value;
      notifyListeners();
    }
  }
}

class WebMailApi {
  static Function(String)? onRequest;
  static Function(String)? onError;
  static Function(String)? onResponse;
  static IOClient _client = IOClient(
    HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) {
        return false;
      })
      ..connectionTimeout = const Duration(seconds: 15),
  );

  static final _authErrorStreamCtrl = StreamController<void>.broadcast();

  // fired when token is invalid (e.g. to send user back to login)
  static Stream<void> get authErrorStream =>
      _authErrorStreamCtrl.stream.asBroadcastStream();

  static Map<String, String> getHeaderWithToken(String token) {
    return {'Authorization': 'Bearer $token'};
  }

  final String? moduleName;
  final String hostname;
  final String? token;
  final ApiInterceptor interceptor;

  WebMailApi({
    required this.moduleName,
    required this.hostname,
    this.token,
    required this.interceptor,
  });

  String get apiUrl => "$hostname/?Api/";

  Future getAuthHeaders() async {
    return {
      'Authorization': 'Bearer $token',
      'X-DeviceId': await DeviceIdStorage.getDeviceId()
    };
  }

  // Duration _connectionTimeout = const Duration(seconds: 120);
  // Response Function() _onConnectionTimeout = () => Response(
  //     json.encode({"ErrorMessage": "Connection timed out", "ErrorCode": 408}),
  //     408);

  _onRequest(String id, String? parameters) {
    if (interceptor.onRequest != null) {
      interceptor.onRequest!("$id\nURL: $apiUrl\nPARAMETERS: ${parameters ?? ''}");
    } else if (onRequest != null) {
      onRequest!("$id\nURL: $apiUrl\nPARAMETERS: ${parameters ?? ''}");
    }
  }

  _onResponse(String id, int delay, int status, dynamic res) {
    if (interceptor.onResponse != null) {
      interceptor.onResponse!(
          "$id\nDELAY: ${delay}\nSTATUS: ${status} ${interceptor.logResponse == true ? "\nBODY:$res" : ""}");
    } else if (onResponse != null) {
      onResponse!(
          "$id\nDELAY: ${delay}\nSTATUS: ${status} ${interceptor.logResponse == true ? "\nBODY:$res" : ""}");
    }
  }

  _onError(String? token, String id, String body) {
    final log = "TOKEN: ${token ?? ""}\n$id\n${body}";
    if (interceptor.onError != null) {
      interceptor.onError!(log);
    } else if (onError != null) {
      onError!(log);
    }
  }

  // getRawResponse in case AuthenticatedUserId is required, which is outside Result objects
  Future post(WebMailApiBody body, {
    bool useToken = true,
    bool getRawResponse = false,
    Map<String, String>? addedHeaders
  }) async {
    Map<String, String> headers;
    final id = "MODULE: ${moduleName ?? body.module}\nMETHOD: ${body.method}";
    if (useToken == false || token == null) {
      headers = {};
    } else {
      headers = {'Authorization': 'Bearer $token'};
    }
    headers['X-DeviceId'] = await DeviceIdStorage.getDeviceId();

    addedHeaders?.forEach((key, value) {
      headers[key] = value;
    });
    final start = DateTime.now().millisecondsSinceEpoch;
    _onRequest(id, body.parameters);
    try {
      final rawResponse = await _client.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: body.toMap(moduleName),
      );
      final res = json.decode(rawResponse.body);

      if (res["Result"] != null && (res["Result"] != false || getRawResponse)) {
        _onResponse(id, DateTime.now().millisecondsSinceEpoch - start,
            rawResponse.statusCode, res);
        if (getRawResponse)
          return res;
        else
          return res["Result"];
      } else {
        _onError(token, id, rawResponse.body);
        // TODO: replace ErrorCode overriding below with a more generic solution
        // 4002 is a Mail module error, which means the account credentials are invalid
        if (res["ErrorCode"] == 4002) {
          res["ErrorCode"] = 102;
        }
        if (res["ErrorCode"] == 102) {
          _authErrorStreamCtrl.add(res["ErrorCode"]);
        }
        throw WebMailApiError(res);
      }
    } catch (err) {
      print('ERROR WebMailApi.post(): $err');
      rethrow;
    }
  }

  Future multiPart(WebMailApiBody body, MultipartFile file,
      {bool useToken = true, bool getRawResponse = false}) async {
    Map<String, String>? headers;
    final id = "MODULE: ${moduleName ?? body.module}\nMETHOD: ${body.method}";
    if (useToken == false || token == null) {
      headers = null;
    } else {
      headers = {'Authorization': 'Bearer $token'};
    }
    final start = DateTime.now().millisecondsSinceEpoch;
      onRequest?.call("$id\nURL:$apiUrl\nPARAMETERS:${body.parameters}");

    final request = MultipartRequest("POST", Uri.parse(apiUrl));

    if(headers != null){
      request.headers.addAll(headers);
    }
    request.fields.addAll(body.toMap(moduleName));
    request.files.add(file);
    final rawResponse = await request.send();
    final responseBody = await rawResponse.stream.bytesToString();
    final res = json.decode(responseBody);

    if (res["Result"] != null && (res["Result"] != false || getRawResponse)) {
        onResponse?.call(
            "$id\nDELAY: ${DateTime.now().millisecondsSinceEpoch - start}\nSTATUS:${rawResponse.statusCode}");
      if (getRawResponse)
        return res;
      else
        return res["Result"];
    } else {
      onError?.call("$id\n${responseBody}");
      if (res["ErrorCode"] == 102 || res["ErrorCode"] == 108) {
        _authErrorStreamCtrl.add(102);
      }
      throw WebMailApiError(res);
    }
  }
}
