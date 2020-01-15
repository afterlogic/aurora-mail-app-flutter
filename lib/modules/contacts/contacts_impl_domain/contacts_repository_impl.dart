import 'dart:async';

import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/contacts_repository.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/contacts_config.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/diff_calculator.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/contacts_db_service.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/network/contacts_network_service.dart';
import 'package:aurora_mail/utils/api_utils.dart';
import 'package:flutter/widgets.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

class ContactsRepositoryImpl implements ContactsRepository {
  final int userServerId;

  final _syncQueue = new List<int>();

  ContactsNetworkService _network;
  ContactsDbService _db;

  final _storagesCtrl = new StreamController<List<ContactsStorage>>();
  final _groupCtrl = new StreamController<List<ContactsGroup>>();

  StreamController<List<int>> _currentlySyncingStorageCtrl;

  ContactsRepositoryImpl({
    @required String apiUrl,
    @required String token,
    @required this.userServerId,
    @required AppDatabase appDB,
  }) {
    final module = new WebMailApi(
      moduleName: WebMailModule.contacts,
      apiUrl: apiUrl,
      token: token,
    );

    _network = new ContactsNetworkService(module);
    _db = new ContactsDbService(appDB);

    _currentlySyncingStorageCtrl = new StreamController<List<int>>(onListen: () {
      _currentlySyncingStorageCtrl.add(_syncQueue.isEmpty ? [] : _syncQueue);
    });
  }

  @override
  Stream<List<int>> get currentlySyncingStorage => _currentlySyncingStorageCtrl.stream;

  @override
  Stream<List<Contact>> watchContactsFromStorage(ContactsStorage storage) {
    return _db.watchContactsFromStorage(userServerId, storage);
  }

  @override
  Stream<List<Contact>> watchContactsFromGroup(ContactsGroup group) {
    return _db.watchContactsFromGroup(userServerId, group);
  }

  @override
  Stream<List<Contact>> watchAllContacts() {
    return _db.watchAllContacts(userServerId);
  }

  @override
  Stream<List<ContactsGroup>> watchContactsGroups() {
    _db.getGroups(userServerId).then((groups) async {
      if (groups.isNotEmpty) {
        _groupCtrl.add(groups);
      }

      final groupsFromServer = await _network.getGroups();
      _db.addGroups(groupsFromServer);
      _groupCtrl.add(groupsFromServer);
    });
    return _groupCtrl.stream;
  }

  @override
  Stream<List<ContactsStorage>> watchContactsStorages() {
    _db.getStorages(userServerId).then((storagesFromDb) async {
      // return currently syncing storage for updating UI
      _currentlySyncingStorageCtrl.add(
          storagesFromDb.map((s) => s.sqliteId).toList());

      try {
        List<ContactsStorage> storagesToUpdate;
        if (storagesFromDb.isNotEmpty) {
          _storagesCtrl.add(storagesFromDb);
          storagesToUpdate = await getStoragesToUpdate(storagesFromDb);
        } else {
          storagesToUpdate = await _network.getContactStorages();
          // store now to update later
          await _db.addStorages(storagesToUpdate, userServerId);
        }

        if (storagesToUpdate.isEmpty) {
          // return currently syncing storage for updating UI
          _currentlySyncingStorageCtrl.add([]);
          return;
        }

        await updateContactsInfo(storagesToUpdate);

        final updatedStorages = await _db.getStorages(userServerId);

        _storagesCtrl.add(updatedStorages);

        final storagesIdsToSync =
            updatedStorages.map((s) => s.sqliteId).toList();

        getContactsBodies(storagesIdsToSync);
      } catch (err, s) {
        _storagesCtrl.addError(formatError(err, s));
      }
    }).catchError((err) => _storagesCtrl.addError(formatError(err, null)));

    return _storagesCtrl.stream;
  }

  @override
  Future<List<Contact>> getSuggestionContacts(String pattern) async {
//    final storages = [StorageNames.collected, StorageNames.personal];

    final contacts = await _db.getContacts(
      userServerId,
      pattern: pattern,
    );

    contacts.sort((c1, c2) => c2.ageScore.compareTo(c1.ageScore));
    return contacts.take(COMPOSE_TYPE_AHEAD_ITEMS_NUMBER).toList();
  }

