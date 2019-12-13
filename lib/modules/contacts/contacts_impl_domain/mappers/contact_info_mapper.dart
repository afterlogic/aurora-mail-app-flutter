import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';

class ContactInfoMapper {
  static List<ContactInfoItem> allFromNetwork(Map<String, dynamic> info) {
    final converted = info["Info"].map((i) {
      return ContactInfoItem(
        uuid: i["UUID"],
        eTag: i["ETag"],
      );
    });
    return new List<ContactInfoItem>.from(converted);
  }

  static ContactInfoItem fromNetwork(Map<String, dynamic> info) {
    return ContactInfoItem(
      uuid: info["UUID"],
      eTag: info["ETag"],
    );
  }
}
