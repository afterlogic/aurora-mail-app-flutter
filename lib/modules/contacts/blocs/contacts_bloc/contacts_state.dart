import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
import 'package:equatable/equatable.dart';

class ContactsState extends Equatable {
  final List<ContactsStorage> storages;
  final List<Contact> contacts;
  final List<ContactsGroup> groups;
  final int currentlySyncingStorage;
  final String error;

  ContactsState({
    this.storages,
    this.contacts,
    this.groups,
    this.currentlySyncingStorage,
    this.error = "",
  });

  @override
  List<Object> get props => [
        storages,
        contacts,
        groups,
        currentlySyncingStorage,
        error,
      ];

  ContactsState copyWith({
    List<ContactsStorage> storages,
    List<Contact> contacts,
    List<ContactsGroup> groups,
    int currentlySyncingStorage,
    String error,
  }) {
    return new ContactsState(
      storages: storages ?? this.storages,
      contacts: contacts ?? this.contacts,
      groups: groups ?? this.groups,
      currentlySyncingStorage: currentlySyncingStorage ?? this.currentlySyncingStorage,
      error: error ?? this.error,
    );
  }
}
