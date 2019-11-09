import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class InitialAuthState extends AuthState {}

class InitializedUserAndAccounts extends AuthState {
  final bool needsLogin;

  const InitializedUserAndAccounts({@required this.needsLogin})
      : assert(needsLogin != null);

  @override
  List<Object> get props => [needsLogin];
}

class LoggingIn extends AuthState {}

class NeedsHost extends AuthState {}

class LoggedIn extends AuthState {}

class LoggedOut extends AuthState {}

class AuthError extends AuthState {
  final String error;

  AuthError(this.error);

  @override
  List<Object> get props => [error];
}
