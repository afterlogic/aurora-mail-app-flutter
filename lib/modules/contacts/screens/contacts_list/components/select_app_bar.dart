import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/contacts_bloc.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/events/contacts_event.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/screens/components/groups_select_dialog.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/selection_controller.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SelectAppBar extends StatelessWidget{
  final SelectionController<String, Contact> controller;
  final ContactsBloc bloc;

  const SelectAppBar(
      this.controller,
      this.bloc
      );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.close,
        ),
        onPressed: () => controller.enable = false,
      ),
      title: Text(controller.selected.length.toString()),
      actions: [IconButton(
        icon: Icon(MdiIcons.fileMove),
        onPressed: () => _moveToGroup(context),
      )],
    );
  }


  void _moveToGroup(BuildContext context) async {
    final result = await GroupsSelectDialog.show(context, bloc.state.groups,);
    if(result == null){
      return;
    }
    bloc.add(AddContactsToGroup([result], controller.selected.entries.map((e) => e.value).toList()));
    controller.enable = false;
  }

}
