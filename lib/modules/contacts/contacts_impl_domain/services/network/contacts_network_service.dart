import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/network/contacts_network_service_impl.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

abstract class ContactsNetworkService {
  factory ContactsNetworkService(WebMailApi contactsModule) =>
      ContactsNetworkServiceImpl(contactsModule);

  /// Returns a list of storages.
  /// [CTag] value changes when some storage data changes.
  Future<List<Map<String, dynamic>>> getContactStorages();

  /// Returns a list of groups.
  Future<List<Map<String, dynamic>>> getGroups();

  /// Returns a [CTag] and a list with contacts with hashes [ETag].
  /// [ETag] value changes when some contact data changes.
  Future<Map<String, dynamic>> getContactsInfo(String storage);

  /// Get contacts by their uuids
  Future<List<Map<String, dynamic>>> getContactsByUids(
    String storage,
    List<String> uids,
  );
}
