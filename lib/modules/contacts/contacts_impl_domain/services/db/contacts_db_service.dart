import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/contacts_db_service_impl.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/contacts_db_service_mock_impl.dart';

import '../../contacts_config.dart';

abstract class ContactsDbService {
  factory ContactsDbService(AppDatabase db) {
    if (TEST_MODE)
      return ContactsDbServiceMockImpl();
    else
      return ContactsDbServiceImpl(db);
  }

  Future<List<Contact>> getContacts(int userServerId, ContactsStorage storage);

  Future<void> addContacts(List<Contact> newContacts);

  Future<void> deleteContacts(List<String> uuids);

  Future<void> updateContacts(List<Contact> updatedContacts,
      {bool nullToAbsent = true});

  Future<List<ContactsStorage>> getStorages(int userServerId);

  Future<void> addStorages(List<ContactsStorage> newStorages, int userId);

  Future<void> updateStorages(List<ContactsStorage> updatedStorages, int userId,
      {bool nullToAbsent = true});

  Future<void> deleteStorages(List<int> sqliteIds);

  Future<List<ContactsGroup>> getGroups(int userServerId);

  Future<void> editGroups(List<ContactsGroup> newGroups);

  Future<void> addGroups(List<ContactsGroup> newGroups);

  Future<void> deleteGroups(List<String> uuids);
}
