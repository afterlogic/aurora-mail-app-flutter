import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:crypto_model/crypto_model.dart';

class RecipientWithKey {
  final Contact contact;
  final PgpKey key;

  RecipientWithKey(this.contact, this.key);
}
