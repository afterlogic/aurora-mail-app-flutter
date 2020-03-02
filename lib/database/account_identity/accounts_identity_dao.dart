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

  Future<void> deleteIdentityByAccount(int idUser) {
    return (delete(accountIdentity)
          ..where((item) => item.idUser.equals(idUser)))
        .go();
  }
}
