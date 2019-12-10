import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';

class ContactInfoMapper {
  static List<ContactInfoItem> fromNetwork(Map<String, dynamic> info) {
    return info["Info"].map((i) {
      return new ContactInfoItem(
        uuid: i["UUID"],
        eTag: i["ETag"],
      );
    });
  }
}
