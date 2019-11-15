import 'package:aurora_mail/generated/i18n.dart';
import 'package:flutter/cupertino.dart';

enum ErrorForTranslation {
  UserHasNoAccounts,
  ConnectionError,
  InvalidToken,
  AuthError,
  InvalidInputParameter,
  DataBaseError,
  LicenseProblem,
  DemoAccount,
  CaptchaError,
  AccessDenied,
  UnknownEmail,
  UserNotAllowed,
  UserAlreadyExists,
  SystemNotConfigured,
  ModuleNotFound,
  MethodNotFound,
  LicenseLimit,
  CanNotSaveSettings,
  CanNotChangePassword,
  AccountOldPasswordNotCorrect,
  CanNotCreateContact,
  CanNotCreateGroup,
  CanNotUpdateContact,
  CanNotUpdateGroup,
  ContactDataHasBeenModifiedByAnotherApplication,
  CanNotGetContact,
  CanNotCreateAccount,
  AccountExists,
  RestOtherError,
  RestApiDisabled,
  RestUnknownMethod,
  RestInvalidParameters,
  RestInvalidCredentials,
  RestInvalidToken,
  RestTokenExpired,
  RestAccountFindFailed,
  RestTenantFindFailed,
  CalendarsNotAllowed,
  FilesNotAllowed,
  ContactsNotAllowed,
  HelpdeskUserAlreadyExists,
  HelpdeskSystemUserExists,
  CanNotCreateHelpdeskUser,
  HelpdeskUnknownUser,
  HelpdeskUnactivatedUser,
  VoiceNotAllowed,
  IncorrectFileExtension,
  CanNotUploadFileQuota,
  FileAlreadyExists,
  FileNotFound,
  CanNotUploadFileLimit,
  MailServerError,
  UnknownError,
}

