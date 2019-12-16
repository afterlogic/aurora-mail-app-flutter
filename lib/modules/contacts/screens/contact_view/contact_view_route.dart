import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';

class ContactViewRoute {
  static const name = "contace_view";
}

class ContactViewScreenArgs {
  final Contact contact;
  final ContactsBloc bloc;

  ContactViewScreenArgs(this.contact, this.bloc);
}