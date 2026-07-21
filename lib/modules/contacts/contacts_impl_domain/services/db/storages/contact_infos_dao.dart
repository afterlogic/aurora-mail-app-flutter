import 'package:aurora_mail/database/app_database.dart';
import 'package:drift_sqflite/drift_sqflite.dart';
import 'package:drift/drift.dart';

import 'contact_infos_table.dart';

part 'contact_infos_dao.g.dart';

@DriftAccessor(tables: [ContactInfos])
class ContactInfosDao extends DatabaseAccessor<AppDatabase>
    with _$ContactInfosDaoMixin {
  ContactInfosDao(AppDatabase db) : super(db);

  Future<List<ContactInfoRow>> getForStorage(int userLocalId, String storage) {
    return (select(contactInfos)
          ..where((c) =>
              c.userLocalId.equals(userLocalId) & c.storage.equals(storage)))
        .get();
  }

  Future<Map<String, List<ContactInfoRow>>> getForStorages(
      int userLocalId, List<String> storageIds) async {
    if (storageIds.isEmpty) return {};

    final rows = await (select(contactInfos)
          ..where((c) =>
              c.userLocalId.equals(userLocalId) & c.storage.isIn(storageIds)))
        .get();

    final result = <String, List<ContactInfoRow>>{};
    for (final row in rows) {
      result.putIfAbsent(row.storage, () => []).add(row);
    }
    return result;
  }

  /// Overwrites the full set of contact info rows for [storage] with
  /// [items], mirroring how the previous JSON blob was always replaced
  /// wholesale on update.
  Future<void> replaceForStorage(
    int userLocalId,
    String storage,
    List<ContactInfosCompanion> items,
  ) {
    return transaction(() async {
      await (delete(contactInfos)
            ..where((c) =>
                c.userLocalId.equals(userLocalId) &
                c.storage.equals(storage)))
          .go();
      if (items.isNotEmpty) {
        await batch((b) => b.insertAll(contactInfos, items));
      }
    });
  }

  Future<void> deleteForStorages(int userLocalId, List<String> storageIds) {
    if (storageIds.isEmpty) return Future.value();
    return (delete(contactInfos)
          ..where((c) =>
              c.userLocalId.equals(userLocalId) & c.storage.isIn(storageIds)))
        .go();
  }

  Future<void> deleteForUser(int userLocalId) {
    return (delete(contactInfos)
          ..where((c) => c.userLocalId.equals(userLocalId)))
        .go();
  }
}
