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

    final addedContacts = newContacts.where((i) =>
        oldContacts.firstWhere((j) => j.uuidPlusStorage == i.uuidPlusStorage,
            orElse: () => null) ==
        null);

    final deletedContacts = oldContacts.where((i) =>
        newContacts.firstWhere((j) => j.uuidPlusStorage == i.uuidPlusStorage,
            orElse: () => null) ==
        null);

    final updatedContacts = newContacts.where((i) =>
        oldContacts.firstWhere((j) {
          if (j.uuidPlusStorage == i.uuidPlusStorage && j.eTag != i.eTag) {
            i.hasBody = j.hasBody;
            i.needsUpdate = true;
            return true;
          } else {
            return false;
          }
        }, orElse: () => null) !=
        null);

    logger.log("""
Contacts diff calcultaion finished:
  added: ${addedContacts.length}
  removed: ${deletedContacts.length}
  updated: ${updatedContacts.length}
    """);

    return new ContactInfoDiffCalcResult(
      addedContacts: addedContacts.toList(),
      deletedContacts: deletedContacts.map((c) => c.uuid).toList(),
      updatedContacts: updatedContacts.toList(),
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

    final addedStorages = newStorages.where((i) =>
        oldStorages.firstWhere((j) => j.id == i.id, orElse: () => null) ==
        null);

    final deletedStorages = oldStorages.where((i) =>
        newStorages.firstWhere((j) => j.id == i.id, orElse: () => null) ==
        null);

    final updatedStorages = newStorages.where((i) =>
        oldStorages.firstWhere((j) {
          if (j.id == i.id && j.cTag != i.cTag) {
            if (j.contactsInfo != null) {
              i.contactsInfo = new List<ContactInfoItem>.from(j.contactsInfo);
            }
            return true;
          } else {
            return false;
          }
        }, orElse: () => null) !=
        null);

    if (addedStorages.isNotEmpty ||
        deletedStorages.isNotEmpty ||
        updatedStorages.isNotEmpty) {
      logger.log("""
Storages diff calcultaion finished:
  added: ${addedStorages.length}
  removed: ${deletedStorages.length}
  updated: ${updatedStorages.length}
    """);
    }

    return new StoragesDiffCalcResult(
      addedStorages: addedStorages.toList(),
      deletedStorages: deletedStorages.toList(),
      updatedStorages: updatedStorages.toList(),
    );
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
