//@dart=2.9
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/mail/repository/search_util.dart';
import 'package:aurora_mail/utils/always_non_equal_object.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
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
  final List<SearchParams> searchParams;
  final bool isSent;
  final String key;
  final String folder;

  SubscribedToMessages(
    this.stream,
    this.searchParams,
    this.isSent,
    this.key,
    this.filter,
    this.folder,
  );

  @override
  List<Object> get props => [filter, isSent, searchParams, key];
}

class MessagesRefreshed extends MessagesListState with AlwaysNonEqualObject {}

class MessagesDeleted extends MessagesListState with AlwaysNonEqualObject {}

class FolderCleared extends MessagesListState with AlwaysNonEqualObject {}

class MessagesMoved extends MessagesListState with AlwaysNonEqualObject {}

// for both folders and messages
class MailError extends MessagesListState with AlwaysNonEqualObject {
  final ErrorToShow errorMsg;

  MailError(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}
