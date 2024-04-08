//@dart=2.9
import 'dart:io';

import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/contacts_repository.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/utils/download_directory.dart';
import 'package:aurora_mail/utils/identity_util.dart';
import 'package:aurora_mail/utils/permissions.dart';
import 'package:crypto_model/crypto_model.dart';
import 'package:crypto_storage/src/pgp_storage.dart';
import 'package:crypto_worker/src/pgp/pgp_worker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:share/share.dart';

class PgpSettingsMethods {
  final CryptoStorage cryptoStorage;
  final PgpWorker cryptoWorker;
  final ContactsRepository contactsRepository;
  final User user;

  PgpSettingsMethods(
      this.cryptoStorage, this.cryptoWorker, this.user, this.contactsRepository);

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
    try {
      final fileName =
          "${((key.name.startsWith(" ") ? key.name.substring(1) : key.name) + " ") ?? ""}${key.mail} PGP ${key.isPrivate ? "private" : "public"} key.asc"
              .replaceAll(Platform.pathSeparator, "");
      final file = File(
        await _keysFolderPath() + Platform.pathSeparator + fileName,
      );

      if (await file.exists()) await file.delete();
      await file.create(recursive: true);
      await file.writeAsString(key.key);
      return file;
    } catch (err) {
      print('ERROR PgpSettingsMethods.downloadKey(): $err');
      rethrow;
    }
  }

  Future<File> downloadKeys(List<PgpKey> keys) async {
    try {
      final fileName = "PGP public keys.asc";
      final file = File(
        await _keysFolderPath() + Platform.pathSeparator + fileName,
      );
      await file.create(recursive: true);
      await file.writeAsString(keys.map((key) => key.key).join("\n\n"));
      return file;
    } catch (err) {
      print('ERROR PgpSettingsMethods.downloadKeys(): $err');
      rethrow;
    }
  }

  shareKey(PgpKey key, Rect rect) {
    final title =
        "${(key.name + " ") ?? ""}${key.mail} PGP ${key.isPrivate ? "private" : "public"} key.asc";
    _shareFile(
      title,
      key.key,
      rect,
    );
  }

  shareKeys(List<PgpKey> keys, Rect rect) {
    final title = "PGP public keys.asc";
    _shareFile(
      title,
      keys.map((key) => key.key).join("\n\n"),
      rect,
    );
  }

  Future<String> _keysFolderPath() async {
    final dirPath = (await getDownloadDirectory());
    print('!!! dirPath = $dirPath}');
    // return dirPath + Platform.pathSeparator + KEY_FOLDER;
    return dirPath;
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
      final contact = await contactsRepository.getContactByEmail(key.mail);
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
    var content = "";
    final result = Platform.isIOS
        ? (await FilePicker.platform.pickFiles(
            type: FileType.any,
            allowMultiple: true,
          ))
        : (await FilePicker.platform.pickFiles(
            allowMultiple: true,
            type: FileType.custom,
            allowedExtensions: ["asc"],
          ));
    if (result == null) return null;
    final files = result.files;
    for (var file in files) {
      if (file.path.endsWith(".asc") || file.path.contains(".asc.")) {
        content += await File(file.path).readAsString();
      }
    }
    return content;
  }

  _shareFile(String title, String content, Rect rect) {
    Share.share(content, subject: title, sharePositionOrigin: rect);
  }

  static const KEY_FOLDER = "pgp_keys";

  Future<PgpKeyMap> sortKeys(List<PgpKey> keys, Set<String> userEmails) async {
    final userKeys = <PgpKey>[];
    final contactKeys = <PgpKey>[];

    if (BuildProperty.legacyPgpKey) {
      userKeys.addAll(keys);
    } else {
      for (var key in keys) {
        if (userEmails.contains(IdentityView.fromString(key.mail).email)) {
          userKeys.add(key);
        } else {
          contactKeys.add(key);
        }
      }
    }
    final existUserKeys = await userKeyMarkIfNotExist(userKeys);
    final existContactKeys = await contactKeyMarkIfNotExist(contactKeys);

    return PgpKeyMap(existUserKeys, existContactKeys);
  }

  Future addToContact(List<PgpKeyWithContact> selectedContact) async {
    try {
      final contacts = <Contact>[];
      for (var value in selectedContact) {
        Contact contact = value?.contact ??
            Contact.empty(
              viewEmail: value.pgpKey.mail,
              fullName: value.pgpKey.name,
            );
        contacts.add(
          contact.copyWith(pgpPublicKey: () => value.key),
        );
      }
      await contactsRepository.addKeyToContacts(
        contacts,
      );
    } catch (e) {
      print(e);
    }
  }

  Future deleteContactKey(String mail) async {
    await contactsRepository.deleteContactKey(
      mail,
    );
  }
}

class PgpKeyMap {
  final Map<PgpKey, bool> userKey;
  final Map<PgpKeyWithContact, bool> contactKey;

  PgpKeyMap(this.userKey, this.contactKey);
}
