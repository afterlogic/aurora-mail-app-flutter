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

  final isProgress;

  const FoldersLoaded(
      this.folders, this.selectedFolder, this.isStarredFilterEnabled,
      [this.postAction, this.isProgress = false]);

  @override
  List<Object> get props =>
      [folders, selectedFolder, postAction, isStarredFilterEnabled, isProgress];

  FoldersLoaded copyWith(
          {List<Folder> folders,
          Folder selectedFolder,
          bool isStarredFilterEnabled,
          PostFolderLoadedAction postAction,
          bool isProgress = false}) =>
      FoldersLoaded(
        folders ?? this.folders,
        selectedFolder ?? this.selectedFolder,
        isStarredFilterEnabled ?? this.isStarredFilterEnabled,
        postAction ?? this.postAction,
        isProgress ?? this.isProgress,
      );
}

class FoldersError extends MailState {
  final String errorMsg;

  FoldersError(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}
