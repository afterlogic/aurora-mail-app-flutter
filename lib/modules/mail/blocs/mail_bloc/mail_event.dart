import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/settings/models/sync_period.dart';
import 'package:equatable/equatable.dart';

abstract class MailEvent extends Equatable {
  const MailEvent();

  @override
  List<Object> get props => null;
}

// try from DB, if empty - fetch from server
class FetchFolders extends MailEvent {
  final Period syncPeriod;

  const FetchFolders(this.syncPeriod);

  @override
  List<Object> get props => [syncPeriod];
}

// always from DB (e.g. to update needsInfoUpdate, which controls loading)
class UpdateFolders extends MailEvent {}

// always from server
class RefreshFolders extends MailEvent {
  final Period syncPeriod;

  const RefreshFolders(this.syncPeriod);

  @override
  List<Object> get props => [syncPeriod];
}

// gets messagesInfo for current folder
// and relevant folders info for all the folders, including current
class RefreshMessages extends MailEvent {
  final Period syncPeriod;

  const RefreshMessages(this.syncPeriod);

  @override
  List<Object> get props => [syncPeriod];
}

class CheckFoldersMessagesChanges extends MailEvent {
  final Period syncPeriod;

  const CheckFoldersMessagesChanges(this.syncPeriod);

  @override
  List<Object> get props => [syncPeriod];
}

class SelectFolder extends MailEvent {
  final Folder folder;
  final Period syncPeriod;

  const SelectFolder(this.folder, this.syncPeriod);

  @override
  List<Object> get props => [folder, syncPeriod];
}

class SetSeen extends MailEvent {
  final List<int> uids;
  final Period syncPeriod;

  const SetSeen(this.uids, this.syncPeriod);

  @override
  List<Object> get props => [uids, syncPeriod];
}
