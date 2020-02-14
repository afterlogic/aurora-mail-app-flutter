import 'dart:async';
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
    if (event is GenerateKeys) yield* _generateKeys(event);
    if (event is ParseKey) yield* _parseKey(event);
    if (event is ImportKey) yield* _importKey(event);
    if (event is ImportFromFile) yield* _importKeyFromFile();
  }

  Stream<PgpSettingsState> _loadKeys() async* {
    if (state is! LoadedState) yield ProgressState();

    final privateKeys = await _methods.getKeys(true);
    final publicKeys = await _methods.getKeys(false);

    yield LoadedState(publicKeys, privateKeys);
  }

  Stream<PgpSettingsState> _generateKeys(GenerateKeys event) async* {
    final current = state;
    if (current is LoadedState) {
      yield current.copyWith(keyProgress: event.mail);
    }
    await _methods.deleteKey(event.mail);
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
}
