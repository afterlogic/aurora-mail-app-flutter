import 'dart:async';

import 'package:aurora_mail/utils/always_non_equal_object.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:equatable/equatable.dart';

abstract class FidoAuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitState extends FidoAuthState {}

class ErrorState extends FidoAuthState with AlwaysNonEqualObject {
  final ErrorToShow errorToShow;

  ErrorState(this.errorToShow);
}

class SendingBeginAuthRequestState extends FidoAuthState {}

class WaitWebView extends FidoAuthState {}

class WaitKeyState extends FidoAuthState {}

class TouchKeyState extends FidoAuthState {}

class SendingFinishAuthRequestState extends FidoAuthState {
  final Completer waitSheet;

  SendingFinishAuthRequestState(this.waitSheet);
}
