//@dart=2.9
import 'dart:async';
import 'dart:io';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/contacts_repository_impl.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:aurora_mail/utils/identity_util.dart';
import 'package:bloc/bloc.dart';
import 'package:crypto_model/crypto_model.dart';
import 'package:crypto_storage/crypto_storage.dart';
import 'package:crypto_worker/crypto_worker.dart';

import 'bloc.dart';

class PgpSettingsBloc extends Bloc<PgpSettingsEvent, PgpSettingsState> {
  final PgpSettingsMethods _methods;
  final AuthBloc authBloc;

  PgpSettingsBloc(
    CryptoStorage _cryptoStorage,
    PgpWorker _cryptoWorker,
    this.authBloc,
  ) : _methods = PgpSettingsMethods(
          _cryptoStorage,
          _cryptoWorker,
          authBloc.currentUser,
          ContactsRepositoryImpl(
              user: authBloc.currentUser, appDB: DBInstances.appDB),
        ), super(ProgressState());

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

    final userPrivateKeys = await _methods.getKeys(true);
    final userPublicKeys = await _methods.getKeys(false);
    final contactPublicKeys = await _methods.getContactKeys();

    yield LoadedState(userPublicKeys, userPrivateKeys, contactPublicKeys, null);
  }

  Stream<PgpSettingsState> _generateKeys(GenerateKeys event) async* {
    yield* _loadKeys().map((item) {
      if (item is LoadedState) {
        return item.copyWith(
          keyProgress: IdentityView.solid(event.name, event.mail),
        );
      } else {
        return item;
      }
    });

    try {
      await _methods.generateKeys(
        event.name,
        event.mail,
        event.length,
        event.password,
      );
    } catch (e) {
      print(e);
    }
    yield* _loadKeys();
  }

  Stream<PgpSettingsState> _parseKey(ParseKey event) async* {
    final keys = await _methods.parseKey(event.key);
    if (keys.isEmpty) {
      yield ErrorState(ErrorToShow.message(S.current.error_pgp_keys_not_found));
      return;
    }
    final userEmails = await authBloc
        .getAliasesAndIdentities(true)
        .then((items) => items.map((item) => item.mail).toSet());

    final sortKey = await _methods.sortKeys(keys, userEmails);

    yield SelectKeyForImport(sortKey.userKey, sortKey.contactKey);
  }

  Future<List<PgpKey>> parseKey(String key) {
    return _methods.parseKey(key);
  }

  Future<SelectKeyForImport> sortKey(String key) async {
    final keys = await _methods.parseKey(key);

    final userEmail = await authBloc
        .getAliasesAndIdentities(true)
        .then((items) => items.map((item) => item.mail).toSet());

    final sortKey = await _methods.sortKeys(keys, userEmail);

    return SelectKeyForImport(sortKey.userKey, sortKey.contactKey);
  }

  Future<String> getKeyFromFile() async {
    Future<String> result;
    try {
      result = _methods.pickFileContent();
    } catch (err) {
      _showError(ErrorToShow(err));
    }
    return result;
  }

  Stream<PgpSettingsState> _showError(ErrorToShow errorToShow) async* {
    yield ErrorState(errorToShow);
  }

  Stream<PgpSettingsState> _importKeyFromFile() async* {
    String file;
    try {
      file = await _methods.pickFileContent();
    } catch (err) {
      yield ErrorState(ErrorToShow(err));
      return;
    }
    if (file == null) return;
    yield* _parseKey(ParseKey(file));
  }

  Stream<PgpSettingsState> _importKey(ImportKey event) async* {
    yield ImportProgress();
    final selectedUser = _methods.filterSelected(event.userKey);
    await _methods.addToStorage(selectedUser);

    final selectedContact = _methods.filterSelected(event.contactKey);
    await _methods.addToContact(selectedContact);
    yield ImportComplete();
    yield* _loadKeys();
  }

  Stream<PgpSettingsState> _deleteKey(DeleteKey event) async* {
    if (event.pgpKey is PgpKeyWithContact) {
      await _methods.deleteContactKey(
        event.pgpKey.mail,
      );
    } else {
      await _methods.deleteKey(
        event.pgpKey.name,
        event.pgpKey.mail,
        event.pgpKey.isPrivate,
      );
    }
    yield* _loadKeys();
  }

  Stream<PgpSettingsState> _downloadKeys(DownloadKeys event) async* {
    try {
      File file;
      if (event.pgpKeys.length == 1) {
        file = await _methods.downloadKey(event.pgpKeys.first);
      } else {
        file = await _methods.downloadKeys(event.pgpKeys);
      }
      yield CompleteDownload(file.path);
    } catch (err) {
      yield ErrorState(ErrorToShow(err));
    }
  }

  Stream<PgpSettingsState> _shareKeys(ShareKeys event) async* {
    if (event.pgpKeys.length == 1) {
      await _methods.shareKey(event.pgpKeys.first, event.rect);
    } else {
      await _methods.shareKeys(event.pgpKeys, event.rect);
    }
  }
}
