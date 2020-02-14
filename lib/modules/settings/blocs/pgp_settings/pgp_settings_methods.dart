import 'package:crypto_model/crypto_model.dart';
import 'package:crypto_storage/src/pgp_storage.dart';

import 'package:crypto_worker/src/pgp/pgp_worker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class PgpSettingsMethods {
  final CryptoStorage cryptoStorage;
  final PgpWorker cryptoWorker;

  PgpSettingsMethods(this.cryptoStorage, this.cryptoWorker);

  Future<List<PgpKey>> getKeys(bool isPrivate) {
    return cryptoStorage.getPgpKeys(isPrivate);
  }

  Future generateKeys(String mail, int length, String password) async {
    await cryptoWorker.createKeyPair(length, mail, password);
  }

  Future deleteKey(String mail) async {
    await cryptoStorage.deletePgpKey(mail, true);
    await cryptoStorage.deletePgpKey(mail, false);
  }

  Future<List<PgpKey>> parseKey(String key) {
    return cryptoWorker.parseKey(key);
  }

  Future<Map<PgpKey, bool>> markIfNotExist(List<PgpKey> keys) async {
    final map = <PgpKey, bool>{};
    for (var key in keys) {
      final existKey = await cryptoStorage.getPgpKey(key.mail, key.isPrivate);
      map[key] = existKey == null;
    }
    return map;
  }

  List<PgpKey> filterSelected(Map<PgpKey, bool> keys) {
    final selected = <PgpKey>[];
    for (var entries in keys.entries) {
      if (entries.value) {
        selected.add(entries.key);
      }
    }
    return selected;
  }

  Future addToStorage(List<PgpKey> selected) {
    return cryptoStorage.addPgpKeys(selected);
  }

  Future<String> pickFileContent() async {
    var content = "";
    final files = await FilePicker.getMultiFile(fileExtension: "asc");
    for (var file in files) {
      content += await file.readAsString();
    }
    return content;
  }
}
