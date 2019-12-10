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

    final rawResponse =
        await http.post(apiUrl, headers: headers, body: body.toMap(moduleName));

    final res = json.decode(rawResponse.body);

    if (res["Result"] != null && res["Result"] != false) {
      return res["Result"] as T;
    } else {
      throw WebMailApiError(_getErrMsg(res));
    }
  }

  WebMailError _getErrMsg(dynamic err) {
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
        return WebMailError.ContactDataHasBeenModifiedByAnotherApplication;
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
}
