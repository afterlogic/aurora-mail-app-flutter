import 'dart:async';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/inject/app_inject.dart';
import 'package:aurora_mail/models/alias_or_identity.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/mappers/contact_mapper.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/contacts/contacts_dao.dart';
import 'package:aurora_mail/modules/mail/screens/compose/self_destructing/model/contact_with_key.dart';
import 'package:bloc/bloc.dart';
import 'package:crypto_storage/crypto_storage.dart';

import 'bloc.dart';

class SelfDestructingBloc
    extends Bloc<SelfDestructingEvent, SelfDestructingState> {
  final User user;
  final AliasOrIdentity aliasOrIdentity;
  final _contactsDao = ContactsDao(DBInstances.appDB);
  final CryptoStorage cryptoStorage = AppInjector.instance.cryptoStorage();

  SelfDestructingBloc(
    this.user,
    this.aliasOrIdentity,
  );

  @override
  SelfDestructingState get initialState => ProgressState();

  @override
  Stream<SelfDestructingState> mapEventToState(
    SelfDestructingEvent event,
  ) async* {
    if (event is LoadContacts) yield* loadContacts();
    if (event is LoadKey) yield* loadKey();
  }

  Stream<SelfDestructingState> loadContacts() async* {
    final contacts =
        ContactMapper.fromDB(await _contactsDao.getContacts(user.localId));
    final keys = Map.fromEntries((await cryptoStorage.getPgpKeys(false))
        .map((item) => MapEntry(item.mail, item)));

    final recipientWithKey = <ContactWithKey>[];

    for (var contact in contacts) {
      final key = keys[contact.viewEmail];
      keys.remove(contact.viewEmail);
      recipientWithKey.add(ContactWithKey(contact, key));
    }
    for (var key in keys.values) {
      recipientWithKey.add(ContactWithKey(null, key));
    }
    yield LoadedContacts(recipientWithKey);
  }

  Stream<SelfDestructingState> loadKey() async* {
    final key = await cryptoStorage.getPgpKey(aliasOrIdentity.mail, true);
    yield LoadedKey(key);
  }
}
