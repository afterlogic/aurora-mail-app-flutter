import 'package:crypto_model/crypto_model.dart';
import 'package:crypto_worker/crypto_worker.dart';

abstract class PgpWorker {
  PgpEncryptDecrypt encryptDecrypt(
    String sender,
    List<String> recipient,
  );

  Future<List<PgpKey>> createKeyPair(
      String name,
    int length,
    String email,
    String password,
  );

    Future<List<PgpKey>> parseKey(
      String text,
    );

  EncryptType encryptType(String text);

  stop();
}
