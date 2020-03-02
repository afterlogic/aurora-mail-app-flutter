import 'package:crypto_model/crypto_model.dart';
import 'package:crypto_plugin/crypto_plugin.dart';
import 'package:crypto_storage/crypto_storage.dart';
import 'package:crypto_worker/crypto_worker.dart';

import 'pgp_encrypt_decrypt_impl.dart';

class PgpWorkerImpl extends PgpWorker {
  final Pgp _pgp;
  final CryptoStorage _storage;
  PgpEncryptDecrypt _pgpEncryptDecrypt;

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
    return _pgpEncryptDecrypt;
  }

  Future<List<PgpKey>> createKeyPair(
    String name,
    int length,
    String email,
    String password,
  ) async {
    final keyPair = await _pgp.createKeys(
        length, name.isEmpty ? "$email" : "$name <$email>", password);

    final private = PgpKey.fill(name, email, true, keyPair.secret, length);
    final public = PgpKey.fill(name, email, false, keyPair.public, length);

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
    for (String key in keysText) {
      final description = await _pgp.getKeyDescription(key);
      for (String email in description.email) {
        final groups = RegExp("([\\D|\\d]*)?<((?:\\D|\\d)*)>").firstMatch(email);
        String validEmail = "";
        String name = "";
        if (groups?.groupCount == 2) {
          name = groups.group(1);
          validEmail = groups.group(2);
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
  }

  final _BEGIN_PGP_MESSAGE = "-----BEGIN PGP MESSAGE-----";
  final _END_PGP_MESSAGE = "-----END PGP MESSAGE-----";

  final _BEGIN_PGP_SIGNED_MESSAGE = "-----BEGIN PGP SIGNED MESSAGE-----";
  final _BEGIN_PGP_SIGNATURE = "-----BEGIN PGP SIGNATURE-----";
  final _END_PGP_SIGNATURE = "-----END PGP SIGNATURE-----";

  final _PGP_KEY_BEGIN = "-----BEGIN PGP \\w* KEY BLOCK-----";
  final _PGP_KEY_END = "-----END PGP \\w* KEY BLOCK-----";
}
