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
  ) async {
    // selects separated for handling case with large signature
    String? signature;

    final signatureQuery = selectOnly(accountIdentityTable)
      ..where(accountIdentityTable.idUser.equals(idUser))
      ..where(accountIdentityTable.idAccount.equals(idAccount))
      ..addColumns([accountIdentityTable.signature]);
    try {
      signature = await signatureQuery
          .map((a) => a.read(accountIdentityTable.signature))
          .getSingle();
    } catch (e, st) {
      print(e);
      print(st);
    } finally {
      final query = selectOnly(accountIdentityTable)
        ..where(accountIdentityTable.idUser.equals(idUser))
        ..where(accountIdentityTable.idAccount.equals(idAccount))
        ..addColumns([
          accountIdentityTable.entityId,
          accountIdentityTable.email,
          accountIdentityTable.friendlyName,
          accountIdentityTable.idUser,
          accountIdentityTable.idAccount,
          accountIdentityTable.isDefault,
          accountIdentityTable.useSignature,
        ]);
      return query.map(
        (a) {
          return AccountIdentity(
            entityId: a.read(accountIdentityTable.entityId),
            idUser: a.read(accountIdentityTable.idUser),
            email: a.read(accountIdentityTable.email),
            friendlyName: a.read(accountIdentityTable.friendlyName),
            useSignature: a.read(accountIdentityTable.useSignature),
            signature: signature ?? "",
            idAccount: a.read(accountIdentityTable.idAccount),
            isDefault: a.read(accountIdentityTable.isDefault),
          );
        },
      ).get();
    }
  }
}
