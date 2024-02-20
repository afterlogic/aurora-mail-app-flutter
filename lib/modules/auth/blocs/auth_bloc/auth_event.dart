//@dart=2.9
import 'dart:async';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/utils/always_non_equal_object.dart';
import 'package:aurora_mail/utils/input_validation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => null;
}

class LogIn extends AuthEvent {
  final String email;
  final bool firstLogin;
  final String password;
  final String hostname;

  LogIn({
    @required String email,
    @required this.password,
    @required this.hostname,
    this.firstLogin,
  }) : email = formatEmail(email);

  @override
  List<Object> get props => [email, password, hostname];

  static String formatEmail(String email) {
    if (isEmailValid(email)) {
      return email.toLowerCase();
    } else {
      return email;
    }
  }
}

class UserLogIn extends AuthEvent with AlwaysNonEqualObject {
  final User user;
  final String login;
  final String password;
  final Completer completer;

  UserLogIn(this.user, this.completer, this.login, this.password);
}

class UserLogInFinish extends AuthEvent with AlwaysNonEqualObject {
  final User user;
  final Completer completer;

  UserLogInFinish(this.user, this.completer);
}

class InitUserAndAccounts extends AuthEvent with AlwaysNonEqualObject {
  final Completer completer;

  InitUserAndAccounts([this.completer]);

  @override
  List<Object> get props => [completer];
}

class UpdateAccounts extends AuthEvent with AlwaysNonEqualObject {
  final Completer completer;

  UpdateAccounts(this.completer);
}

class GetLastEmail extends AuthEvent {}

class SelectUser extends AuthEvent {
  final int userLocalId;
  final int accountLocalId;
  final Completer completer;

  const SelectUser(
    this.userLocalId, [
    this.completer,
    this.accountLocalId,
  ]);

  @override
  List<Object> get props => [userLocalId];
}

class SelectUserByEmail extends AuthEvent {
  final String email;
  final Completer completer;

  const SelectUserByEmail(this.email, [this.completer]);

  @override
  List<Object> get props => [email];
}

class DeleteUser extends AuthEvent {
  final User user;

  const DeleteUser(this.user);

  @override
  List<Object> get props => [user];
}

class InvalidateCurrentUserToken extends AuthEvent with AlwaysNonEqualObject {}

class ChangeAccount extends AuthEvent {
  final Account account;

  const ChangeAccount(this.account);

  @override
  List<Object> get props => [account];
}
