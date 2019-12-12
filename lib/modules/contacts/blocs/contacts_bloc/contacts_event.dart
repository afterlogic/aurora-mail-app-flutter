import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:equatable/equatable.dart';

abstract class ContactsEvent extends Equatable {
  const ContactsEvent();

  @override
  List<Object> get props => [];
}

class GetContacts extends ContactsEvent {}

class AddContacts extends ContactsEvent {
  final List<Contact> contacts;

  AddContacts(this.contacts);

  @override
  List<Object> get props => [contacts];
}

class AddStorages extends ContactsEvent {
  final List<Contact> storages;

  AddStorages(this.storages);

  @override
  List<Object> get props => [storages];
}

class SetCurrentlySyncingStorage extends ContactsEvent {
  final List<int> storageSqliteId;

  SetCurrentlySyncingStorage(this.storageSqliteId);

  @override
  List<Object> get props => [storageSqliteId];
}
