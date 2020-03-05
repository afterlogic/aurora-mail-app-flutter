import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/pgp/pgp_key_dao.dart';
import "package:crypto_model/crypto_model.dart";
import 'package:crypto_storage/crypto_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CryptoStorageImpl extends CryptoStorage {
  final FlutterSecureStorage _secureStorage;
  final PgpKeyDao _keyDao;
  String _other;

  CryptoStorageImpl(this._secureStorage, this._keyDao);

  setOther(String id) {
    _other = id;
    _keyDao.setOther(id);
  }

  Future<void> addPgpKey(PgpKey key) async {
    return _keyDao.addPgpKey(await _toDb(key));
  }

  Future<void> addPgpKeys(List<PgpKey> keys) async {
    final localPgpKeys = <LocalPgpKey>[];
    for (var key in keys) {
      localPgpKeys.add(await _toDb(key));
    }

    return _keyDao.addPgpKeys(localPgpKeys);
  }

  Future<PgpKey> getPgpKey(String email, bool isPrivate) async {
    final localKey = await _keyDao.getPgpKey(email, isPrivate);
    return _fromDb(localKey);
  }

  Future<List<PgpKey>> getPgpKeys(bool isPrivate) {
    return _keyDao.getPgpKeys(isPrivate).then((list) async {
      final out = <PgpKey>[];
      for (var item in list) {
        out.add(await _fromDb(item));
      }
      return out;
    });
  }

  Future<int> deletePgpKey(String name, String email, bool isPrivate) async {
    await _delete(name, email, isPrivate);
    return _keyDao.deletePgpKey(_id(name, email, isPrivate));
  }

  Future<int> deleteAll() async {
    final keys = await _keyDao.getPgpKeys(false);
    keys.addAll(await await _keyDao.getPgpKeys(true));

    await _deleteAll(keys);
    return _keyDao.deleteAll();
  }

//----------------------------------private--------------------------------------

  Future<PgpKey> _fromDb(LocalPgpKey pgpKey) async {
    if (pgpKey == null) {
      return null;
    }
    final id = _id(pgpKey.name, pgpKey.mail, pgpKey.isPrivate);

    final key = await _secureStorage.read(key: id);

    return PgpKey.fill(
      pgpKey.name,
      pgpKey.mail,
      pgpKey.isPrivate,
      key,
      pgpKey.length,
    );
  }

  Future<LocalPgpKey> _toDb(PgpKey pgpKey) async {
    if (pgpKey == null) {
      return null;
    }
    final id = _id(pgpKey.name, pgpKey.mail, pgpKey.isPrivate);

    await _secureStorage.write(key: id, value: pgpKey.key);

    return LocalPgpKey(
      id: id,
      name: pgpKey.name,
      mail: pgpKey.mail,
      isPrivate: pgpKey.isPrivate,
      length: pgpKey.length,
      other: _other,
    );
  }

  String _id(String name, String mail, bool isPrivate) {
    assert(_other.isNotEmpty, "other required");
    return "$_other$name$mail$isPrivate";
  }

  Future<String> _key(String name, String mail, bool isPrivate) async {
    final id = _id(name, mail, isPrivate);

    return await _secureStorage.read(key: id);
  }

  _delete(String name, String email, bool isPrivate) async {
    final id = _id(name, email, isPrivate);

    await _secureStorage.delete(key: id);
  }

  _deleteAll(List<LocalPgpKey> pgpKeys) async {
    for (var item in pgpKeys) {
      final id = _id(item.name, item.mail, item.isPrivate);

      await _secureStorage.delete(key: id);
    }
  }
}
