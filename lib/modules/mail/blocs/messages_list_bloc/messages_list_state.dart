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
  final Stream<List<Message>> Function(int page) stream;
  final MessagesFilter filter;
  final String searchTerm;
  final bool isSent;
  final String key;
  final String folder;

  SubscribedToMessages(
    this.stream,
    this.searchTerm,
    this.isSent,
    this.key,
    this.filter,
    this.folder,
  );

  @override
  List<Object> get props => [filter, isSent, searchTerm, key];
}

class MessagesRefreshed extends MessagesListState with AlwaysNonEqualObject {}

class MessagesDeleted extends MessagesListState with AlwaysNonEqualObject {}

// for both folders and messages
class MailError extends MessagesListState with AlwaysNonEqualObject {
  final String errorMsg;

  MailError(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}
