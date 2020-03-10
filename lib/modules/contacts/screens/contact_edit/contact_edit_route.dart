import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:flutter/cupertino.dart';

class ContactEditRoute {
  static const name = "contact_edit";
}

class ContactEditScreenArgs {
  final Contact contact;
  final ContactsBloc bloc;

  const ContactEditScreenArgs({this.contact, @required this.bloc})
      : assert(bloc != null);
}
