import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

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
  final List<int> uids;
  final String folderRawName;

  const DeleteMessages({@required this.uids, @required this.folderRawName});

  @override
  List<Object> get props => [uids, folderRawName];
}
