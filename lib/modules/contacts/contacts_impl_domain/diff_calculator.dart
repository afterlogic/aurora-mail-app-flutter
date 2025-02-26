//@dart=2.9
import 'package:aurora_logger/aurora_logger.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class ContactsDiffCalculator {
  static Future<ContactInfoDiffCalcResult> calculateContactsInfoDiffAsync(
      List<ContactInfoItem> oldInfo, List<ContactInfoItem> newInfo) {
    final Map<String, List<ContactInfoItem>> args = {
      "oldItems": oldInfo,
      "newItems": newInfo,
    };
    return compute(_calculateContactsInfoDiff, args);
  }

  static ContactInfoDiffCalcResult _calculateContactsInfoDiff(
      Map<String, List<ContactInfoItem>> args) {
    final oldContacts = args["oldItems"];
    final newContacts = args["newItems"];

    final addedContacts = newContacts
        .where((i) =>
            oldContacts.firstWhere(
                (j) => j.uuidPlusStorage == i.uuidPlusStorage,
                orElse: () => null
            ) == null
        )
        .toList();

    final deletedContacts = oldContacts
        .where((i) =>
            newContacts.firstWhere(
                (j) => j.uuidPlusStorage == i.uuidPlusStorage,
                orElse: () => null
            ) == null
        )
        .map((c) => c.uuid)
        .toList();

    final updatedContacts = <ContactInfoItem>[];
    newContacts.forEach((newContact) {
      final changedContact = oldContacts.firstWhere(
          (oldContact) =>
              oldContact.uuidPlusStorage == newContact.uuidPlusStorage &&
              oldContact.eTag != newContact.eTag,
          orElse: () => null
      );
      if (changedContact != null) {
        final updatedContact = newContact.copyWith(
          hasBody: changedContact.hasBody,
          needsUpdate: true,
        );
        updatedContacts.add(updatedContact);
      }
    });

    logger.log("""
Contacts diff calculation finished:
  added: ${addedContacts.length}
  removed: ${deletedContacts.length}
  updated: ${updatedContacts.length}
    """);

    return new ContactInfoDiffCalcResult(
      addedContacts: addedContacts,
      deletedContacts: deletedContacts,
      updatedContacts: updatedContacts,
    );
  }

  static Future<StoragesDiffCalcResult> calculateStoragesDiffAsync(
      List<ContactsStorage> oldInfo, List<ContactsStorage> newInfo) {
    final Map<String, List<ContactsStorage>> args = {
      "oldItems": oldInfo,
      "newItems": newInfo,
    };
    return compute(_calculateStoragesDiff, args);
  }

  static StoragesDiffCalcResult _calculateStoragesDiff(
      Map<String, List<ContactsStorage>> args) {
    final oldStorages = args["oldItems"];
    final newStorages = args["newItems"];

    final addedStorages = newStorages
        .where((i) =>
            oldStorages.firstWhere((j) => j.id == i.id, orElse: () => null) ==
            null)
        .toList();

    final deletedStorages = oldStorages
        .where((i) =>
            newStorages.firstWhere((j) => j.id == i.id, orElse: () => null) ==
            null)
        .toList();

    final updatedStorages = <ContactsStorage>[];
    // adding storages that have changed cTag
    newStorages.forEach((newStorage) {
      final changedStorage = oldStorages.firstWhere(
          (oldStorage) =>
              oldStorage.id == newStorage.id &&
              oldStorage.cTag != newStorage.cTag,
          orElse: () => null);
      if (changedStorage != null) {
        final updatedStorage = newStorage.copyWith(
          sqliteId: changedStorage.sqliteId,
          contactsInfo: changedStorage.contactsInfo,
        );
        updatedStorages.add(updatedStorage);
      }
    });
    // adding storages with unloaded contacts
    oldStorages.forEach((oldStorage) {
      if (_hasUnloadedContacts(oldStorage)) {
        _addToUpdatedStoragesIfNotIn(updatedStorages, oldStorage);
      }
    });

    if (addedStorages.isNotEmpty ||
        deletedStorages.isNotEmpty ||
        updatedStorages.isNotEmpty) {
      logger.log("""
Storages diff calculation finished:
  added: ${addedStorages.length}
  removed: ${deletedStorages.length}
  updated: ${updatedStorages.length}
    """);
    }

    return new StoragesDiffCalcResult(
      addedStorages: addedStorages,
      deletedStorages: deletedStorages,
      updatedStorages: updatedStorages,
    );
  }

  static bool _hasUnloadedContacts(ContactsStorage storage) {
    if (storage.contactsInfo == null || storage.contactsInfo.isEmpty) {
      return true;
    }
    final infoToUpdate = storage.contactsInfo.firstWhere(
      (info) => info.hasBody == false || info.needsUpdate == true,
      orElse: () => null,
    );
    return infoToUpdate != null;
  }

  static void _addToUpdatedStoragesIfNotIn(
    List<ContactsStorage> updatedStorages,
    ContactsStorage storage,
  ) {
    final foundStorage = updatedStorages.firstWhere(
      (updatedStorage) => updatedStorage.id == storage.id,
      orElse: () => null,
    );
    if (foundStorage == null) {
      updatedStorages.add(storage);
    }
  }
}

class ContactInfoDiffCalcResult {
  final List<ContactInfoItem> addedContacts;
  final List<String> deletedContacts;
  final List<ContactInfoItem> updatedContacts;

  ContactInfoDiffCalcResult({
    @required this.addedContacts,
    @required this.deletedContacts,
    @required this.updatedContacts,
  });
}

class StoragesDiffCalcResult {
  final List<ContactsStorage> addedStorages;
  final List<ContactsStorage> deletedStorages;
  final List<ContactsStorage> updatedStorages;

  StoragesDiffCalcResult({
    @required this.addedStorages,
    @required this.deletedStorages,
    @required this.updatedStorages,
  });
}
