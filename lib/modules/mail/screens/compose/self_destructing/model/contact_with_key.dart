import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:crypto_model/crypto_model.dart';

class ContactWithKey {
  final Contact contact;
  final PgpKey key;

  ContactWithKey(this.contact, this.key);
}
