import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:flutter/material.dart';import 'package:aurora_mail/utils/base_state.dart';

class ContactViewRoute {
  static const name = "contact_view";
}

class ContactViewScreenArgs {
  final Contact contact;
  final ContactsBloc contactsBloc;
  final MailBloc mailBloc;
  final ScaffoldState scaffoldState;

  const ContactViewScreenArgs({
    @required this.contact,
    @required this.mailBloc,
    @required this.contactsBloc,
    @required this.scaffoldState,
  });
}
