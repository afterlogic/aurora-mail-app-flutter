import "package:crypto_model/crypto_model.dart";

abstract class CryptoStorage {
  setOther(String id);

  Future<void> addPgpKey(PgpKey key);

  Future<void> addPgpKeys(List<PgpKey> keys);

  Future<PgpKey?> getPgpKey(
    String email,
    bool isPrivate, [
    bool fromContact = true,
  ]);

  Future<List<PgpKey>> getPgpKeys(bool isPrivate);

  Future<List<PgpKey>> getContactsPgpKeys();

  Future deletePgpKey(String name, String email, bool isPrivate);

  Future deleteAll();
}
