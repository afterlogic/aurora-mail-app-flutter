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

class AddError extends ContactsEvent {
  final String error;

  const AddError(this.error);

  @override
  List<Object> get props => [error];
}
