import 'dart:async';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/inject/app_inject.dart';
import 'package:aurora_mail/models/alias_or_identity.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/mappers/contact_mapper.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/contacts/contacts_dao.dart';
import 'package:aurora_mail/modules/mail/repository/pgp_api.dart';
import 'package:aurora_mail/modules/mail/screens/compose/self_destructing/model/contact_with_key.dart';
import 'package:aurora_mail/utils/identity_util.dart';
import 'package:bloc/bloc.dart';
import 'package:crypto_storage/crypto_storage.dart';
import 'package:crypto_worker/crypto_worker.dart';
import 'package:webmail_api_client/webmail_api_error.dart';
import '../model/life_time.dart';
import 'bloc.dart';
import 'package:aurora_mail/utils/crypto_util.dart';

class SelfDestructingBloc
    extends Bloc<SelfDestructingEvent, SelfDestructingState> {
  final User user;
  final PgpApi pgpApi;
  final AliasOrIdentity aliasOrIdentity;
  final _contactsDao = ContactsDao(DBInstances.appDB);
  final CryptoStorage _cryptoStorage = AppInjector.instance.cryptoStorage();
  final PgpWorker _pgpWorker = AppInjector.instance.pgpWorker();
  final String subject;
  final String body;

  SelfDestructingBloc(this.user,
      Account account,
      this.aliasOrIdentity,
      this.subject,
      this.body,) : pgpApi = PgpApi(user, account);

  @override
  SelfDestructingState get initialState => InitState();

  @override
  Stream<SelfDestructingState> mapEventToState(
      SelfDestructingEvent event,) async* {
    if (event is LoadKey) yield* _loadKey(event);
    if (event is EncryptEvent) yield* _encrypt(event);
  }

  Future<ContactWithKey> _loadContacts(IdentityView identityView) async {
    final email = identityView.email;
    final name = identityView.name.replaceAll("\"", "");
    final contact = Contact(
        viewEmail: email,
        fullName: name,
        davContactsVCardUid: null,
        frequency: null,
        entityId: null,
        uuid: null,
        groupUUIDs: <String>[],
        eTag: null,
        useFriendlyName: null,
        davContactsUid: null,
        storage: null,
        uuidPlusStorage: null,
        dateModified: null,
        idTenant: null,
        userLocalId: null,
        idUser: null,
        pgpPublicKey: null,
    );

    final key = await _cryptoStorage.getPgpKey(email, false);

    return ContactWithKey(contact, key);
  }

  Stream<SelfDestructingState> _loadKey(LoadKey event) async* {
    final identityView = IdentityView.fromString(event.contact);
    final contacts = await _loadContacts(identityView);
    final key = await _cryptoStorage.getPgpKey(aliasOrIdentity.mail, true);
    final sender = Contact(
      viewEmail: aliasOrIdentity.mail,
      fullName: aliasOrIdentity.name,
      davContactsVCardUid: null,
      frequency: null,
      entityId: null,
      uuid: null,
      groupUUIDs: <String>[],
      eTag: null,
      useFriendlyName: null,
      davContactsUid: null,
      storage: null,
      uuidPlusStorage: null,
      dateModified: null,
      idTenant: null,
      userLocalId: null,
      idUser: null,
      pgpPublicKey: null,
    );
    yield LoadedKey(ContactWithKey(sender, key), contacts);
  }

  Stream<SelfDestructingState> _encrypt(EncryptEvent event) async* {
    yield ProgressState();
    var encryptSubject = subject;
    var encryptBody = body;
    var password = "";
    var link = "";
    var message = event.messageTemplate;

    if (!event.isKeyBased) {
      try {
        password = CryptoUtil.createSymmetricKey();

        encryptSubject = subject;
        encryptBody = await _encryptSymmetric(body, password);
      } catch (e) {
        yield ErrorState("error_unknown");
        return;
      }
    } else {
      try {
        encryptBody = await _pgpEncrypt(
          body,
          [event.contact.contact.viewEmail],
          event.useSign ? event.password : null,
        );
      } catch (e) {
        yield ErrorState("error_unknown");
        return;
      }
    }

    try {
      link = await pgpApi.createSelfDestructLink(
        encryptSubject,
        encryptBody,
        event.contact.contact.viewEmail,
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

    message = message.replaceFirst("{link}", link);
    if (event.contact.key != null) {
      try {
        message = message.replaceFirst("{password}", password);
        message = await _pgpEncrypt(
          message,
          [event.contact.contact.viewEmail],
          event.useSign ? event.password : null,
        );
      } catch (e) {
        if (e is PgpInvalidSign) {
          yield ErrorState("error_pgp_invalid_password");
        } else {
          yield ErrorState("error_unknown");
        }
        return;
      }
    }

    yield Encrypted(event.isKeyBased, password, message, event.contact, link);
  }

  Future<String> _encryptSymmetric(String text, String password) {
    return _pgpWorker.encryptSymmetric(text, password);
  }

  Future<String> _pgpEncrypt(String text, List<String> recipients,
      String password) {
    return _pgpWorker
        .encryptDecrypt(aliasOrIdentity.mail, recipients)
        .encrypt(text, password);
  }
}
