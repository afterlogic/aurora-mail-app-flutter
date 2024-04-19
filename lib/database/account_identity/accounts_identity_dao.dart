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
    int? idAccount,
  ) async {
    // selects separated for handling case with large signature

    final accountIdentityIdsQuery = selectOnly(accountIdentityTable)
      ..where(accountIdentityTable.idUser.equals(idUser));
    if (idAccount != null) {
      accountIdentityIdsQuery
          .where(accountIdentityTable.idAccount.equals(idAccount));
    }
    accountIdentityIdsQuery.addColumns([accountIdentityTable.entityId]);

    final Set<int?> accountIdentityEntityIds = (await accountIdentityIdsQuery
            .map((a) => a.read(accountIdentityTable.entityId))
            .get())
        .toSet();

    final Map<int, String?> signatureMap = {};

    for (int? entityId in accountIdentityEntityIds) {
      if (entityId == null) continue;
      final signatureQuery = selectOnly(accountIdentityTable)
        ..where(accountIdentityTable.entityId.equals(entityId))
        ..addColumns([accountIdentityTable.signature]);
      try {
        final signatureLocalIdPair = await signatureQuery
            .map((a) => {entityId: a.read(accountIdentityTable.signature)})
            .getSingle();
        signatureMap.addAll(signatureLocalIdPair);
      } catch (e, st) {
        print(e);
        print(st);
        continue;
      }
    }

    final query = selectOnly(accountIdentityTable)
      ..where(accountIdentityTable.entityId.isIn(accountIdentityEntityIds));
    query.addColumns([
      accountIdentityTable.entityId,
      accountIdentityTable.email,
      accountIdentityTable.friendlyName,
      accountIdentityTable.idUser,
      accountIdentityTable.idAccount,
      accountIdentityTable.isDefault,
      accountIdentityTable.useSignature,
    ]);
    return query.map(
      (row) {
        final entityId = row.read(accountIdentityTable.entityId);

        return AccountIdentity(
          entityId: entityId!,
          idUser: row.read(accountIdentityTable.idUser)!,
          email: row.read(accountIdentityTable.email)!,
          friendlyName: row.read(accountIdentityTable.friendlyName)!,
          useSignature: row.read(accountIdentityTable.useSignature)!,
          signature: signatureMap.containsKey(entityId) ? signatureMap[entityId] ?? "" : "",
          idAccount: row.read(accountIdentityTable.idAccount)!,
          isDefault: row.read(accountIdentityTable.isDefault)!,
        );
      },
    ).get();
  }
}
