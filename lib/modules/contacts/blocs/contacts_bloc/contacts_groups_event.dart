import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';

import 'contacts_event.dart';

class SetSelectedGroup extends ContactsEvent {
  final String groupUuid;

  const SetSelectedGroup(this.groupUuid);

  @override
  List<Object> get props => [groupUuid];
}

class AddGroups extends ContactsEvent {
  final List<ContactsGroup> groups;

  const AddGroups(this.groups);

  @override
  List<Object> get props => [groups];
}

class AddGroup extends ContactsEvent {
  final ContactsGroup group;

  const AddGroup(this.group);

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