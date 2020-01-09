import 'dart:convert';
import 'dart:io';

import 'package:aurora_mail/models/api_body.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:webmail_api_client/webmail_api_client.dart';

Map<String, String> getHeaderWithToken() {
  return {'Authorization': 'Bearer ${AuthBloc.currentUser.token}'};
}

Future sendRequest(ApiBody body, {bool decodeJson = true, bool useToken = true}) async {
  final rawResponse = useToken
      ? await http.post(AuthBloc.apiUrl,
          headers: getHeaderWithToken(), body: body.toMap())
      : await http.post(AuthBloc.apiUrl, body: body.toMap());

  if (decodeJson = true) {
    return json.decode(rawResponse.body);
  } else {
    return rawResponse.body;
  }
}

String formatError(dynamic err, StackTrace stack) {
  if (err is WebMailApiError) {
    return err.message;
  } else if (err is SocketException) {
    if (err.osError.errorCode == 7) {
      return "error_connection";
    } else {
      return err.message.isNotEmpty ? err.message : err.toString();
    }
  } else {
    print("Debug error: $err");
    print("Debug stack: $stack");
    return err.toString();
    // TODO set unknown for release
//    return "Unknown error";
  }
}
