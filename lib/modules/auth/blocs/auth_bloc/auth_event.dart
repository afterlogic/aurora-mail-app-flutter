import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/utils/always_non_equal_object.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => null;
}

class LogIn extends AuthEvent {
  final String email;
  final String password;
  final String hostname;

  LogIn({
    @required this.email,
    @required this.password,
    @required this.hostname,
  });

  @override
  List<Object> get props => [email, password, hostname];
}

class InitUserAndAccounts extends AuthEvent {}

class GetLastEmail extends AuthEvent {}

class SelectUser extends AuthEvent {
  final int userLocalId;

  const SelectUser(this.userLocalId);

  @override
  List<Object> get props => [userLocalId];
}

class DeleteUser extends AuthEvent {
  final int userLocalId;

  const DeleteUser(this.userLocalId);

  @override
  List<Object> get props => [userLocalId];
}

class InvalidateCurrentUserToken extends AuthEvent implements AlwaysNonEqualObject {}
