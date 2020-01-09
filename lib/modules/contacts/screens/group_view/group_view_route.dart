import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';

class GroupViewRoute {
  static const name = "group_view";
}

class GroupViewScreenArgs {
  final ContactsGroup group;
  final ContactsBloc bloc;

  GroupViewScreenArgs(this.group, this.bloc);
}
