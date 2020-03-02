import 'package:aurora_mail/utils/always_non_equal_object.dart';
import 'package:equatable/equatable.dart';

abstract class TwoFactorEvent extends Equatable {
  const TwoFactorEvent();

  @override
  List<Object> get props => null;
}

class Verify extends TwoFactorEvent with AlwaysNonEqualObject {
  final String pin;
  final String host;
  final String login;
  final String pass;

  Verify(this.pin, this.host, this.login, this.pass);

  @override
  List<Object> get props => [pin];
}
