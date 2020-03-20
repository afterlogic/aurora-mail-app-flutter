import 'dart:async';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/inject/app_inject.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/contacts/contacts_dao.dart';
import 'package:bloc/bloc.dart';
import 'package:crypto_storage/crypto_storage.dart';

import './bloc.dart';

class SelfDestructingBloc
    extends Bloc<SelfDestructingEvent, SelfDestructingState> {
  final User user;
  final Account account;
  final _contactsDao = ContactsDao(DBInstances.appDB);
  final CryptoStorage cryptoStorage = AppInjector.instance.cryptoStorage();

  SelfDestructingBloc(
    this.user,
    this.account,
  );

  @override
  SelfDestructingState get initialState => ProgressState();

  @override
  Stream<SelfDestructingState> mapEventToState(
    SelfDestructingEvent event,
  ) async* {
    if (event is LoadContacts) yield* loadContacts();
  }

  Stream<SelfDestructingState> loadContacts() async* {
    final contacts=await _contactsDao.getContacts(user.localId);
    for (var contact in contacts) {
//      cryptoStorage.
    }
  }
}
