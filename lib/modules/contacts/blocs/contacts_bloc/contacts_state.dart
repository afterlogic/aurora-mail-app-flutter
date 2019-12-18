import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
import 'package:equatable/equatable.dart';

class ContactsState extends Equatable {
  final List<ContactsStorage> storages;
  final int selectedStorage;
  final String selectedGroup;
  final List<Contact> contacts;
  final List<ContactsGroup> groups;
  final List<int> currentlySyncingStorages;
  final dynamic error;

  ContactsState({
    this.storages,
    this.selectedStorage,
    this.selectedGroup,
    this.contacts,
    this.groups,
    this.currentlySyncingStorages,
    this.error,
  });

  @override
  List<Object> get props => [
        storages,
        selectedStorage,
        selectedGroup,
        contacts,
        groups,
        currentlySyncingStorages,
        error,
      ];

  ContactsState copyWith({
    List<ContactsStorage> storages,
    int selectedStorage,
    String selectedGroup,
    List<Contact> contacts,
    List<ContactsGroup> groups,
    List<int> currentlySyncingStorage,
    String error,
  }) {
    return new ContactsState(
      storages: storages ?? this.storages,
      selectedStorage: selectedStorage ?? this.selectedStorage,
      selectedGroup: selectedGroup ?? this.selectedGroup,
      contacts: contacts ?? this.contacts,
      groups: groups ?? this.groups,
      currentlySyncingStorages: currentlySyncingStorage ?? this.currentlySyncingStorages,
      error: error,
    );
  }
}
