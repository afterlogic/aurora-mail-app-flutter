import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/utils/always_non_equal_object.dart';
import 'package:equatable/equatable.dart';

abstract class MessagesListState extends Equatable {
  const MessagesListState();

  @override
  List<Object> get props => null;
}

class MessagesEmpty extends MessagesListState {}

class SubscribedToMessages extends MessagesListState {
  final Stream<List<Message>> messagesSub;
  // TODO VO: add isStarredMode

  const SubscribedToMessages(this.messagesSub);

  @override
  List<Object> get props => [messagesSub];
}

class MessagesRefreshed extends MessagesListState with AlwaysNonEqualObject {}

class MessagesDeleted extends MessagesListState with AlwaysNonEqualObject {}

// for both folders and messages
class MailError extends MessagesListState {
  final String errorMsg;

  const MailError(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}
