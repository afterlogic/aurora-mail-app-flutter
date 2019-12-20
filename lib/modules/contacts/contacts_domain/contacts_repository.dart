import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/contacts_repository_impl.dart';
import 'package:flutter/widgets.dart';

abstract class ContactsRepository {
  factory ContactsRepository({
    @required String apiUrl,
    @required String token,
    @required int userServerId,
    @required AppDatabase appDB,
  }) =>
      ContactsRepositoryImpl(
          appDB: appDB,
          apiUrl: apiUrl,
          userServerId: userServerId,
          token: token);

  Stream<List<int>> get currentlySyncingStorage;

  Stream<List<Contact>> watchContactsFromStorage(ContactsStorage storage);

  Stream<List<Contact>> watchContactsFromGroup(ContactsGroup group);

  Future<void> addContact(Contact contact);

  Future<void> editContact(Contact contact);

  Future<void> deleteContacts(List<Contact> contact);

  Future<void> addContactsToGroup(ContactsGroup group, List<Contact> contacts);

  Future<void> removeContactsFromGroup(ContactsGroup group, List<Contact> contacts);

  Stream<List<ContactsStorage>> watchContactsStorages();

  Stream<List<ContactsGroup>> watchContactsGroups();

  Future<void> addGroup(ContactsGroup group);

  Future<bool> editGroup(ContactsGroup group);

  Future<bool> deleteGroup(ContactsGroup group);

  void dispose();
}
