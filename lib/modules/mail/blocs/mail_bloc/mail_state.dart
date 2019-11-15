import 'package:aurora_mail/models/folder.dart';
import 'package:equatable/equatable.dart';

enum PostFolderLoadedAction { subscribeToMessages, stopMessagesRefresh }

abstract class MailState extends Equatable {
  const MailState();

  @override
  List<Object> get props => [];
}

class FoldersEmpty extends MailState {}

class FoldersLoading extends MailState {}

class FoldersLoaded extends MailState {
  final List<Folder> folders;
  final Folder selectedFolder;

  // shows only starred messages from inbox
  final bool isStarredFilterEnabled;

  // to fire messages events if needed
  final PostFolderLoadedAction postAction;

  const FoldersLoaded(
      this.folders, this.selectedFolder, this.isStarredFilterEnabled,
      [this.postAction]);

  @override
  List<Object> get props =>
      [folders, selectedFolder, postAction, isStarredFilterEnabled];
}

class FoldersError extends MailState {
  final String errorMsg;

  FoldersError(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}
