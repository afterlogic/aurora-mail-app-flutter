import 'package:aurora_mail/models/folder.dart';
import 'package:equatable/equatable.dart';

abstract class MessagesListEvent extends Equatable {
  const MessagesListEvent();

  @override
  List<Object> get props => [];
}

class SubscribeToMessages extends MessagesListEvent {
  final Folder currentFolder;

  SubscribeToMessages(this.currentFolder);

  @override
  List<Object> get props => [currentFolder];
}

class StopMessagesRefresh extends MessagesListEvent {}

class DeleteMessages extends MessagesListEvent {
  final List<int> uids;
  final Folder folder;

  DeleteMessages(this.uids, this.folder);

  @override
  List<Object> get props => [uids, folder];
}