String getErrTranslation(BuildContext context, ErrorForTranslation err) {
  switch (err) {
    case ErrorForTranslation.UserHasNoAccounts:
      return S.of(context).error_login_no_accounts;
    case ErrorForTranslation.ConnectionError:
      return S.of(context).error_connection;
    case ErrorForTranslation.InvalidToken:
      return S.of(context).error_server_invalid_token;
    case ErrorForTranslation.AuthError:
      return S.of(context).error_server_auth_error;
    case ErrorForTranslation.InvalidInputParameter:
      return S.of(context).error_server_invalid_input_parameter;
    case ErrorForTranslation.DataBaseError:
      return S.of(context).error_server_data_base_error;
    case ErrorForTranslation.LicenseProblem:
      return S.of(context).error_server_license_problem;
    case ErrorForTranslation.DemoAccount:
      return S.of(context).error_server_demo_account;
    case ErrorForTranslation.CaptchaError:
      return S.of(context).error_server_captcha_error;
    case ErrorForTranslation.AccessDenied:
      return S.of(context).error_server_access_denied;
    case ErrorForTranslation.UnknownEmail:
      return S.of(context).error_server_unknown_email;
    case ErrorForTranslation.UserNotAllowed:
      return S.of(context).error_server_user_not_allowed;
    case ErrorForTranslation.UserAlreadyExists:
      return S.of(context).error_server_user_already_exists;
    case ErrorForTranslation.SystemNotConfigured:
      return S.of(context).error_server_system_not_configured;
    case ErrorForTranslation.ModuleNotFound:
      return S.of(context).error_server_module_not_found;
    case ErrorForTranslation.MethodNotFound:
      return S.of(context).error_server_method_not_found;
    case ErrorForTranslation.LicenseLimit:
      return S.of(context).error_server_license_limit;
    case ErrorForTranslation.CanNotSaveSettings:
      return S.of(context).error_server_can_not_save_settings;
    case ErrorForTranslation.CanNotChangePassword:
      return S.of(context).error_server_can_not_change_password;
    case ErrorForTranslation.AccountOldPasswordNotCorrect:
      return S.of(context).error_server_account_old_password_not_correct;
    case ErrorForTranslation.CanNotCreateContact:
      return S.of(context).error_server_can_not_create_contact;
    case ErrorForTranslation.CanNotCreateGroup:
      return S.of(context).error_server_can_not_create_group;
    case ErrorForTranslation.CanNotUpdateContact:
      return S.of(context).error_server_can_not_update_contact;
    case ErrorForTranslation.CanNotUpdateGroup:
      return S.of(context).error_server_can_not_update_group;
    case ErrorForTranslation.ContactDataHasBeenModifiedByAnotherApplication:
      return S
          .of(context)
          .error_server_contact_data_has_been_modified_by_another_application;
    case ErrorForTranslation.CanNotGetContact:
      return S.of(context).error_server_can_not_get_contact;
    case ErrorForTranslation.CanNotCreateAccount:
      return S.of(context).error_server_can_not_create_account;
    case ErrorForTranslation.AccountExists:
      return S.of(context).error_server_account_exists;
    case ErrorForTranslation.RestOtherError:
      return S.of(context).error_server_rest_other_error;
    case ErrorForTranslation.RestApiDisabled:
      return S.of(context).error_server_rest_api_disabled;
    case ErrorForTranslation.RestUnknownMethod:
      return S.of(context).error_server_rest_unknown_method;
    case ErrorForTranslation.RestInvalidParameters:
      return S.of(context).error_server_rest_invalid_parameters;
    case ErrorForTranslation.RestInvalidCredentials:
      return S.of(context).error_server_rest_invalid_credentials;
    case ErrorForTranslation.RestInvalidToken:
      return S.of(context).error_server_rest_invalid_token;
    case ErrorForTranslation.RestTokenExpired:
      return S.of(context).error_server_rest_token_expired;
    case ErrorForTranslation.RestAccountFindFailed:
      return S.of(context).error_server_rest_account_find_failed;
    case ErrorForTranslation.RestTenantFindFailed:
      return S.of(context).error_server_rest_tenant_find_failed;
    case ErrorForTranslation.CalendarsNotAllowed:
      return S.of(context).error_server_calendars_not_allowed;
    case ErrorForTranslation.FilesNotAllowed:
      return S.of(context).error_server_files_not_allowed;
    case ErrorForTranslation.ContactsNotAllowed:
      return S.of(context).error_server_contacts_not_allowed;
    case ErrorForTranslation.HelpdeskUserAlreadyExists:
      return S.of(context).error_server_helpdesk_user_already_exists;
    case ErrorForTranslation.HelpdeskSystemUserExists:
      return S.of(context).error_server_helpdesk_system_user_exists;
    case ErrorForTranslation.CanNotCreateHelpdeskUser:
      return S.of(context).error_server_can_not_create_helpdesk_user;
    case ErrorForTranslation.HelpdeskUnknownUser:
      return S.of(context).error_server_helpdesk_unknown_user;
    case ErrorForTranslation.HelpdeskUnactivatedUser:
      return S.of(context).error_server_helpdesk_unactivated_user;
    case ErrorForTranslation.VoiceNotAllowed:
      return S.of(context).error_server_voice_not_allowed;
    case ErrorForTranslation.IncorrectFileExtension:
      return S.of(context).error_server_incorrect_file_extension;
    case ErrorForTranslation.CanNotUploadFileQuota:
      return S.of(context).error_server_can_not_upload_file_quota;
    case ErrorForTranslation.FileAlreadyExists:
      return S.of(context).error_server_file_already_exists;
    case ErrorForTranslation.FileNotFound:
      return S.of(context).error_server_file_not_found;
    case ErrorForTranslation.CanNotUploadFileLimit:
      return S.of(context).error_server_can_not_upload_file_limit;
    case ErrorForTranslation.MailServerError:
      return S.of(context).error_server_mail_server_error;
    case ErrorForTranslation.UnknownError:
      return S.of(context).error_unknown;
    default:
      throw "Supplied enum value ($err) doesn't have a translation";
  }
}
