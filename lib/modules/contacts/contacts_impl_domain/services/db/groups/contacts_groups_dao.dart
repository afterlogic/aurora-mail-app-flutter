import 'package:aurora_mail/database/app_database.dart';
import 'package:moor_flutter/moor_flutter.dart';

import 'contacts_groups_table.dart';

part 'contacts_groups_dao.g.dart';

@UseDao(tables: [ContactsGroups])
class ContactsGroupsDao extends DatabaseAccessor<AppDatabase>
    with _$ContactsGroupsDaoMixin {
  ContactsGroupsDao(AppDatabase db) : super(db);

  Future<List<ContactsGroupsTable>> getGroups(int userServerId) {
    return (select(contactsGroups)..where((c) => c.idUser.equals(userServerId)))
        .get();
  }

  Future<void> addGroups(List<ContactsGroupsTable> newGroups) {
    try {
      return into(contactsGroups).insertAll(newGroups);
    } catch (err) {
      print("insert contactsGroups error: $err");
      return null;
    }
  }

  Future<void> updateGroups(List<ContactsGroupsCompanion> updatedGroups) {
    return transaction(() async {
      for (final group in updatedGroups) {
        await (update(contactsGroups)
              ..where((g) => g.uuid.equals(group.uuid.value)))
            .write(group);
      }
    });
  }

  Future<void> deleteGroups(List<String> uuids) {
    return (delete(contactsGroups)..where((c) => isIn(c.uuid, uuids))).go();
  }
}
