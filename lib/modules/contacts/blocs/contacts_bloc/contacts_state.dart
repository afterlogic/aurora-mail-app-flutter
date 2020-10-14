import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
import 'package:aurora_mail/utils/always_non_equal_object.dart';
import 'package:aurora_mail/utils/copy_with_value.dart';
import 'package:aurora_mail/utils/error_to_show.dart';

class ContactsState with AlwaysNonEqualObject {
  final List<ContactsStorage> storages;
  final String selectedStorage;
  final String selectedGroup;
  final bool showAllVisibleContacts;
  final List<Contact> contacts;
  final List<ContactsGroup> groups;
  final List<int> currentlySyncingStorages;
  final ErrorToShow error;
  final String key;

  ContactsState({
    this.storages,
    this.selectedStorage,
    this.selectedGroup,
    this.showAllVisibleContacts,
    this.contacts,
    this.groups,
    this.currentlySyncingStorages,
    this.error,
    this.key,
  });

  ContactsState copyWith({
    List<ContactsStorage> storages,
    CWVal<String> selectedStorage,
    CWVal<String> selectedGroup,
    bool showAllVisibleContacts,
    List<Contact> contacts,
    List<ContactsGroup> groups,
    List<int> currentlySyncingStorages,
    ErrorToShow error,
    String key,
  }) {
    return new ContactsState(
      storages: storages ?? this.storages,
      selectedStorage: CWVal.get(selectedStorage, this.selectedStorage),
      selectedGroup: CWVal.get(selectedGroup, this.selectedGroup),
      showAllVisibleContacts:
          showAllVisibleContacts ?? this.showAllVisibleContacts,
      contacts: contacts ?? this.contacts,
      groups: groups ?? this.groups,
      currentlySyncingStorages:
          currentlySyncingStorages ?? this.currentlySyncingStorages,
      error: error,
      key: key,
    );
  }
}
