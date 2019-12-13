import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
import 'package:equatable/equatable.dart';

abstract class ContactsEvent extends Equatable {
  const ContactsEvent();

  @override
  List<Object> get props => [];
}

class GetContacts extends ContactsEvent {}

class SelectStorage extends ContactsEvent {
  final ContactsStorage storage;

  SelectStorage(this.storage);

  @override
  List<Object> get props => [storage];
}

class AddContacts extends ContactsEvent {
  final List<Contact> contacts;

  AddContacts(this.contacts);

  @override
  List<Object> get props => [contacts];
}

class AddStorages extends ContactsEvent {
  final List<ContactsStorage> storages;

  AddStorages(this.storages);

  @override
  List<Object> get props => [storages];
}

class SetSelectedStorage extends ContactsEvent {
  final int storageSqliteId;

  SetSelectedStorage(this.storageSqliteId);

  @override
  List<Object> get props => [storageSqliteId];
}

class SetCurrentlySyncingStorage extends ContactsEvent {
  final int storageSqliteId;

  SetCurrentlySyncingStorage(this.storageSqliteId);

  @override
  List<Object> get props => [storageSqliteId];
}

class AddError extends ContactsEvent {
  final dynamic error;

  AddError(this.error);

  @override
  List<Object> get props => [error];
}
