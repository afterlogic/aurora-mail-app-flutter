import 'dart:convert';

import 'package:aurora_mail/models/api_body.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:http/http.dart' as http;

Map<String, String> getHeaderWithToken() {
  return {'Authorization': 'Bearer ${AuthBloc.currentUser.token}'};
}

Future sendRequest(ApiBody body, {decodeJson = true, useToken = true}) async {
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

String getErrMsg(dynamic err) {
  if (err["ErrorMessage"] is String) {
    return err["ErrorMessage"];
  } else if (err["ErrorCode"] is int) {
    return _getErrMsgFromCode(err["ErrorCode"]);
  } else {
    return "Unknown error";
  }
}

String _getErrMsgFromCode(int code) {
  switch (code) {
    case 101:
      return "Invalid token";
    case 102:
      return "Invalid email/password";
    case 103:
      return "Invalid input parameter";
    case 104:
      return "DataBase error";
    case 105:
      return "License problem";
    case 106:
      return "Demo account";
    case 107:
      return "Captcha error";
    case 108:
      return "Access denied";
    case 109:
      return "Unknown email";
    case 110:
      return "User is not allowed";
    case 111:
      return "Such user already exists";
    case 112:
      return "System is not configured";
    case 113:
      return "Module not found";
    case 114:
      return "Method not found";
    case 115:
      return "License limit";
    case 501:
      return "Cannot save settings";
    case 502:
      return "Cannot change password";
    case 503:
      return "Account's old password is not correct";
    case 601:
      return "Cannot create contact";
    case 602:
      return "Cannot create group";
    case 603:
      return "Cannot update contact";
    case 604:
      return "Cannot update group";
    case 605:
      return "Contact data has been modified by another application";
    case 607:
      return "Cannot get contact";
    case 701:
      return "Cannot create account";
    case 704:
      return "Such account already exists";
    case 710:
      return "Rest other error";
    case 711:
      return "Rest api disabled";
    case 712:
      return "Rest unknown method";
    case 713:
      return "Rest invalid parameters";
    case 714:
      return "Rest invalid credentials";
    case 715:
      return "Rest invalid token";
    case 716:
      return "Rest token expired";
    case 717:
      return "Rest account find failed";
    case 719:
      return "Rest tenant find failed";
    case 801:
      return "Calendars not allowed";
    case 802:
      return "Files not allowed";
    case 803:
      return "Contacts not allowed";
    case 804:
      return "Helpdesk user already exists";
    case 805:
      return "Helpdesk system user already exists";
    case 806:
      return "Cannot create helpdesk user";
    case 807:
      return "Helpdesk unknown user";
    case 808:
      return "Helpdesk unactivated user";
    case 810:
      return "Voice not allowed";
    case 811:
      return "Incorrect file extension";
    case 812:
      return "You have reached your cloud storage space limit. Can't upload file.";
    case 813:
      return "Such file already exists";
    case 814:
      return "File not found";
    case 815:
      return "Cannot upload file limit";
    case 901:
      return "Mail server error";
    case 999:
      return "Unknown error";
    default:
      return code.toString();
  }
}
