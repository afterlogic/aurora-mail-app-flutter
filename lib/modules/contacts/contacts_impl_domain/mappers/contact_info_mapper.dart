import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';

class ContactInfoMapper {
  static List<ContactInfoItem> allFromNetwork(
      Map<String, dynamic> info, String storage) {
    // The server may return entries without an ETag (and, rarely, without
    // a UUID); entries without a UUID can't be matched, so skip them.
    final converted =
        (info["Info"] as List).where((i) => i["UUID"] != null).map((i) {
      return ContactInfoItem(
        uuid: i["UUID"] as String,
        eTag: i["ETag"] as String?,
        storage: storage,
      );
    });
    return new List<ContactInfoItem>.from(converted);
  }
}
