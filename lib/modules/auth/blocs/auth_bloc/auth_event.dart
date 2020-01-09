import 'package:aurora_mail/database/app_database.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => null;
}

class InitUserAndAccounts extends AuthEvent {}

class GetLastEmail extends AuthEvent {}

// usually after settings change
class UpdateUser extends AuthEvent {
  final User updatedUser;

  UpdateUser(this.updatedUser);

  @override
  List<Object> get props => [updatedUser];
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

class LogOut extends AuthEvent {}
