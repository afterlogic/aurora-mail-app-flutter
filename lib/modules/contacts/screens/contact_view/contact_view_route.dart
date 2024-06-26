//@dart=2.9
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/settings/blocs/pgp_settings/pgp_settings_bloc.dart';
import 'package:flutter/material.dart';

class ContactViewRoute {
  static const name = "contact_view";
}

class ContactViewScreenArgs {
  final Contact contact;
  final ContactsBloc contactsBloc;
  final MailBloc mailBloc;
  final ScaffoldState scaffoldState;

  final PgpSettingsBloc pgpSettingBloc;

  const ContactViewScreenArgs(
    this.pgpSettingBloc, {
    @required this.contact,
    @required this.mailBloc,
    @required this.contactsBloc,
    @required this.scaffoldState,
  });
}
