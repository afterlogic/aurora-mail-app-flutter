import 'package:aurora_mail/database/pgp/pgp_key_dao.dart';
import 'package:crypto_plugin/crypto_plugin.dart';
import 'package:crypto_storage/crypto_storage.dart';
import 'package:crypto_storage_impl/crypto_storage_impl.dart';
import 'package:crypto_worker_impl/crypto_worker_impl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:inject/inject.dart';
import 'package:crypto_worker/crypto_worker.dart';

@module
class CryptoModule {
  @provide
  @singleton
  Pgp pgp() => Pgp();

  @provide
  @singleton
  CryptoStorage cryptoStorage(
    FlutterSecureStorage secureStorage,
    PgpKeyDao pgpKeyDao,
  ) =>
      CryptoStorageImpl(
        secureStorage,
        pgpKeyDao,
      );

  @provide
  @singleton
  PgpWorker pgpWorker(
    Pgp pgp,
    CryptoStorage cryptoStorage,
  ) =>
      PgpWorkerImpl(
        pgp,
        cryptoStorage,
      );
}
