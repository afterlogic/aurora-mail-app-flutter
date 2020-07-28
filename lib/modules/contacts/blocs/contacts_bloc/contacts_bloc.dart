import 'dart:async';

import 'package:aurora_mail/background/background_helper.dart';
import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/inject/app_inject.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/events/contacts_groups_event.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/events/contacts_storages_event.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/contacts_repository.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
import 'package:aurora_mail/modules/contacts/screens/contact_edit/dialog/confirm_edit_dialog.dart';
import 'package:aurora_mail/utils/api_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:crypto_model/crypto_model.dart';
import 'package:crypto_worker/crypto_worker.dart';
import 'package:flutter/widgets.dart';

import './bloc.dart';
import 'contacts_state_reducer.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final User user;
  final AppDatabase appDatabase;
  final PgpWorker pgpWorker;
  ContactsRepository _repo;
  String searchPattern;
  StreamSubscription<List<Contact>> _contactsSub;
  StreamSubscription<List<ContactsStorage>> _storagesSub;
  StreamSubscription<List<ContactsGroup>> _groupsSub;
  StreamSubscription<List<int>> _syncingStoragesSub;

  ContactsBloc({
    @required this.user,
    @required this.appDatabase,
  }) : pgpWorker = AppInjector.instance.pgpWorker() {
    _repo = ContactsRepository(
      appDB: appDatabase,
      user: user,
    );
    BackgroundHelper.addOnEndAlarmObserver(false, _doOnAlarm);
  }

  @override
  Future<void> close() async {
    BackgroundHelper.removeOnEndAlarmObserver(_doOnAlarm);
    _contactsSub?.cancel();
    _storagesSub?.cancel();
    _groupsSub?.cancel();
    _syncingStoragesSub?.cancel();
    super.close();
  }

  @override
  ContactsState get initialState => ContactsState();

  @override
  Stream<ContactsState> mapEventToState(ContactsEvent event) async* {
    if (event is SearchContacts) yield* _searchContacts(event);
    if (event is GetContacts) yield* _getContacts(event);
    if (event is CreateContact) yield* _createContact(event);
    if (event is UpdateContact) yield* _updateContact(event);
    if (event is DeleteContacts) yield* _deleteContacts(event);
    if (event is ShareContacts) yield* _shareContacts(event);
    if (event is UnshareContacts) yield* _unshareContacts(event);
    if (event is AddContactsToGroup) yield* _addContactsToGroup(event);
    if (event is RemoveContactsFromGroup)
      yield* _removeContactsFromGroup(event);
    if (event is SelectStorageGroup) yield* _selectStorageGroup(event);
    if (event is CreateGroup) yield* _addGroup(event);
    if (event is UpdateGroup) yield* _updateGroup(event);
    if (event is DeleteGroup) yield* _deleteGroup(event);
    yield* reduceState(state, event);
  }

  _doOnAlarm(bool hasUpdate) {
    add(GetContacts());
  }

  Future<Contact> getContact(int id) async {
    return _repo.getContactById(id);
  }

  Stream<ContactsState> _searchContacts(SearchContacts event) async* {
    searchPattern = event.search;

    yield* _selectStorageGroup(SelectStorageGroup.raw(
        storageId: state.selectedStorage, groupId: state.selectedGroup));
  }

  Stream<ContactsState> _getContacts(GetContacts event) async* {
    print("_getContacts");
    try {
      _storagesSub = _repo.watchContactsStorages().listen((storages) {
        if (state.storages == null) {
          final storage = storages
              .firstWhere((s) => s.name == StorageNames.personal, orElse: null);
          add(SelectStorageGroup(storage: storage));
        }

        add(ReceivedStorages(storages));
      }, onError: (err) {
        add(AddError(formatError(err, null)));
      });
    } catch (e) {
      print(e);
    }
    try {
      _groupsSub = _repo.watchContactsGroups().listen((groups) {
        add(ReceivedGroups(groups));
      }, onError: (err) {
        add(AddError(formatError(err, null)));
      });
    } catch (e) {
      print(e);
    }
    try {
      _syncingStoragesSub =
          _repo.currentlySyncingStorage.listen((List<int> ids) {
        add(SetCurrentlySyncingStorages(ids));
      });
    } catch (e) {
      print(e);
    }
    event.completer?.complete();
  }

  Stream<ContactsState> _selectStorageGroup(SelectStorageGroup event) async* {
    _contactsSub?.cancel();
    if (event.storageId != null) {
      add(SetSelectedStorage(event.storageId));
      _contactsSub = _repo
          .watchContactsFromStorage(event.storageId, searchPattern)
          .listen((contacts) {
        add(ReceivedContacts(contacts));
      }, onError: (err) {
        add(AddError(formatError(err, null)));
      });
    } else if (event.groupId != null) {
      add(SetGroupSelected(event.groupId));
      _contactsSub = _repo
          .watchContactsFromGroup(event.groupId, searchPattern)
          .listen((contacts) {
        add(ReceivedContacts(contacts));
      }, onError: (err) {
        add(AddError(formatError(err, null)));
      });
    } else {
      add(SetAllVisibleContactsSelected());
      _contactsSub = _repo.watchAllContacts(searchPattern).listen((contacts) {
        add(ReceivedContacts(contacts));
      }, onError: (err) {
        add(AddError(formatError(err, null)));
      });
    }
  }

  Stream<ContactsState> _createContact(CreateContact event) async* {
    _repo
        .addContact(event.contact)
        .catchError((err) => add(AddError(formatError(err, null))))
        .whenComplete(() {
      if (event.completer != null) add(GetContacts(completer: event.completer));
    });
  }

  Stream<ContactsState> _updateContact(UpdateContact event) async* {
    _repo.editContact(event.contact).then((value) async {
      if (event.freeKey != null) {
        await _repo.deleteContactKey(event.contact.viewEmail);
        if (event.freeKey == FreeKeyAction.Import) {
          add(ReImport(event.contact.pgpPublicKey));
        }
      } else {
        if (event.updateKey) {
          if (event.contact.pgpPublicKey == null) {
            await _repo.deleteContactKey(event.contact.viewEmail);
          } else {
            await _repo.addKeyToContacts([event.contact]);
          }
        }
      }
    }).catchError((err) => add(AddError(formatError(err, null))));
  }

  Stream<ContactsState> _deleteContacts(DeleteContacts event) async* {
    _repo
        .deleteContacts(event.contacts)
        .catchError((err) => add(AddError(formatError(err, null))));
  }

  Stream<ContactsState> _shareContacts(ShareContacts event) async* {
    _repo
        .shareContacts(event.contacts)
        .catchError((err) => add(AddError(formatError(err, null))))
        .whenComplete(() {
      add(GetContacts());
    });
  }

  Stream<ContactsState> _unshareContacts(UnshareContacts event) async* {
    _repo
        .unshareContacts(event.contacts)
        .catchError((err) => add(AddError(formatError(err, null))))
        .whenComplete(() {
      add(GetContacts());
    });
  }

  Stream<ContactsState> _addContactsToGroup(AddContactsToGroup event) async* {
    _repo
        .addContactsToGroup(event.group, event.contacts)
        .catchError((err) => add(AddError(formatError(err, null))));
  }

  Stream<ContactsState> _removeContactsFromGroup(
      RemoveContactsFromGroup event) async* {
    _repo
        .removeContactsFromGroup(event.group, event.contacts)
        .catchError((err) => add(AddError(formatError(err, null))));
  }

  Stream<ContactsState> _addGroup(CreateGroup event) async* {
    _repo
        .addGroup(event.group)
        .catchError((err) => add(AddError(formatError(err, null))));
  }

  Stream<ContactsState> _deleteGroup(DeleteGroup event) async* {
    add(SelectStorageGroup());
    _repo
        .deleteGroup(event.group)
        .catchError((err) => add(AddError(formatError(err, null))));
  }

  Stream<ContactsState> _updateGroup(UpdateGroup event) async* {
    _repo
        .editGroup(event.group)
        .catchError((err) => add(AddError(formatError(err, null))));
  }

  Future<List<Contact>> getTypeAheadContacts(String pattern) {
    return _repo.getSuggestionContacts(pattern);
  }

  Future<PgpKey> getKeyInfo(String key) async {
    final keyInfo = await pgpWorker.parseKey(key);
    if (keyInfo.isNotEmpty) {
      return keyInfo.first;
    }
    return null;
  }
}
