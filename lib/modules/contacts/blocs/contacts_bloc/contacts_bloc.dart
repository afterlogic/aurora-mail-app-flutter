//@dart=2.9
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
  })  : pgpWorker = AppInjector.instance.pgpWorker(),
        super(ContactsState()) {
    _repo = ContactsRepository(
      appDB: appDatabase,
      user: user,
    );
    BackgroundHelper.addOnEndAlarmObserver(false, _doOnAlarm);
    _initListeners();
  }

  _initListeners() {
    _storagesSub = _repo.contactsStorages.listen(
      _handleStoragesStream,
      onError: (err, _) => add(AddError(formatError(err, null))),
    );
    _groupsSub = _repo.contactsGroups.listen(
      _handleGroupsStream,
      onError: (err) => add(AddError(formatError(err, null))),
    );
    _syncingStoragesSub = _repo.syncingStorages.listen(
      _handleSyncingStoragesStream,
      onError: (err) => add(AddError(formatError(err, null))),
    );
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
  Stream<ContactsState> mapEventToState(ContactsEvent event) async* {
    if (event is SearchContacts) yield* _searchContacts(event);
    if (event is GetContacts) yield* _getContacts(event);
    if (event is CreateContact) yield* _createContact(event);
    if (event is UpdateContact) yield* _updateContact(event);
    if (event is UpdateContactPgpKey) yield* _updateContactPgpKey(event);
    if (event is DeleteContacts) yield* _deleteContacts(event);
    if (event is ImportVcf) yield* _importVcf(event);
    if (event is ShareContacts) yield* _shareContacts(event);
    if (event is UnshareContacts) yield* _unshareContacts(event);
    if (event is AddContactsToGroup) yield* _addContactsToGroup(event);
    if (event is RemoveContactsFromCurrentGroup)
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

  Future<List<Contact>> getContactsByEmail(String mail) async {
    return _repo.getContactsByEmail(mail);
  }

  Stream<ContactsState> _searchContacts(SearchContacts event) async* {
    searchPattern = event.search;

    yield* _selectStorageGroup(SelectStorageGroup.raw(
        storageId: state.selectedStorage, groupId: state.selectedGroup));
  }

  Stream<ContactsState> _getContacts(GetContacts event) async* {
    add(StartActivity('GetContacts'));
    try {
      final future1 = _repo.refreshStorages();
      final future2 = _repo.refreshGroups();
      await Future.wait([future1, future2]);
    } catch (err) {
      add(AddError(formatError(err, null)));
    }
    event.completer?.complete();
    add(StopActivity('GetContacts'));
  }

  void _handleStoragesStream(List<ContactsStorage> storages) {
    add(ReceivedStorages(storages));
    final needDefaultStorage = state.selectedStorage == null &&
        state.selectedGroup == null &&
        state.showAllVisibleContacts != true &&
        storages.isNotEmpty;
    if (needDefaultStorage) {
      final personalStorage = storages
          .firstWhere((s) => s.name == StorageNames.personal, orElse: null);
      add(SelectStorageGroup(storage: personalStorage));
    }
  }

  void _handleGroupsStream(List<ContactsGroup> groups) {
    add(ReceivedGroups(groups));
  }

  void _handleSyncingStoragesStream(List<int> ids) {
    add(SetCurrentlySyncingStorages(ids));
  }

  Stream<ContactsState> _selectStorageGroup(SelectStorageGroup event) async* {
    add(StartActivity('SelectStorageGroup'));
    _contactsSub?.cancel();
    if (event.storageId != null) {
      add(SetSelectedStorage(event.storageId));
      await _watchContactsFromStorage(event.storageId);
    } else if (event.groupId != null) {
      add(SetSelectedGroup(event.groupId));
      await _watchContactsFromGroup(event.groupId);
    } else {
      // if visible storage is only one - switch to it
      final visibleStorages = state.storages?.where((s) => s.display);
      if (visibleStorages?.length == 1) {
        add(SelectStorageGroup(storage: state.storages[0]));
        add(StopActivity('SelectStorageGroup'));
        return;
      }
      // else show storage "All contacts"
      add(SetAllVisibleContactsSelected());
      await _watchAllContacts();
    }
    add(GetContacts());
    add(StopActivity('SelectStorageGroup'));
  }

  Future<void> _watchContactsFromStorage(String storageId) async {
    final currentContacts =
        await _repo.getContacts(storages: [storageId], pattern: searchPattern);
    add(ReceivedContacts(currentContacts));
    _contactsSub = _repo
        .watchContactsFromStorage(storageId, searchPattern)
        .listen((contacts) {
      add(ReceivedContacts(contacts));
    }, onError: (err) {
      add(AddError(formatError(err, null)));
    });
  }

  Future<void> _watchContactsFromGroup(String groupUuid) async {
    final currentContacts =
        await _repo.getContacts(groupUuid: groupUuid, pattern: searchPattern);
    add(ReceivedContacts(currentContacts));
    _contactsSub = _repo
        .watchContactsFromGroup(groupUuid, searchPattern)
        .listen((contacts) {
      add(ReceivedContacts(contacts));
    }, onError: (err) {
      add(AddError(formatError(err, null)));
    });
  }

  Future<void> _watchAllContacts() async {
    final currentContacts = await _repo.getContacts(pattern: searchPattern);
    add(ReceivedContacts(currentContacts));
    _contactsSub = _repo.watchAllContacts(searchPattern).listen((contacts) {
      add(ReceivedContacts(contacts));
    }, onError: (err) {
      add(AddError(formatError(err, null)));
    });
  }

  Stream<ContactsState> _createContact(CreateContact event) async* {
    add(StartActivity('CreateContact'));
    _repo.addContact(event.contact).catchError((err) {
      add(AddError(formatError(err, null)));
      add(StopActivity('CreateContact'));
      return null;
    }).whenComplete(() {
      if (event.completer != null) add(GetContacts(completer: event.completer));
      add(StopActivity('CreateContact'));
    });
  }

  Stream<ContactsState> _updateContactPgpKey(UpdateContactPgpKey event) async* {
    try {
      if (event.contact.pgpPublicKey == null) {
        _repo.deleteContactKey(event.contact.viewEmail);
      } else {
        _repo.addKeyToContacts([event.contact]);
      }
    } catch (err, st) {
      add(AddError(formatError(err, st)));
    }
  }

  Stream<ContactsState> _updateContact(UpdateContact event) async* {
    add(StartActivity('UpdateContact'));
    _repo.editContact(event.contact).then((value) async {
      if (event.freeKey != null) {
        await _repo.deleteContactKey(event.contact.viewEmail);
        if (event.freeKey == FreeKeyAction.Import) {
          add(ReImport(event.contact.pgpPublicKey));
        }
      }
      add(StopActivity('UpdateContact'));
    }).catchError((err) {
      add(AddError(formatError(err, null)));
      add(StopActivity('UpdateContact'));
    });
  }

  Stream<ContactsState> _deleteContacts(DeleteContacts event) async* {
    add(StartActivity('DeleteContacts'));
    _repo
        .deleteContacts(event.contacts)
        .catchError((err) => add(AddError(formatError(err, null))));
    add(StopActivity('DeleteContacts'));
  }

  Stream<ContactsState> _shareContacts(ShareContacts event) async* {
    add(StartActivity('ShareContacts'));
    _repo.shareContacts(event.contacts).catchError((err) {
      add(AddError(formatError(err, null)));
      add(StopActivity('ShareContacts'));
    }).whenComplete(() {
      add(GetContacts());
      add(StopActivity('ShareContacts'));
    });
  }

  Stream<ContactsState> _unshareContacts(UnshareContacts event) async* {
    add(StartActivity('UnshareContacts'));
    _repo.unshareContacts(event.contacts).catchError((err) {
      add(AddError(formatError(err, null)));
      add(StopActivity('UnshareContacts'));
    }).whenComplete(() {
      add(GetContacts());
      add(StopActivity('UnshareContacts'));
    });
  }

  Stream<ContactsState> _addContactsToGroup(AddContactsToGroup event) async* {
    add(StartActivity('AddContactsToGroup'));
    await _repo
        .addContactsToGroup(event.groups, event.contacts)
        .catchError((err) => add(AddError(formatError(err, null))));
    add(StopActivity('AddContactsToGroup'));
  }

  Stream<ContactsState> _removeContactsFromGroup(
      RemoveContactsFromCurrentGroup event) async* {
    add(StartActivity('RemoveContactsFromGroup'));
    _repo
        .removeContactsFromGroup(
            state.groups.firstWhere((e) => e.uuid == state.selectedGroup),
            event.contacts)
        .catchError((err) => add(AddError(formatError(err, null))));
    add(StopActivity('RemoveContactsFromGroup'));
  }

  Stream<ContactsState> _addGroup(CreateGroup event) async* {
    add(StartActivity('CreateGroup'));
    final groupWithId = await _repo.addGroup(event.group).catchError((err) {
      add(AddError(formatError(err, null)));
      return null;
    });
    add(SelectStorageGroup(group: groupWithId));
    add(StopActivity('CreateGroup'));
  }

  Stream<ContactsState> _deleteGroup(DeleteGroup event) async* {
    add(StartActivity('DeleteGroup'));
    add(SelectStorageGroup());
    _repo.deleteGroup(event.group).catchError((err) {
      add(AddError(formatError(err, null)));
      return false;
    });
    add(StopActivity('DeleteGroup'));
  }

  Stream<ContactsState> _updateGroup(UpdateGroup event) async* {
    add(StartActivity('UpdateGroup'));
    _repo.editGroup(event.group).catchError((err) {
      add(AddError(formatError(err, null)));
      return false;
    });
    add(StopActivity('UpdateGroup'));
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

  Stream<ContactsState> _importVcf(ImportVcf event) async* {
    add(StartActivity('ImportVcf'));
    try {
      await _repo.importVcf(event.content);
      event.completer.complete();
    } catch (e) {
      event.completer.completeError(e);
    }
    add(StopActivity('ImportVcf'));
  }
}
