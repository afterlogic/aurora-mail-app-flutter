import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';

class ContactInfoMapper {
  static List<ContactInfoItem> allFromNetwork(
      Map<String, dynamic> info, String storage) {
    final converted = info["Info"].map((i) {
      return ContactInfoItem(
        uuid: i["UUID"] as String,
        eTag: i["ETag"] as String,
        storage: storage,
      );
    });
    return new List<ContactInfoItem>.from(converted as Iterable);
  }
}
