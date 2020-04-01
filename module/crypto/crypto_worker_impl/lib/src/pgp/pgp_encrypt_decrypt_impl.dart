import 'package:crypto_model/crypto_model.dart';
import 'package:crypto_storage/crypto_storage.dart';
import 'package:crypto_stream/crypto_plugin.dart';
import 'package:crypto_worker/crypto_worker.dart';

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

    if (privateKey == null) {
      throw PgpKeyNotFound([sender]);
    }

    try {
      final result = await _pgp.bufferPlatformSink(
          message,
          _pgp.decrypt(
            privateKey?.key,
            publicKey == null ? null : [publicKey.key],
            password,
          ));
      final verified = await _pgp.lastVerifyResult();

      return Decrypted(verified, result);
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

    final text = await _pgp.verify(message, publicKey?.key);
    final verified = await _pgp.lastVerifyResult();

    return Decrypted(verified, text);
  }

  Future<String> sign(String message, String password) async {
    final privateKey = await _storage.getPgpKey(sender, true);
    if (privateKey == null) {
      throw PgpKeyNotFound([sender]);
    }

    try {
      final result = await _pgp.sign(
        message,
        privateKey.key,
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

    try {
      final result = await _pgp.bufferPlatformSink(
          message,
          _pgp.encrypt(
            privateKey?.key,
            publicKeys,
            password,
          ));
      return result;
    } catch (e) {
      if (e is PgpSignError || e is PgpInputError) {
        throw PgpInvalidSign();
      }
      rethrow;
    }
  }

  @override
  Future stop() async {

  }
}
