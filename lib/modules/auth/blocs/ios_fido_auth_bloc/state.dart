import 'package:aurora_mail/utils/always_non_equal_object.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:equatable/equatable.dart';

abstract class IosFidoAuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitState extends IosFidoAuthState {}

class ErrorState extends IosFidoAuthState with AlwaysNonEqualObject {
  final ErrorToShow errorToShow;

  ErrorState(this.errorToShow);
}

class SendingBeginAuthRequestState extends IosFidoAuthState {}

class WaitKeyState extends IosFidoAuthState {}

class TouchKeyState extends IosFidoAuthState {}

class SendingFinishAuthRequestState extends IosFidoAuthState {}