  @override
  Future<void> addContact(Contact contact) async {
    final newContact = await _network.addContact(contact);
    final newContactInfo = new ContactInfoItem(
      uuid: newContact.uuid,
      storage: newContact.storage,
      eTag: newContact.eTag,
      hasBody: true,
      needsUpdate: true,
    );
    final storages = await _db.getStorages(userServerId);
    final storage = storages.firstWhere((s) => s.id == newContact.storage);
    final storageToUpdate = storage.copyWith(contactsInfo: [...storage.contactsInfo, newContactInfo]);
    await Future.wait([
      _db.updateStorages([storageToUpdate], userServerId),
      _db.addContacts([newContact]),
    ]);
  }

  @override
  Future<void> editContact(Contact contact) async {
    await _network.editContact(contact);
    await _db.updateContacts([contact]);
  }

  @override
  Future<void> deleteContacts(List<Contact> contacts) async {
    final uuids = contacts.map((c) => c.uuid).toList();
    final futures = [_db.deleteContacts(uuids), _network.deleteContacts(uuids)];

    final storages = await _db.getStorages(userServerId);
    contacts.forEach((c) {
      final storage = storages.firstWhere((s) => s.id == c.storage);
      final updatedInfo = storage.contactsInfo..removeWhere((i) => i.uuid == c.uuid);
      final storageToUpdate = storage.copyWith(contactsInfo: updatedInfo);
      futures.add(_db.updateStorages([storageToUpdate], userServerId));
    });

    await Future.wait(futures);
  }

  @override
  Future<void> shareContacts(List<Contact> contact) async {
    final uuids = contact.map((c) {
      assert(c.storage == StorageNames.personal);
      return c.uuid;
    }).toList();

    _db.deleteContacts(uuids);
    await _network.updateSharedContacts(uuids);
  }

  @override
  Future<void> unshareContacts(List<Contact> contact) async {
    final uuids = contact.map((c) {
      assert(c.storage == StorageNames.shared);
      return c.uuid;
    }).toList();

    _db.deleteContacts(uuids);
    await _network.updateSharedContacts(uuids);
  }

  Future<void> addContactsToGroup(ContactsGroup group, List<Contact> contacts) async {
    final uuids = contacts.map((c) => c.uuid).toList();
    await _network.addContactsToGroup(group.uuid, uuids);

    final updatedContacts = contacts.map((c) {
      return c.copyWith(groupUUIDs: [...c.groupUUIDs, group.uuid]);
    }).toList();

    await _db.updateContacts(updatedContacts);
  }

  Future<void> removeContactsFromGroup(ContactsGroup group, List<Contact> contacts) async {
    final uuids = contacts.map((c) => c.uuid).toList();
    await _network.removeContactsFromGroup(group.uuid, uuids);

    final updatedContacts = contacts.map((c) {
      return c.copyWith(groupUUIDs: c.groupUUIDs.where((id) => id != group.uuid).toList());
    }).toList();

    await _db.updateContacts(updatedContacts);
  }

  @override
  Future<void> addGroup(ContactsGroup group) async {
    final groupWithId = await _network.createGroup(group);

    await _db.addGroups([groupWithId]);
    await _updateGroup();
  }

  @override
  Future<bool> editGroup(ContactsGroup group) async {
    final success = await _network.updateGroup(group);
    if (!success) {
      return false;
    }
    await _db.editGroups([group]);
    await _updateGroup();
    return true;
  }

  @override
  Future<bool> deleteGroup(ContactsGroup group) async {
    final success = await _network.deleteGroup(group);
    if (!success) {
      return false;
    }
    await _db.deleteGroups([group.uuid]);
    await _updateGroup();
    return true;
  }

  void _updateGroup() async {
    final updatedGroups = await _db.getGroups(userServerId);
    _groupCtrl.add(updatedGroups);
  }

  Future<List<ContactsStorage>> getStoragesToUpdate(
      List<ContactsStorage> storagesFromDb) async {
    final storagesFromNetwork = await _network.getContactStorages();

    final calcResult = await ContactsDiffCalculator.calculateStoragesDiffAsync(
        storagesFromDb, storagesFromNetwork);

    final storageIdsToDelete =
        calcResult.deletedStorages.map((s) => s.sqliteId).toList();

    await Future.wait([
      _db.addStorages(calcResult.addedStorages, userServerId),
      _db.deleteStorages(storageIdsToDelete),
    ]);

    return [...calcResult.updatedStorages, ...calcResult.addedStorages];
  }

