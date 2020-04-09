import 'dart:io';

import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/contacts_repository.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/utils/download_directory.dart';
import 'package:aurora_mail/utils/identity_util.dart';
import 'package:aurora_mail/utils/permissions.dart';
import 'package:crypto_model/crypto_model.dart';
import 'package:crypto_storage/src/pgp_storage.dart';
import 'package:crypto_storage_impl/crypto_storage_impl.dart';
import 'package:crypto_worker/src/pgp/pgp_worker.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:file_picker/file_picker.dart';

class PgpSettingsMethods {
  final CryptoStorage cryptoStorage;
  final PgpWorker cryptoWorker;
  final ContactsRepository contactsDao;
  final User user;

  PgpSettingsMethods(
      this.cryptoStorage, this.cryptoWorker, this.user, this.contactsDao);

  Future<List<PgpKey>> getKeys(bool isPrivate) {
    return cryptoStorage.getPgpKeys(isPrivate);
  }

  Future<List<PgpKey>> getContactKeys() async {
    final keys = await cryptoStorage.getContactsPgpKeys();
    final map = <String, PgpKey>{};
    for (var value in keys) {
      map[value.mail] = value;
    }
    return map.values.toList();
  }

  Future generateKeys(
    String name,
    String mail,
    int length,
    String password,
  ) async {
    await cryptoWorker.createKeyPair(name, length, mail, password);
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

  Future deleteKey(String name, String mail, bool isPrivate) async {
    await cryptoStorage.deletePgpKey(name, mail, isPrivate);
  }

  Future<List<PgpKey>> parseKey(String key) {
    return cryptoWorker.parseKey(key);
  }

  Future<Map<PgpKey, bool>> userKeyMarkIfNotExist(List<PgpKey> keys) async {
    final map = <PgpKey, bool>{};
    for (var key in keys) {
      final existKey =
          await cryptoStorage.getPgpKey(key.mail, key.isPrivate, false);
      map[key] = existKey == null ? true : null;
    }
    return map;
  }

  Future<Map<PgpKeyWithContact, bool>> contactKeyMarkIfNotExist(
      List<PgpKey> keys) async {
    final map = <PgpKeyWithContact, bool>{};
    for (var key in keys) {
      final contact = await contactsDao.getContactByEmail(key.mail);
      map[PgpKeyWithContact(key, contact)] =
          (contact?.pgpPublicKey?.length ?? 0) <= 10 ? true : null;
    }
    return map;
  }

  List<T> filterSelected<T extends PgpKey>(Map<T, bool> keys) {
    final selected = <T>[];
    for (var entries in keys.entries) {
      if (entries.value == true) {
        selected.add(entries.key);
      }
    }
    return selected;
  }

  Future addToStorage(List<PgpKey> selected) {
    return cryptoStorage.addPgpKeys(selected);
  }

  Future<String> pickFileContent() async {
    await getStoragePermissions();
    var content = "";
    final files = await FilePicker.getMultiFile(
      type: FileType.custom,
      fileExtension: "asc",
    );
    if (files == null) return null;
    for (var file in files) {
      content += await file.readAsString();
    }
    return content;
  }

  _share(String title, String content) {
    Share.text(title, content, "text/plain");
  }

  static const KEY_FOLDER = "pgp_keys";

  Future<PgpKeyMap> sortKeys(List<PgpKey> keys, Set<String> userEmail) async {
    final userKeys = <PgpKey>[];
    final contactKeys = <PgpKey>[];

    for (var key in keys) {
      if (userEmail.contains(IdentityView.fromString(key.mail).email)) {
        userKeys.add(key);
      } else {
        contactKeys.add(key);
      }
    }

    final existUserKeys = await userKeyMarkIfNotExist(userKeys);
    final existContactKeys = await contactKeyMarkIfNotExist(contactKeys);

    return PgpKeyMap(existUserKeys, existContactKeys);
  }

  Future addToContact(List<PgpKeyWithContact> selectedContact) async {
    try {
      for (var value in selectedContact) {
        Contact contact = value.contact;
        if (contact == null) {
          contact = await contactsDao.addContact(Contact(
            personalEmail: "",
            viewEmail: value.mail ?? "",
            fullName: value.name ?? "",
            davContactsVCardUid: "",
            frequency: 0,
            entityId: null,
            groupUUIDs: <String>[],
            eTag: "",
            useFriendlyName: false,
            title: "",
            davContactsUid: "",
            storage: StorageNames.personal,
            uuidPlusStorage: "",
            dateModified: DateTime.now().toIso8601String(),
            idTenant: 1,
            userLocalId: user.localId,
            idUser: user.serverId,
            pgpPublicKey: value.key,
            uuid: "",
          ));
        }

        await contactsDao.addKeyToContact(
          contact.copyWith(pgpPublicKey: value.key),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Future deleteContactKey(String mail) async {
    await contactsDao.deleteContactKey(
      mail,
    );
  }
}

class PgpKeyMap {
  final Map<PgpKey, bool> userKey;
  final Map<PgpKeyWithContact, bool> contactKey;

  PgpKeyMap(this.userKey, this.contactKey);
}
