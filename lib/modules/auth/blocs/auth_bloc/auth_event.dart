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

class UserLogIn extends AuthEvent {
  final User user;

  UserLogIn(this.user);

  @override
  List<Object> get props => [user];
}

class InitUserAndAccounts extends AuthEvent {
  final Completer completer;

  InitUserAndAccounts([this.completer]);
  @override
  List<Object> get props => [completer];
}

class GetLastEmail extends AuthEvent {}

class SelectUser extends AuthEvent {
  final int userLocalId;
  final Completer completer;

  const SelectUser(this.userLocalId, [this.completer]);

  @override
  List<Object> get props => [userLocalId];
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
