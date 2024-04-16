import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/contacts_bloc.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/events/contacts_event.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/screens/components/groups_select_dialog.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/selection_controller.dart';
import 'package:aurora_mail/shared_ui/confirmation_dialog.dart';
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
      ), IconButton(
        icon: Icon(Icons.delete_outline),
        onPressed: () => _deleteContacts(context),
      )],
    );
  }

  void _deleteContacts(BuildContext context) async {
    final contacts = controller.selected.entries.map((e) => e.value).toList();
    final delete = await ConfirmationDialog.show(
      context,
      S.of(context).contacts_delete_title_plural,
      S.of(context).contacts_delete_selected,
      S.of(context).btn_delete,
      destructibleAction: true,
    );
    if (delete != true) {
      return;
    }

    bloc.add(DeleteContacts(contacts));
    controller.enable = false;
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
