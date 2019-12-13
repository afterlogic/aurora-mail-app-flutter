import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/utils/errors_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class InitialAuthState extends AuthState {}

class InitializedUserAndAccounts extends AuthState {
  final User user;
  final bool needsLogin;

  const InitializedUserAndAccounts(this.user, {@required this.needsLogin})
      : assert(needsLogin != null);

  @override
  List<Object> get props => [needsLogin];
}

class LoggingIn extends AuthState {}

class NeedsHost extends AuthState {}

class LoggedIn extends AuthState {
  final User user;

  const LoggedIn(this.user);

  @override
  List<Object> get props => [user];
}

class LoggedOut extends AuthState {}

class AuthError extends AuthState {
  final dynamic errorMsg;

  const AuthError(this.errorMsg)
      : assert(errorMsg is String || errorMsg is WebMailError);

  String getErrorMsgString(BuildContext context) {
    if (errorMsg is WebMailError) {
      return getErrTranslation(context, errorMsg);
    } else {
      return errorMsg;
    }
  }

  @override
  List<Object> get props => [errorMsg];
}
