import 'package:aurora_mail/database/app_database.dart';
import 'package:moor_flutter/moor_flutter.dart';

import 'contacts_table.dart';

part 'contacts_dao.g.dart';

@UseDao(tables: [Contacts])
class ContactsDao extends DatabaseAccessor<AppDatabase>
    with _$ContactsDaoMixin {
  ContactsDao(AppDatabase db) : super(db);

  Future<void> addContacts(List<ContactsTable> newContacts) {
    try {
      return batch((b) => b.insertAll(contacts, newContacts));
    } catch (err) {
      print("insert contacts error: $err");
      return null;
    }
  }

  Future<void> deleteContacts(List<String> uuids) {
    return (delete(contacts)..where((c) => c.uuid.isIn(uuids))).go();
  }

  Future<List<ContactsTable>> getContacts(int userServerId, String storage) {
    return (
        select(contacts)
          ..where((c) => c.idUser.equals(userServerId))
          ..where((c) => c.storage.equals(storage))
          ..orderBy([(m) => OrderingTerm(expression: m.fullName)])
    ).get();
  }

  Stream<List<ContactsTable>> watchContacts(int userServerId, String storage) {
    return (
        select(contacts)
          ..where((c) => c.idUser.equals(userServerId))
          ..where((c) => c.storage.equals(storage))
          ..orderBy([(m) => OrderingTerm(expression: m.fullName)])
    ).watch();
  }

  Future<void> updateContacts(List<ContactsCompanion> updatedContacts) {
    try {
      return transaction(() async {
        for (final contact in updatedContacts) {
          await (update(contacts)
            ..where((c) => c.uuid.equals(contact.uuid.value)))
              .write(contact);
        }
      });
    } catch (err) {
      return null;
    }
  }
}
