import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/cupertino.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

//enum WebMailError {
//  UserHasNoAccounts,
//  ConnectionError,
//  InvalidToken,
//  AuthError,
//  InvalidInputParameter,
//  DataBaseError,
//  LicenseProblem,
//  DemoAccount,
//  CaptchaError,
//  AccessDenied,
//  UnknownEmail,
//  UserNotAllowed,
//  UserAlreadyExists,
//  SystemNotConfigured,
//  ModuleNotFound,
//  MethodNotFound,
//  LicenseLimit,
//  CanNotSaveSettings,
//  CanNotChangePassword,
//  AccountOldPasswordNotCorrect,
//  CanNotCreateContact,
//  CanNotCreateGroup,
//  CanNotUpdateContact,
//  CanNotUpdateGroup,
//  ContactDataHasBeenModifiedByAnotherApplication,
//  CanNotGetContact,
//  CanNotCreateAccount,
//  AccountExists,
//  RestOtherError,
//  RestApiDisabled,
//  RestUnknownMethod,
//  RestInvalidParameters,
//  RestInvalidCredentials,
//  RestInvalidToken,
//  RestTokenExpired,
//  RestAccountFindFailed,
//  RestTenantFindFailed,
//  CalendarsNotAllowed,
//  FilesNotAllowed,
//  ContactsNotAllowed,
//  HelpdeskUserAlreadyExists,
//  HelpdeskSystemUserExists,
//  CanNotCreateHelpdeskUser,
//  HelpdeskUnknownUser,
//  HelpdeskUnactivatedUser,
//  VoiceNotAllowed,
//  IncorrectFileExtension,
//  CanNotUploadFileQuota,
//  FileAlreadyExists,
//  FileNotFound,
//  CanNotUploadFileLimit,
//  MailServerError,
//  UnknownError,
//}

String getErrTranslation(BuildContext context, WebMailError err) {
  switch (err) {
    case WebMailError.UserHasNoAccounts:
      return i18n(context, "error_login_no_accounts");
    case WebMailError.ConnectionError:
      return i18n(context, "error_connection");
    case WebMailError.InvalidToken:
      return i18n(context, "error_server_invalid_token");
    case WebMailError.AuthError:
      return i18n(context, "error_server_auth_error");
    case WebMailError.InvalidInputParameter:
      return i18n(context, "error_server_invalid_input_parameter");
    case WebMailError.DataBaseError:
      return i18n(context, "error_server_data_base_error");
    case WebMailError.LicenseProblem:
      return i18n(context, "error_server_license_problem");
    case WebMailError.DemoAccount:
      return i18n(context, "error_server_demo_account");
    case WebMailError.CaptchaError:
      return i18n(context, "error_server_captcha_error");
    case WebMailError.AccessDenied:
      return i18n(context, "error_server_access_denied");
    case WebMailError.UnknownEmail:
      return i18n(context, "error_server_unknown_email");
    case WebMailError.UserNotAllowed:
      return i18n(context, "error_server_user_not_allowed");
    case WebMailError.UserAlreadyExists:
      return i18n(context, "error_server_user_already_exists");
    case WebMailError.SystemNotConfigured:
      return i18n(context, "error_server_system_not_configured");
    case WebMailError.ModuleNotFound:
      return i18n(context, "error_server_module_not_found");
    case WebMailError.MethodNotFound:
      return i18n(context, "error_server_method_not_found");
    case WebMailError.LicenseLimit:
      return i18n(context, "error_server_license_limit");
    case WebMailError.CanNotSaveSettings:
      return i18n(context, "error_server_can_not_save_settings");
    case WebMailError.CanNotChangePassword:
      return i18n(context, "error_server_can_not_change_password");
    case WebMailError.AccountOldPasswordNotCorrect:
      return i18n(context, "error_server_account_old_password_not_correct");
    case WebMailError.CanNotCreateContact:
      return i18n(context, "error_server_can_not_create_contact");
    case WebMailError.CanNotCreateGroup:
      return i18n(context, "error_server_can_not_create_group");
    case WebMailError.CanNotUpdateContact:
      return i18n(context, "error_server_can_not_update_contact");
    case WebMailError.CanNotUpdateGroup:
      return i18n(context, "error_server_can_not_update_group");
    case WebMailError.ContactDataHasBeenModifiedByAnotherApplication:
      return i18n(context,
          "error_server_contact_data_has_been_modified_by_another_application");
    case WebMailError.CanNotGetContact:
      return i18n(context, "error_server_can_not_get_contact");
    case WebMailError.CanNotCreateAccount:
      return i18n(context, "error_server_can_not_create_account");
    case WebMailError.AccountExists:
      return i18n(context, "error_server_account_exists");
    case WebMailError.RestOtherError:
      return i18n(context, "error_server_rest_other_error");
    case WebMailError.RestApiDisabled:
      return i18n(context, "error_server_rest_api_disabled");
    case WebMailError.RestUnknownMethod:
      return i18n(context, "error_server_rest_unknown_method");
    case WebMailError.RestInvalidParameters:
      return i18n(context, "error_server_rest_invalid_parameters");
    case WebMailError.RestInvalidCredentials:
      return i18n(context, "error_server_rest_invalid_credentials");
    case WebMailError.RestInvalidToken:
      return i18n(context, "error_server_rest_invalid_token");
    case WebMailError.RestTokenExpired:
      return i18n(context, "error_server_rest_token_expired");
    case WebMailError.RestAccountFindFailed:
      return i18n(context, "error_server_rest_account_find_failed");
    case WebMailError.RestTenantFindFailed:
      return i18n(context, "error_server_rest_tenant_find_failed");
    case WebMailError.CalendarsNotAllowed:
      return i18n(context, "error_server_calendars_not_allowed");
    case WebMailError.FilesNotAllowed:
      return i18n(context, "error_server_files_not_allowed");
    case WebMailError.ContactsNotAllowed:
      return i18n(context, "error_server_contacts_not_allowed");
    case WebMailError.HelpdeskUserAlreadyExists:
      return i18n(context, "error_server_helpdesk_user_already_exists");
    case WebMailError.HelpdeskSystemUserExists:
      return i18n(context, "error_server_helpdesk_system_user_exists");
    case WebMailError.CanNotCreateHelpdeskUser:
      return i18n(context, "error_server_can_not_create_helpdesk_user");
    case WebMailError.HelpdeskUnknownUser:
      return i18n(context, "error_server_helpdesk_unknown_user");
    case WebMailError.HelpdeskUnactivatedUser:
      return i18n(context, "error_server_helpdesk_unactivated_user");
    case WebMailError.VoiceNotAllowed:
      return i18n(context, "error_server_voice_not_allowed");
    case WebMailError.IncorrectFileExtension:
      return i18n(context, "error_server_incorrect_file_extension");
    case WebMailError.CanNotUploadFileQuota:
      return i18n(context, "error_server_can_not_upload_file_quota");
    case WebMailError.FileAlreadyExists:
      return i18n(context, "error_server_file_already_exists");
    case WebMailError.FileNotFound:
      return i18n(context, "error_server_file_not_found");
    case WebMailError.CanNotUploadFileLimit:
      return i18n(context, "error_server_can_not_upload_file_limit");
    case WebMailError.MailServerError:
      return i18n(context, "error_server_mail_server_error");
    case WebMailError.UnknownError:
      return i18n(context, "error_unknown");
    default:
      throw "Supplied enum value ($err) doesn't have a translation";
  }
}
