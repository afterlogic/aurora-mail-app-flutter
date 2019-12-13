import 'dart:convert';
import 'dart:io';

import 'package:aurora_mail/models/api_body.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:webmail_api_client/webmail_api_client.dart';

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

WebMailError getErrMsg(dynamic err) {
  if (err["ErrorMessage"] is String) {
    return err["ErrorMessage"];
  } else if (err["ErrorCode"] is int) {
    return _getErrMsgFromCode(err["ErrorCode"]);
  } else {
    return WebMailError.UnknownError;
  }
}

WebMailError _getErrMsgFromCode(int code) {
  switch (code) {
    case 101:
      return WebMailError.InvalidToken;
    case 102:
      return WebMailError.AuthError;
    case 103:
      return WebMailError.InvalidInputParameter;
    case 104:
      return WebMailError.DataBaseError;
    case 105:
      return WebMailError.LicenseProblem;
    case 106:
      return WebMailError.DemoAccount;
    case 107:
      return WebMailError.CaptchaError;
    case 108:
      return WebMailError.AccessDenied;
    case 109:
      return WebMailError.UnknownEmail;
    case 110:
      return WebMailError.UserNotAllowed;
    case 111:
      return WebMailError.UserAlreadyExists;
    case 112:
      return WebMailError.SystemNotConfigured;
    case 113:
      return WebMailError.ModuleNotFound;
    case 114:
      return WebMailError.MethodNotFound;
    case 115:
      return WebMailError.LicenseLimit;
    case 501:
      return WebMailError.CanNotSaveSettings;
    case 502:
      return WebMailError.CanNotChangePassword;
    case 503:
      return WebMailError.AccountOldPasswordNotCorrect;
    case 601:
      return WebMailError.CanNotCreateContact;
    case 602:
      return WebMailError.CanNotCreateGroup;
    case 603:
      return WebMailError.CanNotUpdateContact;
    case 604:
      return WebMailError.CanNotUpdateGroup;
    case 605:
      return WebMailError
          .ContactDataHasBeenModifiedByAnotherApplication;
    case 607:
      return WebMailError.CanNotGetContact;
    case 701:
      return WebMailError.CanNotCreateAccount;
    case 704:
      return WebMailError.AccountExists;
    case 710:
      return WebMailError.RestOtherError;
    case 711:
      return WebMailError.RestApiDisabled;
    case 712:
      return WebMailError.RestUnknownMethod;
    case 713:
      return WebMailError.RestInvalidParameters;
    case 714:
      return WebMailError.RestInvalidCredentials;
    case 715:
      return WebMailError.RestInvalidToken;
    case 716:
      return WebMailError.RestTokenExpired;
    case 717:
      return WebMailError.RestAccountFindFailed;
    case 719:
      return WebMailError.RestTenantFindFailed;
    case 801:
      return WebMailError.CalendarsNotAllowed;
    case 802:
      return WebMailError.FilesNotAllowed;
    case 803:
      return WebMailError.ContactsNotAllowed;
    case 804:
      return WebMailError.HelpdeskUserAlreadyExists;
    case 805:
      return WebMailError.HelpdeskSystemUserExists;
    case 806:
      return WebMailError.CanNotCreateHelpdeskUser;
    case 807:
      return WebMailError.HelpdeskUnknownUser;
    case 808:
      return WebMailError.HelpdeskUnactivatedUser;
    case 810:
      return WebMailError.VoiceNotAllowed;
    case 811:
      return WebMailError.IncorrectFileExtension;
    case 812:
      return WebMailError.CanNotUploadFileQuota;
    case 813:
      return WebMailError.FileAlreadyExists;
    case 814:
      return WebMailError.FileNotFound;
    case 815:
      return WebMailError.CanNotUploadFileLimit;
    case 901:
      return WebMailError.MailServerError;
    case 999:
      return WebMailError.UnknownError;
    default:
      print("ATTENTION! could not get error message for server code: $code");
      return WebMailError.UnknownError;
  }
}

class ServerError implements Exception {
  // either String or ErrorForTranslation
  final dynamic message;

  ServerError(this.message) : super();

  @override
  String toString() => message.toString();
}

dynamic formatError(dynamic err, StackTrace stack) {
  if (err is ServerError) {
    return err.message;
  } else if (err is WebMailApiError) {
    return err.message;
  } else if (err is SocketException) {
    if (err.osError.errorCode == 7) {
      return WebMailError.ConnectionError;
    } else {
      return err.message.isNotEmpty ? err.message : err;
    }
  } else {
    print("Debug error: $err");
    print("Debug stack: $stack");
    return err.toString();
    // TODO set unknown for release
//    return "Unknown error";
  }
}
