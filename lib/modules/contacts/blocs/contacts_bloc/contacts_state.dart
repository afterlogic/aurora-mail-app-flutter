import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
import 'package:aurora_mail/utils/always_non_equal_object.dart';

class ContactsState with AlwaysNonEqualObject {
  final List<ContactsStorage> storages;
  final int selectedStorage;
  final String selectedGroup;
  final bool showAllVisibleContacts;
  final List<Contact> contacts;
  final List<ContactsGroup> groups;
  final List<int> currentlySyncingStorages;
  final String error;

  ContactsState({
    this.storages,
    this.selectedStorage,
    this.selectedGroup,
    this.showAllVisibleContacts,
    this.contacts,
    this.groups,
    this.currentlySyncingStorages,
    this.error,
  });

//  @override
//  List<Object> get props => [
//        storages,
//        selectedStorage,
//        selectedGroup,
//        showAllVisibleContacts,
//        contacts,
//        groups,
//        currentlySyncingStorages,
//        error,
//      ];

  ContactsState copyWith({
    List<ContactsStorage> storages,
    int selectedStorage,
    String selectedGroup,
    bool showAllVisibleContacts,
    List<Contact> contacts,
    List<ContactsGroup> groups,
    List<int> currentlySyncingStorages,
    String error,
  }) {
    return new ContactsState(
      storages: storages ?? this.storages,
      selectedStorage: selectedStorage ?? this.selectedStorage,
      selectedGroup: selectedGroup ?? this.selectedGroup,
      showAllVisibleContacts: showAllVisibleContacts ?? this.showAllVisibleContacts,
      contacts: contacts ?? this.contacts,
      groups: groups ?? this.groups,
      currentlySyncingStorages: currentlySyncingStorages ?? this.currentlySyncingStorages,
      error: error,
    );
  }
}
