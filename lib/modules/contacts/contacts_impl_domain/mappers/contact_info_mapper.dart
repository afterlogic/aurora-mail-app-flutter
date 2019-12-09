import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_info_model.dart';

class ContactInfoMapper {
  static List<ContactInfo> fromNetwork(Map<String, dynamic> info) {
    return info["Info"].map((i) {
      return new ContactInfo(
        uuid: i["UUID"],
        eTag: i["ETag"],
        storage: i["Storage"],
        cTag: info["CTag"],
      );
    });
  }
}
