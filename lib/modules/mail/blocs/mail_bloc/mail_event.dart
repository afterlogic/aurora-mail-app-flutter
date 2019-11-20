import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/utils/always_non_equal_object.dart';
import 'package:equatable/equatable.dart';

abstract class MailEvent extends Equatable {
  const MailEvent();

  @override
  List<Object> get props => null;
}

// try from DB, if empty - fetch from server
class FetchFolders extends MailEvent {}

// always from DB (e.g. to update needsInfoUpdate, which controls loading)
class UpdateFolders extends MailEvent {}

// always from server
class RefreshFolders extends MailEvent {}

// gets messagesInfo for current folder
// and relevant folders info for all the folders, including current
class RefreshMessages extends MailEvent with AlwaysNonEqualObject {}

class CheckFoldersMessagesChanges extends MailEvent {}

class SelectFolder extends MailEvent {
  final Folder folder;
  final bool isStarredFolder;

  const SelectFolder(this.folder, {this.isStarredFolder = false});

  @override
  List<Object> get props => [folder, isStarredFolder];
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
