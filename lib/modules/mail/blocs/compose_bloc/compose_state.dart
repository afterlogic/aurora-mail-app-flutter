import 'package:equatable/equatable.dart';

abstract class ComposeState extends Equatable {
  const ComposeState();
  @override
  List<Object> get props => [];
}

class InitialComposeState extends ComposeState {}

class MessageSending extends ComposeState {}

class MessageSent extends ComposeState {}
