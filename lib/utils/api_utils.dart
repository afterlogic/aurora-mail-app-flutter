import 'dart:convert';
import 'dart:io';

import 'package:aurora_mail/models/api_body.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:webmail_api_client/webmail_api_client.dart';

import 'errors_enum.dart';

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

ErrorForTranslation getErrMsg(dynamic err) {
  if (err["ErrorMessage"] is String) {
    return err["ErrorMessage"];
  } else if (err["ErrorCode"] is int) {
    return _getErrMsgFromCode(err["ErrorCode"]);
  } else {
    return ErrorForTranslation.UnknownError;
  }
}

ErrorForTranslation _getErrMsgFromCode(int code) {
  switch (code) {
    case 101:
      return ErrorForTranslation.InvalidToken;
    case 102:
      return ErrorForTranslation.AuthError;
    case 103:
      return ErrorForTranslation.InvalidInputParameter;
    case 104:
      return ErrorForTranslation.DataBaseError;
    case 105:
      return ErrorForTranslation.LicenseProblem;
    case 106:
      return ErrorForTranslation.DemoAccount;
    case 107:
      return ErrorForTranslation.CaptchaError;
    case 108:
      return ErrorForTranslation.AccessDenied;
    case 109:
      return ErrorForTranslation.UnknownEmail;
    case 110:
      return ErrorForTranslation.UserNotAllowed;
    case 111:
      return ErrorForTranslation.UserAlreadyExists;
    case 112:
      return ErrorForTranslation.SystemNotConfigured;
    case 113:
      return ErrorForTranslation.ModuleNotFound;
    case 114:
      return ErrorForTranslation.MethodNotFound;
    case 115:
      return ErrorForTranslation.LicenseLimit;
    case 501:
      return ErrorForTranslation.CanNotSaveSettings;
    case 502:
      return ErrorForTranslation.CanNotChangePassword;
    case 503:
      return ErrorForTranslation.AccountOldPasswordNotCorrect;
    case 601:
      return ErrorForTranslation.CanNotCreateContact;
    case 602:
      return ErrorForTranslation.CanNotCreateGroup;
    case 603:
      return ErrorForTranslation.CanNotUpdateContact;
    case 604:
      return ErrorForTranslation.CanNotUpdateGroup;
    case 605:
      return ErrorForTranslation
          .ContactDataHasBeenModifiedByAnotherApplication;
    case 607:
      return ErrorForTranslation.CanNotGetContact;
    case 701:
      return ErrorForTranslation.CanNotCreateAccount;
    case 704:
      return ErrorForTranslation.AccountExists;
    case 710:
      return ErrorForTranslation.RestOtherError;
    case 711:
      return ErrorForTranslation.RestApiDisabled;
    case 712:
      return ErrorForTranslation.RestUnknownMethod;
    case 713:
      return ErrorForTranslation.RestInvalidParameters;
    case 714:
      return ErrorForTranslation.RestInvalidCredentials;
    case 715:
      return ErrorForTranslation.RestInvalidToken;
    case 716:
      return ErrorForTranslation.RestTokenExpired;
    case 717:
      return ErrorForTranslation.RestAccountFindFailed;
    case 719:
      return ErrorForTranslation.RestTenantFindFailed;
    case 801:
      return ErrorForTranslation.CalendarsNotAllowed;
    case 802:
      return ErrorForTranslation.FilesNotAllowed;
    case 803:
      return ErrorForTranslation.ContactsNotAllowed;
    case 804:
      return ErrorForTranslation.HelpdeskUserAlreadyExists;
    case 805:
      return ErrorForTranslation.HelpdeskSystemUserExists;
    case 806:
      return ErrorForTranslation.CanNotCreateHelpdeskUser;
    case 807:
      return ErrorForTranslation.HelpdeskUnknownUser;
    case 808:
      return ErrorForTranslation.HelpdeskUnactivatedUser;
    case 810:
      return ErrorForTranslation.VoiceNotAllowed;
    case 811:
      return ErrorForTranslation.IncorrectFileExtension;
    case 812:
      return ErrorForTranslation.CanNotUploadFileQuota;
    case 813:
      return ErrorForTranslation.FileAlreadyExists;
    case 814:
      return ErrorForTranslation.FileNotFound;
    case 815:
      return ErrorForTranslation.CanNotUploadFileLimit;
    case 901:
      return ErrorForTranslation.MailServerError;
    case 999:
      return ErrorForTranslation.UnknownError;
    default:
      print("ATTENTION! could not get error message for server code: $code");
      return ErrorForTranslation.UnknownError;
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
      return ErrorForTranslation.ConnectionError;
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
