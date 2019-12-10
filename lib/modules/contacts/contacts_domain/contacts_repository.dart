import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';

abstract class ContactsRepository {
  Stream<List<Contact>> watchContacts(ContactsStorage storage);

  Stream<List<ContactsStorage>> watchContactsStorages();

  Stream<List<ContactsGroup>> watchContactsGroups();

  void dispose();
}
