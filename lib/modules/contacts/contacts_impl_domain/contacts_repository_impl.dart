import 'dart:async';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/contacts_repository.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/diff_calculator.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/contacts_db_service.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/network/contacts_network_service.dart';
import 'package:flutter/widgets.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

class ContactsRepositoryImpl implements ContactsRepository {

  final int userServerId;

  ContactsNetworkService _network;
  ContactsDbService _db;

  final _contactsCtrl = new StreamController<List<Contact>>();
  final _storagesCtrl = new StreamController<List<ContactsStorage>>();

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
  }

  @override
  Stream<List<Contact>> watchContacts(ContactsStorage storage) async* {
    final contacts = await _db.getContacts(userServerId, storage.id);

    if (contacts.isNotEmpty) {
      yield* _contactsCtrl.stream;
      _contactsCtrl.add(contacts);
    } else {


    }
  }

  @override
  Stream<List<ContactsGroup>> watchContactsGroups() => null;

  @override
  Stream<List<ContactsStorage>> watchContactsStorages() async* {
    final storagesFromDb = await _db.getStorages(userServerId);

    if (storagesFromDb.isNotEmpty) {
      yield* _storagesCtrl.stream;
      _storagesCtrl.add(storagesFromDb);

      final storagesToUpdate = await _getStoragesToUpdate(storagesFromDb);

      await _updateContactsInfo(storagesToUpdate);

      final updatedStorages = await _db.getStorages(userServerId);

      _storagesCtrl.add(updatedStorages);
    } else {
      final storages = await _network.getContactStorages();

      await _db.addStorages(storages, userServerId);

      await _updateContactsInfo(storages);

      final updatedStorages = await _db.getStorages(userServerId);
      yield* _storagesCtrl.stream;
      _storagesCtrl.add(updatedStorages);
    }
  }

  Future<List<ContactsStorage>> _getStoragesToUpdate(
      List<ContactsStorage> storagesFromDb) async {
    final storagesFromNetwork = await _network.getContactStorages();

    final calcResult = await ContactsDiffCalculator
        .calculateStoragesDiffAsync(storagesFromDb, storagesFromNetwork);

    final storageIdsToDelete = calcResult.addedStorages.map((s) => s.sqliteId)
        .toList();

    await Future.wait([
      _db.addStorages(calcResult.addedStorages, userServerId),
      _db.deleteStorages(storageIdsToDelete),
    ]);

    return [...calcResult.updatedStorages, ...calcResult.addedStorages];
  }

  Future<void> _updateContactsInfo(List<ContactsStorage> storages) async {
    final futures = new List<Future<ContactsStorage>>();

    storages.forEach((s) => futures.add(_getStoragesWithUpdatedInfo(s)));
    final storagesToUpdate = await Future.wait(futures);

    await _db.updateStorages(storagesToUpdate, userServerId);
  }

  Future<ContactsStorage> _getStoragesWithUpdatedInfo(ContactsStorage s) async {
    final infos = await _network.getContactsInfo(s);
    if (s.contactsInfo == null) {
      return new ContactsStorage(
          id: s.id,
          contactsInfo: infos,
          sqliteId: s.sqliteId,
          cTag: s.cTag,
          name: s.name
      );
    } else {
      final calcResult = await ContactsDiffCalculator
          .calculateContactsInfoDiffAsync(s.contactsInfo, infos);

      final infosToUpdate = new List<ContactInfoItem>.from(s.contactsInfo);

      infosToUpdate.removeWhere((i) =>
      calcResult.deletedContacts.contains(i.uuid) &&
          calcResult.updatedContacts
              .where((j) => j.uuid == i.uuid)
              .isNotEmpty);

      infosToUpdate.addAll(calcResult.addedContacts);
      infosToUpdate.addAll(calcResult.updatedContacts);

      return new ContactsStorage(
          id: s.id,
          contactsInfo: infosToUpdate,
          sqliteId: s.sqliteId,
          cTag: s.cTag,
          name: s.name
      );
    }
  }

  @override
  void dispose() {
    _contactsCtrl.close();
    _storagesCtrl.close();
  }
}
