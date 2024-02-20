//@dart=2.9
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';
import 'package:flutter/cupertino.dart';

class GroupEditRoute {
  static const name = "group_edit";
}

class GroupEditScreenArgs {
  final ContactsGroup group;
  final ContactsBloc bloc;

  const GroupEditScreenArgs({this.group, @required this.bloc});
}
