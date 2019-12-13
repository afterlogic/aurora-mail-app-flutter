import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
import 'package:equatable/equatable.dart';

class ContactsState extends Equatable {
  final List<ContactsStorage> storages;
  final int selectedStorage;
  final List<Contact> contacts;
  final List<ContactsGroup> groups;
  final int currentlySyncingStorage;
  final dynamic error;

  ContactsState({
    this.storages,
    this.selectedStorage,
    this.contacts,
    this.groups,
    this.currentlySyncingStorage,
    this.error,
  });

  @override
  List<Object> get props => [
        storages,
    selectedStorage,
        contacts,
        groups,
        currentlySyncingStorage,
        error,
      ];

  ContactsState copyWith({
    List<ContactsStorage> storages,
    int selectedStorage,
    List<Contact> contacts,
    List<ContactsGroup> groups,
    int currentlySyncingStorage,
    String error,
  }) {
    return new ContactsState(
      storages: storages ?? this.storages,
      selectedStorage: selectedStorage ?? this.selectedStorage,
      contacts: contacts ?? this.contacts,
      groups: groups ?? this.groups,
      currentlySyncingStorage: currentlySyncingStorage ?? this.currentlySyncingStorage,
      error: error,
    );
  }
}
