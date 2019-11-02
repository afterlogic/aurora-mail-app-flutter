import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:equatable/equatable.dart';

abstract class MailState extends Equatable {
  const MailState();

  @override
  List<Object> get props => null;
}

class FoldersEmpty extends MailState {}

// used when there are no folders yet
class FoldersLoading extends MailState {}

class FoldersLoaded extends MailState {
  final List<Folder> folders;
  final Folder selectedFolder;

  const FoldersLoaded(this.folders, this.selectedFolder);

  @override
  List<Object> get props => [folders];
}

class SubscribedToMessages extends MailState {
  final Stream<List<Message>> messagesSub;

  const SubscribedToMessages(this.messagesSub);

  @override
  List<Object> get props => [messagesSub];
}

// for both folders and messages
class MailError extends MailState {
  final String error;

  const MailError(this.error);

  @override
  List<Object> get props => [error];
}