  Future<void> updateContactsInfo(List<ContactsStorage> storages) async {
    final futures = new List<Future<ContactsStorage>>();

    storages.forEach((s) => futures.add(getStoragesWithUpdatedInfo(s)));
    final storagesToUpdate = await Future.wait(futures);

    await _db.updateStorages(storagesToUpdate, userServerId);
  }

  Future<ContactsStorage> getStoragesWithUpdatedInfo(ContactsStorage s) async {
    final infos = await _network.getContactsInfo(s);

    if (s.contactsInfo == null) {
      return new ContactsStorage(
          id: s.id,
          contactsInfo: infos,
          sqliteId: s.sqliteId,
          cTag: s.cTag,
          display: s.display,
          name: s.name);
    } else {
      final calcResult = await ContactsDiffCalculator.calculateContactsInfoDiffAsync(s.contactsInfo, infos);

      final infosToUpdate = new List<ContactInfoItem>.from(s.contactsInfo);

      infosToUpdate
        ..removeWhere((i) => calcResult.deletedContacts.contains(i.uuid))
        ..removeWhere((i) => calcResult.updatedContacts
            .where((j) => j.uuid == i.uuid)
            .isNotEmpty);

      infosToUpdate.addAll(calcResult.addedContacts);
      infosToUpdate.addAll(calcResult.updatedContacts);

      await _db.deleteContacts(calcResult.deletedContacts);

      return new ContactsStorage(
        id: s.id,
        contactsInfo: infosToUpdate,
        sqliteId: s.sqliteId,
        cTag: s.cTag,
        display: s.display,
        name: s.name,
      );
    }
  }

  Future<void> getContactsBodies(List<int> storagesSqliteIds) async {
    _syncQueue.removeWhere((i) => storagesSqliteIds.contains(i));
    _syncQueue.insertAll(0, storagesSqliteIds);

    // return currently syncing storage for updating UI
    _currentlySyncingStorageCtrl.add(_syncQueue);

    if (_syncQueue.isEmpty) return;

    final storages = await _db.getStorages(userServerId);
    final storageToSync = storages.firstWhere((i) => i.sqliteId == _syncQueue[0]);

    final uuidsToFetch = _takeChunkForAdd(storageToSync.contactsInfo);
    final uuidsToUpdate = _takeChunkForUpdate(storageToSync.contactsInfo);

    if (uuidsToFetch.isEmpty && uuidsToUpdate.isEmpty) {
      _syncQueue.removeAt(0);
    } else {
      final result = await Future.wait([
        _network.getContactsByUids(storageToSync, uuidsToFetch),
        _network.getContactsByUids(storageToSync, uuidsToUpdate),
      ]);
      final newContacts = result[0];
      final updatedContacts = result[1];

      storageToSync.contactsInfo.forEach((i) {
        if (newContacts.where((c) => c.uuid == i.uuid).isNotEmpty) {
          i.hasBody = true;
        }
        if (updatedContacts.where((c) => c.uuid == i.uuid).isNotEmpty) {
          i.needsUpdate = false;
        }
      });

      await Future.wait([
        _db.updateStorages([storageToSync], userServerId),
        _db.addContacts(newContacts),
        _db.updateContacts(updatedContacts),
      ]);
    }

    getContactsBodies([]);
  }

  // returns list of uuids to load
  List<String> _takeChunkForAdd(List<ContactInfoItem> infos) {
    final uids = new List<String>();
    int iteration = 0;

    infos.where((i) => i.hasBody == false).forEach((i) {
      if (iteration < CONTACTS_PER_CHUNK) {
        uids.add(i.uuid);
        iteration++;
      }
    });

    assert(iteration <= CONTACTS_PER_CHUNK);

    return uids;
  }

  // returns list of uuids to load
  List<String> _takeChunkForUpdate(List<ContactInfoItem> infos) {
    final uids = new List<String>();
    int iteration = 0;

    infos.where((i) => i.needsUpdate == true).forEach((i) {
      if (iteration < CONTACTS_PER_CHUNK) {
        uids.add(i.uuid);
        iteration++;
      }
    });

    assert(iteration <= CONTACTS_PER_CHUNK);

    return uids;
  }

  @override
  void dispose() {
    _storagesCtrl.close();
  }
}