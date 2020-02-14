import 'dart:io';

import 'package:aurora_mail/utils/download_directory.dart';
import 'package:aurora_mail/utils/permissions.dart';
import 'package:crypto_model/crypto_model.dart';
import 'package:crypto_storage/src/pgp_storage.dart';

import 'package:crypto_worker/src/pgp/pgp_worker.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
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

  Future<File> downloadKey(PgpKey key) async {
    final fileName =
        "${(key.name + " ") ?? ""}${key.mail} PGP ${key.isPrivate ? "private" : "public"} key.asc";
    final file = File(
      await _keysFolderPath() + Platform.pathSeparator + fileName,
    );
    await file.create(recursive: true);
    await file.writeAsString(key.key);
    return file;
  }

  Future<File> downloadKeys(List<PgpKey> keys) async {
    final fileName = "PGP public keys.asc";
    final file = File(
      await _keysFolderPath() + Platform.pathSeparator + fileName,
    );
    await file.create(recursive: true);
    await file.writeAsString(keys.map((key) => key.key).join("\n\n"));
    return file;
  }

  shareKey(PgpKey key) {
    final title =
        "${(key.name + " ") ?? ""}${key.mail} PGP ${key.isPrivate ? "private" : "public"} key.asc";
    _share(title, key.key);
  }

  shareKeys(List<PgpKey> keys) {
    final title = "PGP public keys.asc";
    _share(title, keys.map((key) => key.key).join("\n\n"));
  }

  Future<String> _keysFolderPath() async {
    await getStoragePermissions();
    final dirPath = await getDownloadDirectory();
    return dirPath + Platform.pathSeparator + KEY_FOLDER;
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

  _share(String title, String content) {
    Share.text(title, content, "text/plain");
  }

  static const KEY_FOLDER = "pgp_keys";
}
