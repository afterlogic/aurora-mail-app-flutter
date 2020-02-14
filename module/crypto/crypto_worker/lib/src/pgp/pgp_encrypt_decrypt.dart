import 'package:crypto_worker/src/pgp/decrypted.dart';

abstract class PgpEncryptDecrypt {
  Future<Decrypted> decrypt(String message, String password);

  Future<Decrypted> verifySign(String message);

  Future<String> encrypt(String message, [String password]);

  Future<String> sign(String message, String password);

  Future<void> stop();
}
