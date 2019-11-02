import 'package:equatable/equatable.dart';

abstract class ComposeEvent extends Equatable {
  const ComposeEvent();
  @override
  List<Object> get props => null;
}

class SendMessage extends ComposeEvent {}

class SaveToDrafts extends ComposeEvent {}
