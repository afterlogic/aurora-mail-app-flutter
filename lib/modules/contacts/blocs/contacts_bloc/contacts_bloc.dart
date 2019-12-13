import 'dart:async';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/contacts_repository.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
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
    if (event is AddStorages) yield* _addStorages(event);
    if (event is AddContacts) yield* _addContacts(event);
    if (event is SetCurrentlySyncingStorage) yield* _setCurrentlySyncingStorage(event);
  }

  Stream<ContactsState> _getContacts(GetContacts event) async* {
    _repo.watchContactsStorages().listen((storages) {
      if (state.storages == null) {
        add(SelectStorage(storages[0]));
      }
      add(AddStorages(storages));
    }, onError: (err) {
      state.copyWith(error: formatError(err, null));
    });

    _repo.currentlySyncingStorage.listen((int id) {
      add(SetCurrentlySyncingStorage(id));
    });
  }

  Stream<ContactsState> _selectStorage(SelectStorage event) async* {
    _repo.watchContacts(event.storage).listen((contacts) {
      add(AddContacts(contacts));
    }, onError: (err) {
      state.copyWith(error: formatError(err, null));
    });
  }

  Stream<ContactsState> _addStorages(AddStorages event) async* {
    yield state.copyWith(storages: event.storages);
  }

  Stream<ContactsState> _addContacts(AddContacts event) async* {
    yield state.copyWith(contacts: event.contacts);
  }

  Stream<ContactsState> _setCurrentlySyncingStorage(SetCurrentlySyncingStorage event) async* {
    yield state.copyWith(currentlySyncingStorage: event.storageSqliteId);
  }
}
