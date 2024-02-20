//@dart=2.9
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/settings/blocs/pgp_settings/pgp_settings_bloc.dart';
import 'package:flutter/cupertino.dart';

class ContactEditRoute {
  static const name = "contact_edit";
}

class ContactEditScreenArgs {
  final Contact contact;
  final ContactsBloc bloc;
  final PgpSettingsBloc pgpSettingsBloc;

  const ContactEditScreenArgs(this.pgpSettingsBloc,
      {this.contact, @required this.bloc})
      : assert(bloc != null);
}
