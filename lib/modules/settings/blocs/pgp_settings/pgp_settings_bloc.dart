import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:crypto_storage/crypto_storage.dart';
import 'package:crypto_worker/crypto_worker.dart';
import 'bloc.dart';

class PgpSettingsBloc extends Bloc<PgpSettingsEvent, PgpSettingsState> {
  final PgpSettingsMethods _methods;

  PgpSettingsBloc(CryptoStorage _cryptoStorage, PgpWorker _cryptoWorker)
      : _methods = PgpSettingsMethods(_cryptoStorage, _cryptoWorker);

  @override
  PgpSettingsState get initialState => ProgressState();

  @override
  Stream<PgpSettingsState> mapEventToState(
    PgpSettingsEvent event,
  ) async* {
    if (event is LoadKeys) yield* _loadKeys();
    if (event is DeleteKey) yield* _deleteKey(event);
    if (event is GenerateKeys) yield* _generateKeys(event);
    if (event is ParseKey) yield* _parseKey(event);
    if (event is ImportKey) yield* _importKey(event);
    if (event is ImportFromFile) yield* _importKeyFromFile();
    if (event is DownloadKeys) yield* _downloadKeys(event);
    if (event is ShareKeys) yield* _shareKeys(event);
  }

  Stream<PgpSettingsState> _loadKeys() async* {
    if (state is! LoadedState) yield ProgressState();

    final privateKeys = await _methods.getKeys(true);
    final publicKeys = await _methods.getKeys(false);

    yield LoadedState(publicKeys, privateKeys);
  }

  Stream<PgpSettingsState> _generateKeys(GenerateKeys event) async* {
    await _methods.deleteKey(event.mail);

    yield* _loadKeys().map((item) {
      if (item is LoadedState) {
        return item.copyWith(keyProgress: event.mail);
      } else {
        return item;
      }
    });

    await _methods.generateKeys(event.mail, event.length, event.password);
    yield* _loadKeys();
  }

  Stream<PgpSettingsState> _parseKey(ParseKey event) async* {
    final keys = await _methods.parseKey(event.key);
    if (keys.isEmpty) {
      yield ErrorState("keys_not_found");
      return;
    }
    final existKeys = await _methods.markIfNotExist(keys);
    yield SelectKeyForImport(existKeys);
  }

  Stream<PgpSettingsState> _importKeyFromFile() async* {
    final file = await _methods.pickFileContent();
    yield* _parseKey(ParseKey(file));
  }

  Stream<PgpSettingsState> _importKey(ImportKey event) async* {
    final selected = _methods.filterSelected(event.keys);
    await _methods.addToStorage(selected);
    yield* _loadKeys();
  }

  Stream<PgpSettingsState> _deleteKey(DeleteKey event) async* {
    await _methods.deleteKey(event.pgpKey.mail);
    yield* _loadKeys();
  }

  Stream<PgpSettingsState> _downloadKeys(DownloadKeys event) async* {
    File file;
    if (event.pgpKeys.length == 1) {
      file = await _methods.downloadKey(event.pgpKeys.first);
    } else {
      file = await _methods.downloadKeys(event.pgpKeys);
    }
    yield CompleteDownload(file.path);
  }

  Stream<PgpSettingsState> _shareKeys(ShareKeys event) async* {
    if (event.pgpKeys.length == 1) {
      await _methods.shareKey(event.pgpKeys.first);
    } else {
      await _methods.shareKeys(event.pgpKeys);
    }
  }
}
