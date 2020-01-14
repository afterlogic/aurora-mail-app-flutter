import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:flutter/foundation.dart';

class ContactsListRoute {
  static const name = "contacts_list";
}

class ContactsListScreenArgs {
  final MailBloc mailBloc;
  final ContactsBloc contactsBloc;

  const ContactsListScreenArgs({
    @required this.mailBloc,
    @required this.contactsBloc,
  });
}
