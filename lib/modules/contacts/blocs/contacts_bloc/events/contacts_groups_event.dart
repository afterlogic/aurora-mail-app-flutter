import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';

import 'contacts_event.dart';

class SetGroupSelected extends ContactsEvent {
  final String groupUuid;

  const SetGroupSelected(this.groupUuid);

  @override
  List<Object> get props => [groupUuid];
}

class ReceivedGroups extends ContactsEvent {
  final List<ContactsGroup> groups;

  const ReceivedGroups(this.groups);

  @override
  List<Object> get props => [groups];
}

class CreateGroup extends ContactsEvent {
  final ContactsGroup group;

  const CreateGroup(this.group);

  @override
  List<Object> get props => [group];
}

class UpdateGroup extends ContactsEvent {
  final ContactsGroup group;

  const UpdateGroup(this.group);

  @override
  List<Object> get props => [group];
}

class DeleteGroup extends ContactsEvent {
  final ContactsGroup group;

  const DeleteGroup(this.group);

  @override
  List<Object> get props => [group];
}