import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/contacts_repository_impl.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/contacts_db_service_mock_impl.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/network/contacts_network_service_mock_impl.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  ContactsRepositoryImpl _repo;

  List<ContactsStorage> generateMockStorages(int quantity, [int update = 0]) {
    final result = <ContactsStorage>[];
    for (var i = 0; i < quantity; i++) {
      result.add(ContactsStorage(id: "$i", sqliteId: i, cTag: i < update ? 1 : 0, display: true, contactsInfo: null, name: "Name $i"));
    }
    return result;
  }

  setUp(() {
    _repo = new ContactsRepositoryImpl(
      token: "mock_token",
      apiUrl: "https://mockurl.com",
      userServerId: 0,
      appDB: null,
    );

    ContactsNetworkServiceMockImpl.storages = new List<ContactsStorage>();
    ContactsNetworkServiceMockImpl.groups = new List<ContactsGroup>();
    ContactsNetworkServiceMockImpl.infos = new List<ContactInfoItem>();
    ContactsNetworkServiceMockImpl.contacts = new List<Contact>();
    ContactsDbServiceMockImpl.storages = new List<ContactsStorage>();
  });

  tearDown(() {
    _repo.dispose();
  });

  group("watchContactsStorages", () {

    test("waits for network response if db is empty", () async {
      final newStoragesCount = 30;

      ContactsNetworkServiceMockImpl.storages = [...generateMockStorages(newStoragesCount)];

      final stream = _repo.watchContactsStorages();

      final storages = await stream.first;

      expect(storages.length, newStoragesCount);
    });

    test("waits for network response if db is empty and emits value, even if no storages", () async {
      ContactsNetworkServiceMockImpl.storages = [];

      final stream = _repo.watchContactsStorages();

      final storages = await stream.first;

      expect(storages.length, 0);
    });

    test("doesn't wait for network response if db is NOT empty", () async {
      ContactsNetworkServiceMockImpl.storages = [...generateMockStorages(20, 3)];
      ContactsDbServiceMockImpl.storages = [...generateMockStorages(14)];

      final stream = _repo.watchContactsStorages();

      final streams = await stream.take(2).toList();
      final storages = streams[0];

      expect(storages.length, ContactsDbServiceMockImpl.storages.length);
    });

    test("emits new values", () async {
      ContactsNetworkServiceMockImpl.storages = [...generateMockStorages(20, 3)];
      ContactsDbServiceMockImpl.storages = [...generateMockStorages(14)];

      final stream = _repo.watchContactsStorages();

      final streams = await stream.take(2).toList();
      final storages = streams[1];

      expect(storages.length, ContactsNetworkServiceMockImpl.storages.length);
    });
  });

  group("getStoragesWithUpdatedInfo", () {
    test("assigns correct infos from network if contactsInfo was null", () async {
      var storage = new ContactsStorage(
        sqliteId: 0,
        id: "personal",
        name: "Personal",
        cTag: 0,
        display: true,
        contactsInfo: null,
      );

      ContactsNetworkServiceMockImpl.infos = [
        ContactInfoItem(uuid: "0", eTag: "0"),
        ContactInfoItem(uuid: "1", eTag: "0"),
        ContactInfoItem(uuid: "2", eTag: "0"),
      ];

      expect(storage.contactsInfo, null);

      storage = await _repo.getStoragesWithUpdatedInfo(storage);

      expect(storage.contactsInfo.length, ContactsNetworkServiceMockImpl.infos.length);
    });

    test("assigns correct infos from network if contactsInfo already had values", () async {
      var storage = new ContactsStorage(
        sqliteId: 0,
        id: "personal",
        name: "Personal",
        cTag: 0,
        display: true,
        contactsInfo: [
          ContactInfoItem(uuid: "0", eTag: "0", hasBody: false),
          ContactInfoItem(uuid: "1", eTag: "0", hasBody: true),
          ContactInfoItem(uuid: "2", eTag: "0", hasBody: true),
        ],
      );

      ContactsNetworkServiceMockImpl.infos = [
        ContactInfoItem(uuid: "0", eTag: "1", hasBody: false),
        ContactInfoItem(uuid: "1", eTag: "0", hasBody: false),
        ContactInfoItem(uuid: "3", eTag: "0", hasBody: false),
        ContactInfoItem(uuid: "4", eTag: "0", hasBody: false),
      ];

      expect(storage.contactsInfo.length, 3);

      storage = await _repo.getStoragesWithUpdatedInfo(storage);

      final infos = storage.contactsInfo;
      final i0 = infos.firstWhere((i) => i.uuid == "0", orElse: () => null);
      final i1 = infos.firstWhere((i) => i.uuid == "1", orElse: () => null);
      final i2 = infos.firstWhere((i) => i.uuid == "2", orElse: () => null);

      expect(infos.length, ContactsNetworkServiceMockImpl.infos.length);
      expect(i0, isNotNull);
      expect(i0.eTag, "1");
      expect(i0.hasBody, false);
      expect(i1, isNotNull);
      expect(i1.hasBody, true);
      expect(i2, isNull);
    });
  });

  group("getStoragesToUpdate", () {

    test("syncs infos from network to db", () async {

      ContactsDbServiceMockImpl.storages = [...generateMockStorages(40)];

      ContactsNetworkServiceMockImpl.storages = [...generateMockStorages(30, 4)];

      await _repo.getStoragesToUpdate(ContactsDbServiceMockImpl.storages);

      expect(ContactsDbServiceMockImpl.storages.length, ContactsNetworkServiceMockImpl.storages.length);
    });

    test("returns correct amount of storages for update", () async {

      final oldStorages = 23;
      final addedStorages = 14;
      final updatedStorages = oldStorages - 18;

      ContactsDbServiceMockImpl.storages = [...generateMockStorages(oldStorages)];

      ContactsNetworkServiceMockImpl.storages = [...generateMockStorages(oldStorages + addedStorages, updatedStorages)];

      final result = await _repo.getStoragesToUpdate(ContactsDbServiceMockImpl.storages);

      expect(result.length, addedStorages + updatedStorages);
    });
  });
}