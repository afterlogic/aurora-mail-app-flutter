import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/utils/always_non_equal_object.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

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
  List<Object> get props => [user, needsLogin];
}

class ReceivedLastEmail extends AuthState {
  final String email;

  const ReceivedLastEmail(this.email);

  @override
  List<Object> get props => [email];
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
  final String errorMsg;

  const AuthError(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}
