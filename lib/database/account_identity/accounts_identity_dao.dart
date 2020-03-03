import 'package:aurora_mail/database/app_database.dart';
import 'package:moor_flutter/moor_flutter.dart';

import 'account_identity_table.dart';

part 'accounts_identity_dao.g.dart';

@UseDao(tables: [AccountIdentity])
class AccountIdentityDao extends DatabaseAccessor<AppDatabase>
    with _$AccountIdentityDaoMixin {
  AccountIdentityDao(AppDatabase db) : super(db);

  Future<void> setIdentity(List<AccountIdentityDb> newIdentity) {
    return batch((b) {
      return b.insertAll(
        accountIdentity,
        newIdentity,
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Future<void> deleteIdentityByUser(int idUser) {
    return (delete(accountIdentity)
          ..where((item) => item.idUser.equals(idUser)))
        .go();
  }

  Future<List<AccountIdentityDb>> getAccountByUserAndAccount(
    int idUser,
    int idAccount,
  ) {
    return (select(accountIdentity)
          ..where((item) => item.idUser.equals(idUser))
          ..where((item) => item.idAccount.equals(idAccount)))
        .get();
  }
}
