import 'dart:io';

import 'package:aurora_mail/res/str/s.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:webmail_api_client/webmail_api_client.dart';
import 'error_code.dart';

//Map<String, String> getHeaderWithToken() {
//  return {'Authorization': 'Bearer ${AuthBloc.currentUser.token}'};
//}

//Future sendRequest(ApiBody body, {bool decodeJson = true, bool useToken = true}) async {
//  final rawResponse = useToken
//      ? await http.post(AuthBloc.apiUrl,
//          headers: getHeaderWithToken(), body: body.toMap())
//      : await http.post(AuthBloc.apiUrl, body: body.toMap());
//
//  if (decodeJson = true) {
//    return json.decode(rawResponse.body);
//  } else {
//    return rawResponse.body;
//  }
//}

ErrorToShow formatError(dynamic err, StackTrace stack) {
  if (err is WebMailApiError) {
    return err.toShow();
  } else if (err is SocketException) {
    if (err.osError.errorCode == 7) {
      return ErrorToShow.code(S.error_connection);
    } else {
      return ErrorToShow.message(
          err.message.isNotEmpty ? err.message : err.toString());
    }
  } else {
    print("Debug error: $err");
    print("Debug stack: $stack");
    return ErrorToShow(err);
    // TODO set unknown for release
//    return "Unknown error";
  }
}
