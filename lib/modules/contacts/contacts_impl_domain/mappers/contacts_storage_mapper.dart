import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';

class ContactsStorageMapper {
  static List<ContactsStorage> fromNetwork(
      List<Map<String, dynamic>> rawItems) {
    return rawItems.map((i) {
      return new ContactsStorage(
        id: i["Id"],
        name: i["Name"],
        cTag: i["CTag"],
      );
    });
  }
}
