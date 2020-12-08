import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:equatable/equatable.dart';

abstract class TrustDeviceState extends Equatable {
  const TrustDeviceState();

  @override
  List<Object> get props => [];
}

class InitialState extends TrustDeviceState {}

class ProgressState extends TrustDeviceState {}

class ErrorState extends TrustDeviceState {
  final ErrorToShow errorMsg;

  ErrorState(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}

class CompleteState extends TrustDeviceState {
  CompleteState();
}
