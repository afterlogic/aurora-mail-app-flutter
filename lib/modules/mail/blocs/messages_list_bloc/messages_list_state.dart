import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/utils/always_non_equal_object.dart';
import 'package:equatable/equatable.dart';

enum MessagesFilter { starred, unread, none }

abstract class MessagesListState extends Equatable {
  const MessagesListState();

  @override
  List<Object> get props => null;
}

class MessagesEmpty extends MessagesListState {}

class SubscribedToMessages extends MessagesListState with AlwaysNonEqualObject {
  final Stream<List<Message>> stream;
  final MessagesFilter filter;
  final String searchTerm;
  final bool isSent;
  final String key;

  SubscribedToMessages(
    this.stream,
    this.searchTerm,
    this.isSent,
    this.key,
    this.filter,
  );

  @override
  List<Object> get props => [filter, isSent, searchTerm, key];
}

class MessagesRefreshed extends MessagesListState with AlwaysNonEqualObject {}

class MessagesDeleted extends MessagesListState with AlwaysNonEqualObject {}

class MessagesMoved extends MessagesListState with AlwaysNonEqualObject {}

// for both folders and messages
class MailError extends MessagesListState with AlwaysNonEqualObject {
  final String errorMsg;

  MailError(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}
