class WebMailApiError implements Exception {
  // either String or WebMailError
  final dynamic message;

  WebMailApiError(this.message) : super();

  @override
  String toString() => message.toString();
}

enum WebMailError {
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
