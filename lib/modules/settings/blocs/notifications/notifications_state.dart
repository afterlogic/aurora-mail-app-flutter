import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NotificationsState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitState extends NotificationsState {
  final bool state;

  InitState(this.state);
}

class ProgressState extends NotificationsState {}
