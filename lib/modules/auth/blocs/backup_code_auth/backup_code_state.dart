import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:equatable/equatable.dart';

abstract class BackupCodeState extends Equatable {
  const BackupCodeState();

  @override
  List<Object> get props => [];
}

class InitialState extends BackupCodeState {}

class ProgressState extends BackupCodeState {}

class ErrorState extends BackupCodeState {
  final ErrorToShow errorMsg;

  ErrorState(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}

class CompleteState extends BackupCodeState {
  final User user;

  CompleteState(this.user);

  @override
  List<Object> get props => [user];
}
