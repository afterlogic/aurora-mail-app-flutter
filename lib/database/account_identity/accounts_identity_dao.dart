import 'package:aurora_mail/database/app_database.dart';
import 'package:drift_sqflite/drift_sqflite.dart';
import 'package:drift/drift.dart';

import 'account_identity_table.dart';

part 'accounts_identity_dao.g.dart';

@DriftAccessor(tables: [AccountIdentityTable])
class AccountIdentityDao extends DatabaseAccessor<AppDatabase>
    with _$AccountIdentityDaoMixin {
  AccountIdentityDao(AppDatabase db) : super(db);

  Future<void> set(List<AccountIdentity> newIdentity) {
    return batch((b) {
      return b.insertAll(
        accountIdentityTable,
        newIdentity,
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Future<void> deleteByUser(int idUser) {
    return (delete(accountIdentityTable)
          ..where((item) => item.idUser.equals(idUser)))
        .go();
  }

  Future<List<AccountIdentity>> getByUserAndAccount(
    int idUser,
    int idAccount,
  ) {
    final statement = select(accountIdentityTable);
    statement.where((item) => item.idUser.equals(idUser));
    if (idAccount != null) {
      statement.where((item) => item.idAccount.equals(idAccount));
    }
    return statement.get();
  }
}
