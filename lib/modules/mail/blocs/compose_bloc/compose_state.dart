import 'package:equatable/equatable.dart';

abstract class ComposeState extends Equatable {
  const ComposeState();

  @override
  List<Object> get props => [];
}

class InitialComposeState extends ComposeState {}

class MessageSending extends ComposeState {}

class MessageSent extends ComposeState {}

class MessageSavedInDrafts extends ComposeState {
  final int draftUid;

  MessageSavedInDrafts(this.draftUid);

  @override
  List<Object> get props => [draftUid];
}

class ComposeError extends ComposeState {
  final String error;

  ComposeError(this.error);
}
