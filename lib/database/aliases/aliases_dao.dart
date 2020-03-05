import 'package:aurora_mail/database/app_database.dart';
import 'package:moor_flutter/moor_flutter.dart';

import 'aliases_table.dart';

part 'aliases_dao.g.dart';

@UseDao(tables: [AliasesTable])
class AliasesDao extends DatabaseAccessor<AppDatabase> with _$AliasesDaoMixin {
  AliasesDao(AppDatabase db) : super(db);

  Future<void> set(List<Aliases> newAliases) {
    return batch((b) {
      return b.insertAll(
        aliasesTable,
        newAliases,
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Future<void> deleteByUser(int idUser) {
    return (delete(aliasesTable)..where((item) => item.idUser.equals(idUser)))
        .go();
  }

  Future<List<Aliases>> getByUserAndAccount(
    int idUser,
    int idAccount,
  ) {
    final statement = select(aliasesTable);
    statement.where((item) => item.idUser.equals(idUser));
    if (idAccount != null) {
      statement.where((item) => item.idAccount.equals(idAccount));
    }
    return statement.get();
  }
}
