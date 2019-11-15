import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:equatable/equatable.dart';

abstract class MessagesListEvent extends Equatable {
  const MessagesListEvent();

  @override
  List<Object> get props => [];
}

class SubscribeToMessages extends MessagesListEvent {
  final Folder currentFolder;
  final bool isStarred;

  SubscribeToMessages(this.currentFolder, this.isStarred);

  @override
  List<Object> get props => [currentFolder, isStarred];
}

class StopMessagesRefresh extends MessagesListEvent {}

class DeleteMessages extends MessagesListEvent {
  final List<Message> messages;

  DeleteMessages(this.messages);

  @override
  List<Object> get props => [messages];
}
