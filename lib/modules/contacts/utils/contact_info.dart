import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';

/// PrimaryEmail: {'Personal': 0, 'Business': 1, 'Other': 2},
/// PrimaryPhone: {'Mobile': 0, 'Personal': 1, 'Business': 2},
/// PrimaryAddress: {'Personal': 0, 'Business': 1},

class ContactInfo {
  final Contact c;

  const ContactInfo(this.c);

  String get viewEmail {
    switch(c.primaryEmail) {
      case 0:
        return c.personalEmail;
      case 1:
        return c.businessEmail;
      case 2:
        return c.otherEmail;
      default:
        throw UnsupportedError("Unknown primaryEmail ${c.primaryEmail}");
    }
  }

  String get viewPhone {
    switch(c.primaryPhone) {
      case 0:
        return c.personalMobile;
      case 1:
        return c.personalPhone;
      case 2:
        return c.businessPhone;
      default:
        throw UnsupportedError("Unknown primaryPhone ${c.primaryPhone}");
    }
  }

  String get viewAddress {
    switch(c.primaryAddress) {
      case 0:
        return c.personalAddress;
      case 1:
        return c.businessAddress;
      default:
        throw UnsupportedError("Unknown primaryAddress ${c.primaryAddress}");
    }
  }
}