import 'dart:convert';
import 'dart:io';

import 'package:crypto_model/crypto_model.dart';
import 'package:crypto_storage/crypto_storage.dart';
import 'package:crypto_stream/crypto_plugin.dart';
import 'package:crypto_worker/crypto_worker.dart';
import 'package:path_provider/path_provider.dart';

import 'pgp_encrypt_decrypt_impl.dart';

class PgpWorkerImpl extends PgpWorker {
  final utf8 = Utf8Codec(allowMalformed: true);
  final Pgp _pgp;
  final CryptoStorage _storage;
  PgpEncryptDecrypt? _pgpEncryptDecrypt;

  PgpWorkerImpl(this._pgp, this._storage);

  PgpEncryptDecrypt encryptDecrypt(
    String sender,
    List<String> recipient,
  ) {
    _pgpEncryptDecrypt?.stop();
    _pgpEncryptDecrypt = PgpEncryptDecryptImpl(
      _pgp,
      _storage,
      sender,
      recipient,
    );
    return _pgpEncryptDecrypt!;
  }

  Future<List<PgpKey>> createKeyPair(
    String name,
    int length,
    String email,
    String password,
  ) async {
    final keyPair = await _pgp.createKeys(
      length,
      name.isEmpty ? "$email" : "$name <$email>",
      password,
    );

    final private = PgpKey.fill(name, email, true, keyPair.privateKey, length);
    final public = PgpKey.fill(name, email, false, keyPair.publicKey, length);

    await _storage.addPgpKey(public);
    await _storage.addPgpKey(private);

    return [private, public];
  }

  Future<List<PgpKey>> parseKey(String text) async {
    final keysText = RegExp("($_PGP_KEY_BEGIN[\\d\\D]*?(?:$_PGP_KEY_END))")
        .allMatches(text)
        .map((regExp) => regExp.group(0))
        .toList();
    final keys = <PgpKey>[];
    for (String? key in keysText) {
      if(key == null) continue;
      final description = await _pgp.getKeyDescription(key);
      for (String email in description.emails) {
        final groups =
            RegExp("([\\D|\\d]*)?<((?:\\D|\\d)*)>").firstMatch(email);
        String? validEmail;
        String? name;
        if (groups?.groupCount == 2) {
          name = groups?.group(1);
          validEmail = groups?.group(2);
        } else {
          validEmail = email;
        }

        keys.add(
          PgpKey.fill(
            name ?? "",
            validEmail ?? "",
            description.isPrivate,
            key,
            description.length,
          ),
        );
      }
    }
    return keys;
  }

  Future<bool> checkKeyPassword(String key, String password) {
    return _pgp.checkKeyPassword(key, password);
  }

  Future<String> encryptSymmetric(String text, String password) async {
    final tempFile = await PgpWorkerImpl.tempFile;
    final length = utf8.encode(text).length;
    return _pgp.bufferPlatformSink(
        text,
        _pgp.symmetricallyEncrypt(
          tempFile,
          password,
          length,
        ));
  }

  EncryptType encryptType(String text) {
    bool _contains(List<String> patterns) {
      var startIndex = 0;
      for (var pattern in patterns) {
        startIndex = text.indexOf(pattern, startIndex);
        if (startIndex == -1) {
          return false;
        }
      }
      return true;
    }

    if (_contains([
      _BEGIN_PGP_MESSAGE,
      _END_PGP_MESSAGE,
    ])) {
      return EncryptType.Encrypt;
    }

    if (_contains([
      _BEGIN_PGP_SIGNED_MESSAGE,
      _BEGIN_PGP_SIGNATURE,
      _END_PGP_SIGNATURE
    ])) {
      return EncryptType.Sign;
    }

    return EncryptType.None;
  }

  @override
  Future stop() async {
    await _pgpEncryptDecrypt?.stop();
    _pgpEncryptDecrypt = null;
    final file = await tempFile;
    if (await file.exists()) file.delete();
  }

  static Future<File> get tempFile async {
    final dir = await getTemporaryDirectory();
    final file = File(dir.path + Platform.pathSeparator + _tempFile);
    if (!(await file.exists())) await file.create();
    return file;
  }

  final _BEGIN_PGP_MESSAGE = "-----BEGIN PGP MESSAGE-----";
  final _END_PGP_MESSAGE = "-----END PGP MESSAGE-----";

  final _BEGIN_PGP_SIGNED_MESSAGE = "-----BEGIN PGP SIGNED MESSAGE-----";
  final _BEGIN_PGP_SIGNATURE = "-----BEGIN PGP SIGNATURE-----";
  final _END_PGP_SIGNATURE = "-----END PGP SIGNATURE-----";

  final _PGP_KEY_BEGIN = "-----BEGIN PGP \\w* KEY BLOCK-----";
  final _PGP_KEY_END = "-----END PGP \\w* KEY BLOCK-----";
  static const _tempFile = "temp.pgp";
}
