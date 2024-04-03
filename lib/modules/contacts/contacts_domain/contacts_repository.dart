import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/contacts_repository_impl.dart';
import 'package:flutter/widgets.dart';

abstract class ContactsRepository {
  factory ContactsRepository({
    required User user,
    required AppDatabase appDB,
  }) =>
      ContactsRepositoryImpl(
        appDB: appDB,
        user: user,
      );

  Stream<List<ContactsStorage>> get contactsStorages;

  Stream<List<ContactsGroup>> get contactsGroups;

  Stream<List<int>> get syncingStorages;

  Future<List<Contact>> getAllContacts();

  Future<List<Contact>> getContacts({
    List<String> storages,
    String groupUuid,
    String pattern,
  });

  Stream<List<Contact>> watchAllContacts(String search);

  Stream<List<Contact>> watchContactsFromStorage(String storage, String search);

  Stream<List<Contact>> watchContactsFromGroup(String group, String search);

  Future<void> refreshStorages();

  Future<void> refreshGroups();

  Future<Contact> addContact(Contact contact);

  Future<void> editContact(Contact contact);

  Future<void> addKeyToContacts(List<Contact> contacts);

  Future<void> deleteContacts(List<Contact> contact);

  Future<void> shareContacts(List<Contact> contact);

  Future<void> unshareContacts(List<Contact> contact);

  Future<void> addContactsToGroup(ContactsGroup group, List<Contact> contacts);

  Future<void> removeContactsFromGroup(
      ContactsGroup group, List<Contact> contacts);

  Future<List<Contact>> getSuggestionContacts(String pattern);

  Future<ContactsGroup> addGroup(ContactsGroup group);

  Future<bool> editGroup(ContactsGroup group);

  Future<bool> deleteGroup(ContactsGroup group);

  void dispose();

  Future<Contact?> getContactWithPgpKey(String mail);

  Future<Contact?> getContactByEmail(String mail);

  Future<Contact> getContactById(int entityId);

  Future deleteContactKey(String mail);

  Future importVcf(String content);
}
