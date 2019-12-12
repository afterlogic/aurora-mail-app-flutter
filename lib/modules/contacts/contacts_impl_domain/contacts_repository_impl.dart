import 'dart:async';

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

  final _contactsCtrl = new StreamController<List<Contact>>();
  final _storagesCtrl = new StreamController<List<ContactsStorage>>();
  StreamController<int> _currentlySyncingStorageCtrl;

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

    _currentlySyncingStorageCtrl = new StreamController<int>(onListen: () {
      _currentlySyncingStorageCtrl.add(_syncQueue.isEmpty ? null : _syncQueue[0]);
    });
  }

  @override
  Stream<int> get currentlySyncingStorage =>
      _currentlySyncingStorageCtrl.stream;

  @override
  Stream<List<Contact>> watchContacts(ContactsStorage storage) {
    _db
        .getContacts(userServerId, storage)
        .then((contacts) => _contactsCtrl.add(contacts))
        .catchError((err) => _contactsCtrl.addError(formatError(err, null)));
    return _contactsCtrl.stream;
  }

  @override
  Stream<List<ContactsGroup>> watchContactsGroups() => null;

  @override
  Stream<List<ContactsStorage>> watchContactsStorages() {
    _db.getStorages(userServerId).then((storagesFromDb) async {
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

        await updateContactsInfo(storagesToUpdate);

        final updatedStorages = await _db.getStorages(userServerId);

        _storagesCtrl.add(updatedStorages);

        final storagesIdsToSync =
            updatedStorages.map((s) => s.sqliteId).toList();
        syncContacts(storagesIdsToSync);
      } catch (err, s) {
        _storagesCtrl.addError(formatError(err, s));
      }
    }).catchError((err) => _storagesCtrl.addError(formatError(err, null)));

    return _storagesCtrl.stream;
  }

  @override
  Future addGroup(ContactsGroup group) async {
    final groupWithId = await _network.addGroup(group);
    await _db.addGroups([groupWithId]);
    final updatedStorages = await _db.getStorages(userServerId);
    _storagesCtrl.add(updatedStorages);
  }

  @override
  Future<bool> editGroup(ContactsGroup group) async {
    final success = await _network.editGroup(group);
    if (!success) {
      return false;
    }
    await _db.editGroups([group]);
    final updatedStorages = await _db.getStorages(userServerId);
    _storagesCtrl.add(updatedStorages);
    return true;
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
      final calcResult =
          await ContactsDiffCalculator.calculateContactsInfoDiffAsync(
              s.contactsInfo, infos);

      final infosToUpdate = new List<ContactInfoItem>.from(s.contactsInfo);

      infosToUpdate
        ..removeWhere((i) => calcResult.deletedContacts.contains(i.uuid))
        ..removeWhere((i) => calcResult.updatedContacts
            .where((j) => j.uuid == i.uuid)
            .isNotEmpty);

      infosToUpdate.addAll(calcResult.addedContacts);
      infosToUpdate.addAll(calcResult.updatedContacts);

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

  Future<void> syncContacts(List<int> storagesSqliteIds) async {
    _syncQueue.removeWhere((i) => storagesSqliteIds.contains(i));
    _syncQueue.insertAll(0, storagesSqliteIds);

    // return currently syncing storage for updating UI
    _currentlySyncingStorageCtrl.add(_syncQueue.isEmpty ? null : _syncQueue[0]);

    if (_syncQueue.isEmpty) return;

    final storages = await _db.getStorages(userServerId);
    final storageToSync =
        storages.firstWhere((i) => i.sqliteId == _syncQueue[0]);

    final uuidsToFetch = _takeChunk(storageToSync.contactsInfo);

    if (uuidsToFetch.isEmpty) {
      _syncQueue.removeAt(0);
    } else {
      try {
        final contacts =
            await _network.getContactsByUids(storageToSync, uuidsToFetch);
        _contactsCtrl.add(contacts);
        storageToSync.contactsInfo.forEach((i) {
          if (contacts.where((c) => c.uuid == i.uuid).isNotEmpty) {
            i.hasBody = true;
          }
        });
        await _db.updateStorages([storageToSync], userServerId);
      } catch (err, stack) {
        _contactsCtrl.addError(formatError(err, stack));
      }
    }

    syncContacts([]);
  }

  // returns list of uuids to load
  List<String> _takeChunk(List<ContactInfoItem> infos) {
    final uids = new List<String>();
    int iteration = 0;

    infos.where((i) => i.hasBody != true).forEach((i) {
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
    _contactsCtrl.close();
    _storagesCtrl.close();
  }
}
