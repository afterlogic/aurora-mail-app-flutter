import 'package:aurora_mail/modules/auth/repository/auth_api.dart';
import 'package:aurora_mail/utils/always_non_equal_object.dart';
import 'package:equatable/equatable.dart';

abstract class IosFidoAuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StartAuth extends IosFidoAuthEvent with AlwaysNonEqualObject {
  final bool nfc;

  StartAuth(this.nfc);
}

class SendToKey extends IosFidoAuthEvent with AlwaysNonEqualObject {
  final SecurityKeyBegin request;

  SendToKey(this.request);
}
