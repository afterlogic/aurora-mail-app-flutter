//@dart=2.9
import 'package:aurora_mail/database/app_database.dart';
import 'package:drift_sqflite/drift_sqflite.dart';
import 'package:drift/drift.dart';

import 'contacts_storages_table.dart';

part 'contacts_storages_dao.g.dart';

@DriftAccessor(tables: [ContactsStorages])
class ContactsStoragesDao extends DatabaseAccessor<AppDatabase>
    with _$ContactsStoragesDaoMixin {
  ContactsStoragesDao(AppDatabase db) : super(db);

  Future<List<ContactsStoragesTable>> getStorages(int userLocalId) {
    return (select(contactsStorages)
          ..where((c) => c.userLocalId.equals(userLocalId)))
        .get();
  }

  Future<void> addStorages(List<ContactsStoragesTable> newStorages) {
    try {
      return batch((b) => b.insertAll(
            contactsStorages,
            newStorages,
          ));
    } catch (err) {
      print("addStorages error: $err");
      return null;
    }
  }

  Future<void> updateStorages(List<ContactsStoragesCompanion> updatedStorages) {
    return transaction(() async {
      try {
        for (final storage in updatedStorages) {
          await (update(contactsStorages)
                ..where((s) => s.idUser.equals(storage.idUser.value))
                ..where((s) => s.serverId.equals(storage.serverId.value)))
              .write(storage);
        }
      } catch (err) {
        print("updateStorages error: $err");
      }
    });
  }

  Future<void> deleteStorages(List<int> sqliteIds) {
    return (delete(contactsStorages)..where((c) => c.sqliteId.isIn(sqliteIds)))
        .go();
  }

  Future<void> deleteStoragesOfUser(int userLocalId) {
    return (delete(contactsStorages)
          ..where((c) => c.userLocalId.equals(userLocalId)))
        .go();
  }
}
