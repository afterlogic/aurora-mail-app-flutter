import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
import 'package:equatable/equatable.dart';

class ContactsState extends Equatable {
  final List<ContactsStorage> storages;
  final List<Contact> contacts;
  final List<ContactsGroup> groups;
  final bool storagesLoading;
  final bool contactsLoading;
  final bool groupsLoading;
  final String error;

  ContactsState({
    this.storages,
    this.contacts,
    this.groups,
    this.storagesLoading = true,
    this.contactsLoading = true,
    this.groupsLoading = true,
    this.error,
  });

  @override
  List<Object> get props => [
        storages,
        contacts,
        groups,
        storagesLoading,
        contactsLoading,
        groupsLoading,
        error,
      ];

  ContactsState copyWith({
    List<ContactsStorage> storages,
    List<Contact> contacts,
    List<ContactsGroup> groups,
    bool storagesLoading,
    bool contactsLoading,
    bool groupsLoading,
    String error,
  }) {
    return new ContactsState(
      storages: storages ?? this.storages,
      contacts: contacts ?? this.contacts,
      groups: groups ?? this.groups,
      storagesLoading: storagesLoading ?? this.storagesLoading,
      contactsLoading: contactsLoading ?? this.contactsLoading,
      groupsLoading: groupsLoading ?? this.groupsLoading,
      error: error ?? this.error,
    );
  }
}
