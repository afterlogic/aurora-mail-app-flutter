import 'package:aurora_mail/database/app_database.dart';
import 'package:moor_flutter/moor_flutter.dart';

import 'contacts_storages_table.dart';

part 'contacts_storages_dao.g.dart';

@UseDao(tables: [ContactsStorages])
class ContactsStoragesDao extends DatabaseAccessor<AppDatabase>
    with _$ContactsStoragesDaoMixin {
  ContactsStoragesDao(AppDatabase db) : super(db);

  Future<List<ContactsStoragesTable>> getStorages(int userServerId) {
    return (select(contactsStorages)
          ..where((c) => c.idUser.equals(userServerId)))
        .get();
  }

  Future<void> addStorages(List<ContactsStoragesTable> newStorages) {
    try {
      return into(contactsStorages).insertAll(newStorages);
    } catch (err) {
      print("insert contactsStorages error: $err");
      return null;
    }
  }

  Future<void> updateStorages(List<ContactsStoragesCompanion> updatedStorages) {
    return transaction(() async {
      try {
        for (final storage in updatedStorages) {
          await (update(contactsStorages)
            ..where((s) => s.idUser.equals(storage.idUser.value))..where((s) =>
                s.serverId.equals(storage.serverId.value)))
              .write(storage);
        }
      } catch(err) {}
    });
  }

  Future<void> deleteStorages(List<int> sqliteIds) {
    return (delete(contactsStorages)..where((c) => isIn(c.sqliteId, sqliteIds)))
        .go();
  }
}
