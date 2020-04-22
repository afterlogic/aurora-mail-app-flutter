import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/bloc.dart';
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
  final MessagesFilter filter;

  // to fire messages events if needed
  final PostFolderLoadedAction postAction;

  final isProgress;

  const FoldersLoaded(this.folders, this.selectedFolder, this.filter,
      [this.postAction, this.isProgress = false]);

  @override
  List<Object> get props =>
      [folders, selectedFolder, postAction, filter, isProgress];

  FoldersLoaded copyWith(
          {List<Folder> folders,
          Folder selectedFolder,
          MessagesFilter filter,
          PostFolderLoadedAction postAction,
          bool isProgress = false}) =>
      FoldersLoaded(
        folders ?? this.folders,
        selectedFolder ?? this.selectedFolder,
        filter ?? this.filter,
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

class EndRefreshMessages extends MailState {}
