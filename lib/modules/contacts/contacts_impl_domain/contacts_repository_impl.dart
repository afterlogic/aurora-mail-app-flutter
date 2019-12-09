import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/contacts_repository.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

class ContactsRepositoryImpl implements ContactsRepository {
  final contactsModule = new WebMailApi(
    moduleName: "Contacts",
    apiUrl: AuthBloc.apiUrl,
    token: AuthBloc.currentUser.token,
  );

  @override
  Stream<List<Contact>> watchContacts() {
    // TODO: implement watchContacts
    return null;
  }

  @override
  Stream<List<ContactsGroup>> watchContactsGroups() {
    // TODO: implement watchContactsGroups
    return null;
  }

  @override
  Stream<List<ContactsStorage>> watchContactsStorages() {
    // TODO: implement watchContactsStorages
    return null;
  }
}