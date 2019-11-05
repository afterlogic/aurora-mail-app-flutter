import 'package:aurora_mail/models/folder.dart';
import 'package:equatable/equatable.dart';

abstract class MailEvent extends Equatable {
  const MailEvent();

  @override
  List<Object> get props => [];
}

// try from DB, if empty - fetch from server
class FetchFolders extends MailEvent {}

// always from DB (e.g. to update needsInfoUpdate, which controls loading)
class UpdateFolders extends MailEvent {}

// always from server
class RefreshFolders extends MailEvent {}

class CheckFoldersMessagesChanges extends MailEvent {}

class SelectFolder extends MailEvent {
  final Folder folder;

  const SelectFolder(this.folder);

  @override
  List<Object> get props => [folder];
}

// gets messagesInfo for current folder
// and relevant folders info for all the folders, including current
class RefreshMessages extends MailEvent {}
