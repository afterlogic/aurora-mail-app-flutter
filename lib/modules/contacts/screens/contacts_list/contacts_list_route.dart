import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';

class ContactsListRoute {
  static const name = "contacts_list";
}

class ContactsListScreenArgs {
  final ContactsBloc bloc;

  const ContactsListScreenArgs(this.bloc);
}
