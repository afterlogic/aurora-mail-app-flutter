import 'dart:async';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/contacts_groups_event.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/contacts_storages_event.dart';
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
    if (event is SelectStorageGroup) yield* _selectStorageGroup(event);
    if (event is AddStorages) yield state.copyWith(storages: event.storages);
    if (event is AddGroups) yield state.copyWith(groups: event.groups);
    if (event is AddGroup) yield* _addGroup(event);
    if (event is UpdateGroup) yield* _updateGroup(event);
    if (event is DeleteGroup) yield* _deleteGroup(event);
    if (event is AddContacts) yield state.copyWith(contacts: event.contacts);
    if (event is SetSelectedStorage) yield state.copyWith(selectedStorage: event.storageSqliteId, selectedGroup: "");
    if (event is SetSelectedGroup) yield state.copyWith(selectedStorage: -1, selectedGroup: event.groupUuid);
    if (event is SetCurrentlySyncingStorages) yield state.copyWith(currentlySyncingStorage: event.storageSqliteIds);
    if (event is AddError) yield state.copyWith(error: event.error);
  }

  Stream<ContactsState> _getContacts(GetContacts event) async* {
    _repo.watchContactsStorages().listen((storages) {
      if (state.storages == null) {
        add(SelectStorageGroup(storage: storages[0]));
      }
      add(AddStorages(storages));
    }, onError: (err) {
      add(AddError(formatError(err, null)));
    });

    _repo.watchContactsGroups().listen((groups) {
      add(AddGroups(groups));
    }, onError: (err) {
      add(AddError(formatError(err, null)));
    });

    _repo.currentlySyncingStorage.listen((List<int> ids) {
      add(SetCurrentlySyncingStorages(ids));
    });
  }

  Stream<ContactsState> _selectStorageGroup(SelectStorageGroup event) async* {
    if (event.storage != null) {
      _repo.watchContactsFromStorage(event.storage).listen((contacts) {
        add(AddContacts(contacts));
        add(SetSelectedStorage(event.storage.sqliteId));
      }, onError: (err) {
        add(AddError(formatError(err, null)));
      });
    } else {
      _repo.watchContactsFromGroup(event.group).listen((contacts) {
        add(AddContacts(contacts));
        add(SetSelectedGroup(event.group.uuid));
      }, onError: (err) {
        add(AddError(formatError(err, null)));
      });
    }
  }

  Stream<ContactsState> _addGroup(AddGroup event) async* {
    _repo.addGroup(event.group)
        .catchError((err) => add(AddError(formatError(err, null))));
  }

  Stream<ContactsState> _deleteGroup(DeleteGroup event) async* {
    add(SelectStorageGroup(storage: state.storages[0]));
    _repo.deleteGroup(event.group)
        .catchError((err) => add(AddError(formatError(err, null))));
  }

  Stream<ContactsState> _updateGroup(UpdateGroup event) async* {
    _repo.editGroup(event.group);
//        .catchError((err) => add(AddError(formatError(err, null))));
  }
}
