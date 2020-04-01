import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto_model/crypto_model.dart';
import 'package:crypto_plugin/crypto_plugin.dart';
import 'package:crypto_storage/crypto_storage.dart';
import 'package:crypto_worker/crypto_worker.dart';
import 'package:crypto_worker_impl/crypto_worker_impl.dart';
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

    final privateKey = await _storage.getPgpKey(recipients.first, true);
    final publicKey = await _storage.getPgpKey(sender, false);
    final tempFile = await PgpWorkerImpl.tempFile;

    if (privateKey == null) {
      throw PgpKeyNotFound([sender]);
    }

    await _pgp.stop();
    await _pgp.setTempFile(tempFile);
    await _pgp.setPrivateKey(privateKey?.key);

    await _pgp.setPublicKeys(publicKey == null ? null : [publicKey.key]);

    try {
      final result = await _pgp.decryptBytes(
        utf8.encode(message),
        password,
      );
      final verified = await _pgp.verifyResult();
      final text = utf8.decode(result);

      return Decrypted(verified, text);
    } catch (e) {
      if (e is PgpSignError || e is PgpInputError) {
        throw PgpInvalidSign();
      } else {
        rethrow;
      }
    }
  }

  Future<Decrypted> verifySign(String message) async {
    final publicKey = await _storage.getPgpKey(sender, false);
    if (publicKey == null) {
      throw PgpKeyNotFound([sender]);
    }
    final tempFile = await PgpWorkerImpl.tempFile;

    await _pgp.stop();
    await _pgp.setPublicKeys(publicKey == null ? null : [publicKey.key]);
    await _pgp.setTempFile(tempFile);

    final text = await _pgp.verifySign(message);
    final verified = await _pgp.verifyResult();

    return Decrypted(verified, text);
  }

  Future<String> sign(String message, String password) async {
    final privateKey = await _storage.getPgpKey(sender, true);
    if (privateKey == null) {
      throw PgpKeyNotFound([sender]);
    }
    final tempFile = await PgpWorkerImpl.tempFile;

    await _pgp.stop();
    await _pgp.setTempFile(tempFile);
    await _pgp.setPrivateKey(privateKey.key);
    await _pgp.setPublicKeys(null);

    try {
      final result = await _pgp.addSign(
        message,
        password,
      );
      return result;
    } catch (e) {
      throw PgpInvalidSign();
    }
  }

  @override
  Future<String> encrypt(String message, [String password]) async {
    PgpKey privateKey;
    if (sender != null && password != null) {
      privateKey = await _storage.getPgpKey(sender, true);
      if (privateKey == null) {
        throw PgpKeyNotFound([sender]);
      }
    }
    final publicKeys = <String>[];
    final withNotKey = <String>[];
    for (var recipient in recipients) {
      final key = await _storage.getPgpKey(recipient, false);
      if (key == null) {
        withNotKey.add(recipient);
      } else {
        publicKeys.add(key.key);
      }
    }
    if (withNotKey.isNotEmpty) {
      throw PgpKeyNotFound(withNotKey);
    }

    final tempFile = await PgpWorkerImpl.tempFile;

    await _pgp.stop();
    await _pgp.setTempFile(tempFile);
    await _pgp.setPrivateKey(privateKey?.key);
    await _pgp.setPublicKeys(publicKeys);

    try {
      final result = await _pgp.encryptBytes(
        utf8.encode(message),
        password,
      );
      return utf8.decode(result);
    } catch (e) {
      if (e is PgpSignError || e is PgpInputError) {
        throw PgpInvalidSign();
      }
      rethrow;
    }
  }

  @override
  Future stop() async {
    return _pgp.stop();
  }
}
