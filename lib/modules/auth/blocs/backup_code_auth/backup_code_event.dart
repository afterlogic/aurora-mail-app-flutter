//@dart=2.9
import 'package:aurora_mail/utils/always_non_equal_object.dart';
import 'package:equatable/equatable.dart';

abstract class BackupCodeEvent extends Equatable {
  const BackupCodeEvent();

  @override
  List<Object> get props => null;
}

class Verify extends BackupCodeEvent with AlwaysNonEqualObject {
  final String pin;
  final String host;
  final String login;
  final String pass;

  Verify(this.pin, this.host, this.login, this.pass);

  @override
  List<Object> get props => [pin];
}
