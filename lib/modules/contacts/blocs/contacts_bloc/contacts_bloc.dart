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
    if (event is GetContacts) yield* _getContacts(event);
    if (event is SelectStorage) yield* _selectStorage(event);
    if (event is AddStorages) yield state.copyWith(storages: event.storages);
    if (event is AddContacts) yield state.copyWith(contacts: event.contacts);
    if (event is SetSelectedStorage) yield state.copyWith(selectedStorage: event.storageSqliteId);
    if (event is SetCurrentlySyncingStorage) yield state.copyWith(currentlySyncingStorage: event.storageSqliteIds);
    if (event is AddError) yield state.copyWith(error: event.error);
  }

  Stream<ContactsState> _getContacts(GetContacts event) async* {
    _repo.watchContactsStorages().listen((storages) {
      if (state.storages == null) {
        add(SelectStorage(storages[0]));
      }
      add(AddStorages(storages));
    }, onError: (err) {
      add(AddError(formatError(err, null)));
    });

    _repo.currentlySyncingStorage.listen((List<int> ids) {
      add(SetCurrentlySyncingStorage(ids));
    });
  }

  Stream<ContactsState> _selectStorage(SelectStorage event) async* {
    _repo.watchContacts(event.storage).listen((contacts) {
      add(AddContacts(contacts));
      add(SetSelectedStorage(event.storage.sqliteId));
    }, onError: (err) {
      add(AddError(formatError(err, null)));
    });
  }
}
