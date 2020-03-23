import 'dart:async';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/inject/app_inject.dart';
import 'package:aurora_mail/models/alias_or_identity.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/mappers/contact_mapper.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/contacts/contacts_dao.dart';
import 'package:aurora_mail/modules/mail/repository/pgp_api.dart';
import 'package:aurora_mail/modules/mail/screens/compose/self_destructing/model/contact_with_key.dart';
import 'package:bloc/bloc.dart';
import 'package:crypto_storage/crypto_storage.dart';
import 'package:crypto_worker/crypto_worker.dart';
import 'package:webmail_api_client/webmail_api_error.dart';
import '../model/life_time.dart';
import 'bloc.dart';
import 'package:aurora_mail/utils/crypto_util.dart';

class SelfDestructingBloc extends Bloc<SelfDestructingEvent, SelfDestructingState> {
  final User user;
  final PgpApi pgpApi;
  final AliasOrIdentity aliasOrIdentity;
  final _contactsDao = ContactsDao(DBInstances.appDB);
  final CryptoStorage _cryptoStorage = AppInjector.instance.cryptoStorage();
  final PgpWorker _pgpWorker = AppInjector.instance.pgpWorker();
  final String subject;
  final String body;

  SelfDestructingBloc(
    this.user,
    Account account,
    this.aliasOrIdentity,
    this.subject,
    this.body,
  ) : pgpApi = PgpApi(user, account);

  @override
  SelfDestructingState get initialState => ProgressState();

  @override
  Stream<SelfDestructingState> mapEventToState(
    SelfDestructingEvent event,
  ) async* {
    if (event is LoadKey) yield* _loadKey(event);
    if (event is EncryptEvent) yield* _encrypt(event);
  }

  Future<List<ContactWithKey>> _loadContacts(List<String> emails) async {
    final contacts =
        ContactMapper.fromDB(await _contactsDao.getContactsByEmail(user.localId, emails));
    final recipientWithKey = <ContactWithKey>[];
    for (var contact in contacts) {
      recipientWithKey.add(
        ContactWithKey(
          contact,
          await _cryptoStorage.getPgpKey(contact.viewEmail, false),
        ),
      );
    }

    return recipientWithKey;
  }

  Stream<SelfDestructingState> _loadKey(LoadKey event) async* {
    final contacts = await _loadContacts([event.contact]);
    final key = await _cryptoStorage.getPgpKey(aliasOrIdentity.mail, true);
    yield LoadedKey(key, contacts);
  }

  Stream<SelfDestructingState> _encrypt(EncryptEvent event) async* {
    var encryptSubject = subject;
    var encryptBody = body;
    var password = "";
    var link = "";

    try {
      password = CryptoUtil.createSymmetricKey();

      encryptSubject = await _encryptSymmetric(subject, password);
      encryptBody = await _encryptSymmetric(body, password);

    } catch (e) {
      yield ErrorState("error_unknown");
      return;
    }

    try {
       link = await pgpApi.createSelfDestructLink(
        encryptSubject,
        encryptBody,
        event.contacts.first,
        event.isKeyBased,
        event.lifeTime.toHours(),
      );


    } catch (e) {
      if (e is WebMailApiError) {
        yield ErrorState(e.message);
      } else {
        yield ErrorState("error_unknown");
      }
      return;
    }

    if (event.isKeyBased) {
      encryptSubject =
      await _pgpEncrypt(encryptSubject, event.contacts, event.useSign ? event.password : null);
      encryptBody =
      await _pgpEncrypt(encryptBody, event.contacts, event.useSign ? event.password : null);
    }
    yield Encrypted(
      encryptSubject,
      encryptBody,
      link,
      event.isKeyBased,
      password,
    );
  }

  Future<String> _encryptSymmetric(String text, String password) {
    return _pgpWorker.encryptSymmetric(text, password);
  }

  Future<String> _pgpEncrypt(String text, List<String> recipients, String password) {
    return _pgpWorker.encryptDecrypt(aliasOrIdentity.mail, recipients).encrypt(text, password);
  }
}
