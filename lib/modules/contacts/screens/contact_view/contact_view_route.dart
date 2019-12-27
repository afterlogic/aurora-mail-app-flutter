import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:flutter/material.dart';

class ContactViewRoute {
  static const name = "contact_view";
}

class ContactViewScreenArgs {
  final Contact contact;
  final ContactsBloc bloc;
  final ScaffoldState scaffoldState;

  const ContactViewScreenArgs(this.contact, this.bloc, this.scaffoldState);
}
