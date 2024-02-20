//@dart=2.9
import 'dart:async';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/bloc.dart';
import 'package:aurora_mail/utils/always_non_equal_object.dart';
import 'package:equatable/equatable.dart';

abstract class MailEvent extends Equatable {
  const MailEvent();

  @override
  List<Object> get props => null;
}

// try from DB, if empty - fetch from server
class FetchFolders extends MailEvent with AlwaysNonEqualObject {}

// always from DB (e.g. to update needsInfoUpdate, which controls loading)
class UpdateFolders extends MailEvent with AlwaysNonEqualObject {}

// always from server
class RefreshFolders extends MailEvent with AlwaysNonEqualObject {
  final bool updateOther;

  RefreshFolders([this.updateOther = false]);
}

// gets messagesInfo for current folder
// and relevant folders info for all the folders, including current
class RefreshMessages extends MailEvent with AlwaysNonEqualObject {
  final Completer completer;

  RefreshMessages(this.completer);
}

class CheckFoldersMessagesChanges extends MailEvent {}

class SelectFolder extends MailEvent {
  final Folder folder;
  final MessagesFilter filter;

  const SelectFolder(this.folder, {this.filter = MessagesFilter.none});

  @override
  List<Object> get props => [folder.fullNameRaw, filter];
}

class SelectFolderByName extends MailEvent {
  final String name;

  const SelectFolderByName(this.name);

  @override
  List<Object> get props => [name];
}

class SetSeen extends MailEvent {
  final List<Message> messages;
  final bool isSeen;

  const SetSeen(this.messages, this.isSeen);

  @override
  List<Object> get props => [messages, isSeen];
}

class SetStarred extends MailEvent {
  final List<Message> messages;
  final bool isStarred;

  const SetStarred(this.messages, this.isStarred);

  @override
  List<Object> get props => [messages, isStarred];
}
