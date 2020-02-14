import 'dart:io';
import 'dart:typed_data';

import 'package:crypto_storage/crypto_storage.dart';
import 'package:crypto_worker/crypto_worker.dart';
import 'package:crypto_plugin/crypto_plugin.dart';
import 'package:path_provider/path_provider.dart';

class PgpEncryptDecryptImpl extends PgpEncryptDecrypt {
  final Pgp _pgp;
  final CryptoStorage _storage;
  final String sender;
  final List<String> recipients;

  PgpEncryptDecryptImpl(
    this._pgp,
    this._storage,
    this.sender,
    this.recipients,
  );

  @override
  Future<Decrypted> decrypt(String message, String password) async {
    assert(recipients.length == 1, "expected single recipient");

    final privateKey = await _storage.privateKey(recipients.first);
    final publicKey = await _storage.publicKey(sender);
    final tempFile = await _tempFile;

    if (privateKey == null) {
      throw PgpKeyNotFound([sender]);
    }

    await _pgp.stop();
    await _pgp.setTempFile(tempFile);
    await _pgp.setPrivateKey(privateKey);

    await _pgp.setPublicKeys([publicKey]);

    try {
      final result = await _pgp.decryptBytes(
        Uint8List.fromList(message.codeUnits),
        password,
      );
      final verified = await _pgp.verifyResult();
      final text = String.fromCharCodes(result);

      return Decrypted(verified, text);
    } catch (e) {
      throw PgpDecryptError();
    }
  }

  Future<Decrypted> verifySign(String message) async {
    final publicKey = await _storage.publicKey(sender);
    final tempFile = await _tempFile;

    await _pgp.stop();
    await _pgp.setPublicKeys([publicKey]);
    await _pgp.setTempFile(tempFile);

    final text = await _pgp.verifySign(message);
    final verified = await _pgp.verifyResult();

    return Decrypted(verified, text);
  }

  Future<String> sign(String message, String password) async {
    final privateKey = await _storage.privateKey(sender);
    if (privateKey == null) {
      throw PgpKeyNotFound([sender]);
    }
    final tempFile = await _tempFile;

    await _pgp.stop();
    await _pgp.setTempFile(tempFile);
    await _pgp.setPrivateKey(privateKey);
    await _pgp.setPublicKeys(null);

    try {
      final result = await _pgp.addSign(
        message,
        password,
      );
      return result;
    } catch (e) {
      if (e is PgpSignError || e is PgpInputError) {
        throw PgpInvalidSign();
      }
      rethrow;
    }
  }

  @override
  Future<String> encrypt(String message, [String password]) async {
    final privateKey = await _storage.privateKey(sender);
    if (privateKey == null) {
      throw PgpKeyNotFound([sender]);
    }
    final publicKeys = <String>[];
    final withNotKey = <String>[];
    for (var recipient in recipients) {
      final key = await _storage.publicKey(recipient);
      if (key == null) {
        withNotKey.add(recipient);
      } else {
        publicKeys.add(key);
      }
    }
    if (withNotKey.isNotEmpty) {
      throw PgpKeyNotFound(withNotKey);
    }

    final tempFile = await _tempFile;

    await _pgp.stop();
    await _pgp.setTempFile(tempFile);
    await _pgp.setPrivateKey(privateKey);
    await _pgp.setPublicKeys(publicKeys);

    try {
      final result = await _pgp.encryptBytes(
        Uint8List.fromList(message.codeUnits),
        password,
      );
      return String.fromCharCodes(result);
    } catch (e) {
      if (e is PgpSignError || e is PgpInputError) {
        throw PgpInvalidSign();
      }
      rethrow;
    }
  }

  Future<File> get _tempFile async {
    final dir = await getTemporaryDirectory();
    return File(dir.path + Platform.pathSeparator + tempFile);
  }

  @override
  Future stop() async {
    final file = await _tempFile;
    if (await file.exists()) file.delete();
    return _pgp.stop();
  }

  static const tempFile = "temp.pgp";
}
