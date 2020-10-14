import 'dart:async';

import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
import 'package:aurora_mail/modules/contacts/screens/contact_edit/dialog/confirm_edit_dialog.dart';
import 'package:aurora_mail/utils/always_non_equal_object.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:equatable/equatable.dart';

abstract class ContactsEvent extends Equatable {
  const ContactsEvent();

  @override
  List<Object> get props => [];
}

class SearchContacts extends ContactsEvent with AlwaysNonEqualObject {
  final String search;

  SearchContacts([this.search]);
}

class GetContacts extends ContactsEvent with AlwaysNonEqualObject {
  final Completer completer;

  GetContacts({this.completer});
}

// if none is selected returns all contacts
class SelectStorageGroup extends ContactsEvent {
  final String storageId;
  final String groupId;

  SelectStorageGroup({ContactsStorage storage, ContactsGroup group})
      : storageId = storage?.id,
        groupId = group?.uuid;

  SelectStorageGroup.raw({this.storageId, this.groupId});

  @override
  List<Object> get props => [storageId, groupId];
}

class SetAllVisibleContactsSelected extends ContactsEvent
    with AlwaysNonEqualObject {}

class ReceivedContacts extends ContactsEvent {
  final List<Contact> contacts;

  const ReceivedContacts(this.contacts);

  @override
  List<Object> get props => [contacts];
}

class CreateContact extends ContactsEvent {
  final Contact contact;
  final Completer completer;

  const CreateContact(this.contact, {this.completer});

  @override
  List<Object> get props => [contact];
}

class UpdateContact extends ContactsEvent {
  final Contact contact;
  final FreeKeyAction freeKey;
  final bool updateKey;

  const UpdateContact(this.contact, this.freeKey, this.updateKey);

  @override
  List<Object> get props => [contact, updateKey, freeKey];
}

class ReImport extends ContactsEvent {
  final String key;

  const ReImport(this.key);

  @override
  List<Object> get props => [key];
}

class ImportVcf extends ContactsEvent with AlwaysNonEqualObject {
  final String content;
  final Completer completer;

  const ImportVcf(this.content, this.completer);
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
  final ErrorToShow error;

  const AddError(this.error);

  @override
  List<Object> get props => [error];
}
