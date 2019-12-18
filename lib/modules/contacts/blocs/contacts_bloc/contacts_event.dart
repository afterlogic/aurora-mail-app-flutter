import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
import 'package:equatable/equatable.dart';

abstract class ContactsEvent extends Equatable {
  const ContactsEvent();

  @override
  List<Object> get props => [];
}

class GetContacts extends ContactsEvent {}

class SelectStorageGroup extends ContactsEvent {
  final ContactsStorage storage;
  final ContactsGroup group;

  const SelectStorageGroup({this.storage, this.group}) : assert(storage != null || group != null);

  @override
  List<Object> get props => [storage, group];
}

class AddContacts extends ContactsEvent {
  final List<Contact> contacts;

  const AddContacts(this.contacts);

  @override
  List<Object> get props => [contacts];
}

class AddStorages extends ContactsEvent {
  final List<ContactsStorage> storages;

  const AddStorages(this.storages);

  @override
  List<Object> get props => [storages];
}

class AddGroups extends ContactsEvent {
  final List<ContactsGroup> groups;

  const AddGroups(this.groups);

  @override
  List<Object> get props => [groups];
}

class SetSelectedStorage extends ContactsEvent {
  final int storageSqliteId;

  const SetSelectedStorage(this.storageSqliteId);

  @override
  List<Object> get props => [storageSqliteId];
}

class SetSelectedGroup extends ContactsEvent {
  final String groupUuid;

  const SetSelectedGroup(this.groupUuid);

  @override
  List<Object> get props => [groupUuid];
}

class SetCurrentlySyncingStorages extends ContactsEvent {
  final List<int> storageSqliteIds;

  const SetCurrentlySyncingStorages(this.storageSqliteIds);

  @override
  List<Object> get props => [storageSqliteIds];
}

class AddError extends ContactsEvent {
  final dynamic error;

  const AddError(this.error);

  @override
  List<Object> get props => [error];
}
