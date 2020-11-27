import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/utils/always_non_equal_object.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class InitialAuthState extends AuthState {}

class UserSelected extends AuthState with AlwaysNonEqualObject {}

class InitializedUserAndAccounts extends AuthState {
  final List<User> users;
  final User user;
  final List<Account> accounts;
  final Account account;
  final bool needsLogin;
  final AccountIdentity identity;

  const InitializedUserAndAccounts({
    @required this.user,
    @required this.users,
    @required this.needsLogin,
    @required this.accounts,
    @required this.account,
    this.identity,
  }) : assert(needsLogin != null);

  @override
  List<Object> get props => [user, account, needsLogin, account, users, accounts, identity];
}

class ReceivedLastEmail extends AuthState {
  final String email;

  const ReceivedLastEmail(this.email);

  @override
  List<Object> get props => [email];
}

class LoggingIn extends AuthState {}

class TwoFactor extends AuthState with AlwaysNonEqualObject {
  final String email;
  final String password;
  final String hostname;
  final bool hasAuthenticatorApp;
  final bool hasSecurityKey;
  final bool hasBackupCodes;

  TwoFactor(
    this.email,
    this.password,
    this.hostname,
    this.hasAuthenticatorApp,
    this.hasSecurityKey,
    this.hasBackupCodes,
  );
}

class NeedsHost extends AuthState {}

class UpgradePlan extends AuthState with AlwaysNonEqualObject {
  final ErrorToShow err;

  UpgradePlan(this.err);
}

class LoggedIn extends AuthState {
  final User user;
  final List<User> users;

  const LoggedIn(this.user, this.users);

  @override
  List<Object> get props => [user];
}

class LoggedOut extends AuthState {}

class AuthError extends AuthState {
  final ErrorToShow errorMsg;

  const AuthError(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}
