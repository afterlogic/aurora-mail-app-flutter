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

class UserSelected extends AuthState implements AlwaysNonEqualObject {}

class InitializedUserAndAccounts extends AuthState {
  final List<User> users;
  final User user;
  final List<Account> accounts;
  final Account account;
  final bool needsLogin;

  const InitializedUserAndAccounts({
    @required this.user,
    @required this.users,
    @required this.needsLogin,
    @required this.accounts,
    @required this.account,
  }) : assert(needsLogin != null);

  @override
  List<Object> get props => [user, account, needsLogin];
}

class ReceivedLastEmail extends AuthState {
  final String email;

  const ReceivedLastEmail(this.email);

  @override
  List<Object> get props => [email];
}

class LoggingIn extends AuthState {}

class TwoFactor extends AuthState {
  final String email;
  final String password;
  final String hostname;

  TwoFactor(this.email, this.password, this.hostname);
}

class NeedsHost extends AuthState {}

class LoggedIn extends AuthState {
  final User user;
  final List<User> users;

  const LoggedIn(this.user, this.users);

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
