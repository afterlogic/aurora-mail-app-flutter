import 'package:aurora_mail/utils/always_non_equal_object.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NotificationsEvent extends Equatable {
  @override
  List<Object> get props => null;
}

class InitToken extends NotificationsEvent with AlwaysNonEqualObject {}

class SendToken extends NotificationsEvent with AlwaysNonEqualObject {}
