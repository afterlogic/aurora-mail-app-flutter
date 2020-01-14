import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/models/compose_actions.dart';
import 'package:flutter/cupertino.dart';

class ComposeRoute {
  static const name = "compose_message";
}

class ComposeScreenArgs {
  final MailBloc mailBloc;
  final ContactsBloc contactsBloc;
  final ComposeAction composeAction;

  const ComposeScreenArgs({
    @required this.mailBloc,
    @required this.contactsBloc,
    this.composeAction,
  });
}
