//@dart=2.9
import 'dart:async';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/repository/search_util.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class MessagesListEvent extends Equatable {
  const MessagesListEvent();

  @override
  List<Object> get props => [];
}

class SubscribeToMessages extends MessagesListEvent {
  final Folder currentFolder;
  final MessagesFilter filter;
  final List<SearchParams> searchParams;
  final String searchText;

  const SubscribeToMessages(this.currentFolder, this.filter,
      [this.searchParams, this.searchText]);

  @override
  List<Object> get props =>
      [currentFolder.fullNameRaw, filter, searchParams.hashCode];
}

class StopMessagesRefresh extends MessagesListEvent {}

class DeleteMessages extends MessagesListEvent {
  final List<Message> messages;

  const DeleteMessages({@required this.messages});

  @override
  List<Object> get props => [messages];
}

class MoveMessages extends MessagesListEvent {
  final List<Message> messages;
  final FolderType toFolder;

  MoveMessages(this.messages, this.toFolder);

  @override
  List<Object> get props => [messages, toFolder];
}

class EmptyFolder extends MessagesListEvent {
  final String folder;

  EmptyFolder(this.folder);

  @override
  List<Object> get props => [folder];
}

class MoveToFolderMessages extends MessagesListEvent {
  final List<Message> messages;
  final Folder folder;
  final Completer completer;

  MoveToFolderMessages(this.messages, this.folder, [this.completer]);

  @override
  List<Object> get props => [messages, folder];
}
