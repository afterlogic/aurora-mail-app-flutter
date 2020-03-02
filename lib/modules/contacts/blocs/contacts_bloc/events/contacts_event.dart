import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
import 'package:aurora_mail/utils/always_non_equal_object.dart';
import 'package:equatable/equatable.dart';

abstract class ContactsEvent extends Equatable {
  const ContactsEvent();

  @override
  List<Object> get props => [];
}

class GetContacts extends ContactsEvent implements AlwaysNonEqualObject {
  final bool updateOther;

  GetContacts([this.updateOther = false]);
}

// if none is selected returns all contacts
class SelectStorageGroup extends ContactsEvent {
  final ContactsStorage storage;
  final ContactsGroup group;

  const SelectStorageGroup({this.storage, this.group});

  @override
  List<Object> get props => [storage, group];
}

class SetAllVisibleContactsSelected extends ContactsEvent
    implements AlwaysNonEqualObject {}

class ReceivedContacts extends ContactsEvent {
  final List<Contact> contacts;

  const ReceivedContacts(this.contacts);

  @override
  List<Object> get props => [contacts];
}

class CreateContact extends ContactsEvent {
  final Contact contact;

  const CreateContact(this.contact);

  @override
  List<Object> get props => [contact];
}

class UpdateContact extends ContactsEvent {
  final Contact contact;

  const UpdateContact(this.contact);

  @override
  List<Object> get props => [contact];
}

class DeleteContacts extends ContactsEvent {
  final List<Contact> contacts;

  const DeleteContacts(this.contacts);

  @override
  List<Object> get props => [contacts];
}

class ShareContacts extends ContactsEvent {
  final List<Contact> contacts;

  const ShareContacts(this.contacts);

  @override
  List<Object> get props => [contacts];
}

class UnshareContacts extends ContactsEvent {
  final List<Contact> contacts;

  const UnshareContacts(this.contacts);

  @override
  List<Object> get props => [contacts];
}

class AddContactsToGroup extends ContactsEvent {
  final ContactsGroup group;
  final List<Contact> contacts;

  const AddContactsToGroup(this.group, this.contacts);

  @override
  List<Object> get props => [group, contacts];
}

class RemoveContactsFromGroup extends ContactsEvent {
  final ContactsGroup group;
  final List<Contact> contacts;

  const RemoveContactsFromGroup(this.group, this.contacts);

  @override
  List<Object> get props => [group, contacts];
}

class AddError extends ContactsEvent {
  final String error;

  const AddError(this.error);

  @override
  List<Object> get props => [error];
}
