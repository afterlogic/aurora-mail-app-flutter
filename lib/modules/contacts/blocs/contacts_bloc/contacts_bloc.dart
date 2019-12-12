import 'dart:async';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/contacts_repository.dart';
import 'package:aurora_mail/utils/api_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

import './bloc.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final String apiUrl;
  final String token;
  final int userId;
  final AppDatabase appDatabase;

  ContactsRepository _repo;

  ContactsBloc({
    @required this.apiUrl,
    @required this.token,
    @required this.userId,
    @required this.appDatabase,
  }) {
    _repo = ContactsRepository(
      token: token,
      apiUrl: apiUrl,
      appDB: appDatabase,
      userServerId: userId,
    );
  }

  @override
  ContactsState get initialState => ContactsState();

  @override
  Stream<ContactsState> mapEventToState(ContactsEvent event) async* {
    if (event is GetContacts) _getContacts(event);
  }

  Stream<ContactsState> _getContacts(GetContacts event) async* {
    _repo.watchContactsStorages().listen((storages) {
      storages;
    }, onError: (err) {
      state.copyWith(error: formatError(err, null));
    });
  }
}
