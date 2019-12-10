import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/diff_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group("ContactsInfo", () {
    Future<ContactInfoDiffCalcResult> calculate() {
      final List<ContactInfoItem> mockOldInfos = [
        new ContactInfoItem(uuid: "0", eTag: "0", hasBody: false),
        new ContactInfoItem(uuid: "1", eTag: "0", hasBody: true),
        new ContactInfoItem(uuid: "2", eTag: "0", hasBody: true),
        new ContactInfoItem(uuid: "3", eTag: "0", hasBody: true),
      ];

      final List<ContactInfoItem> mockNewInfos = [
        new ContactInfoItem(uuid: "0", eTag: "0", hasBody: false),
        new ContactInfoItem(uuid: "1", eTag: "1", hasBody: false), // updated
//        new ContactInfoItem(uuid: "2", eTag: "0", hasBody: false), // deleted
        new ContactInfoItem(uuid: "3", eTag: "0", hasBody: false),
        new ContactInfoItem(uuid: "4", eTag: "0", hasBody: false), // added
      ];

      return ContactsDiffCalculator.calculateContactsInfoDiffAsync(mockOldInfos, mockNewInfos);
    }

    test('Calculates added contacts info', () async {
      final result = await calculate();

      expect(result.addedContacts.length, 1);
      expect(result.addedContacts[0].uuid, "4");
      expect(result.addedContacts[0].hasBody, false);
    });

    test('Calculates deleted contacts info', () async {
      final result = await calculate();

      expect(result.deletedContacts.length, 1);
      expect(result.deletedContacts[0], "2");
    });

    test('Calculates updated contacts info', () async {
      final result = await calculate();

      expect(result.updatedContacts.length, 1);
      expect(result.updatedContacts[0].uuid, "1");
      expect(result.updatedContacts[0].eTag, "1");
    });

    test('Assigns correct has body from old items', () async {
      final result = await calculate();

      expect(result.updatedContacts[0].hasBody, true);
    });
  });

  group("Storages", () {
    Future<StoragesDiffCalcResult> calculate() {
      final List<ContactsStorage> mockOldStorages = [
        new ContactsStorage(sqliteId: null, id: "personal", name: "Personal", cTag: 1, contactsInfo: []),
        new ContactsStorage(sqliteId: null, id: "public", name: "Public", cTag: 1, contactsInfo: [new ContactInfoItem(uuid: "0", eTag: "0")]),
        new ContactsStorage(sqliteId: null, id: "private", name: "Private", cTag: 1, contactsInfo: [new ContactInfoItem(uuid: "0", eTag: "0")]),
        new ContactsStorage(sqliteId: null, id: "other", name: "Other", cTag: 1, contactsInfo: [new ContactInfoItem(uuid: "0", eTag: "0")]),
      ];

      final List<ContactsStorage> mockNewStorages = [
        new ContactsStorage(sqliteId: null, id: "personal", name: "Personal", cTag: 1, contactsInfo: null),
        new ContactsStorage(sqliteId: null, id: "public", name: "Public", cTag: 2, contactsInfo: null),
        new ContactsStorage(sqliteId: null, id: "shared", name: "Private", cTag: 1, contactsInfo: null),
        new ContactsStorage(sqliteId: null, id: "other", name: "Other", cTag: 1, contactsInfo: null),
      ];

      return ContactsDiffCalculator.calculateStoragesDiffAsync(mockOldStorages, mockNewStorages);
    }

    test('Calculates added storages', () async {
      final result = await calculate();

      expect(result.addedStorages.length, 1);
      expect(result.addedStorages[0].id, "shared");
    });

    test('Calculates deleted storages', () async {
      final result = await calculate();

      expect(result.deletedStorages.length, 1);
      expect(result.deletedStorages[0], "private");
    });

    test('Calculates updated storages', () async {
      final result = await calculate();

      expect(result.updatedStorages.length, 1);
      expect(result.updatedStorages[0].cTag, 2);
      expect(result.updatedStorages[0].contactsInfo.length, 1);
    });
  });
}