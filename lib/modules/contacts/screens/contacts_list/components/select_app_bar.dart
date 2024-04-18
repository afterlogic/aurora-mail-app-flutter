import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
import 'package:aurora_mail/modules/contacts/screens/components/groups_select_dialog.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/selection_controller.dart';
import 'package:aurora_mail/shared_ui/confirmation_dialog.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectAppBar extends StatelessWidget {
  final SelectionController<String, Contact> controller;
  final ContactsBloc bloc;

  const SelectAppBar(this.controller, this.bloc);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsBloc, ContactsState>(
      buildWhen: (prev, current) => prev.selectedGroup != current.selectedGroup,
      builder: (context, state) {
        final areContactsCanBeDeleted = _checkIfContactsCanBeDeleted(
            state.storages.firstWhereOrNull((e) => e.name == state.selectedStorage),
            context);
        return AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.close,
            ),
            onPressed: () => controller.enable = false,
          ),
          title: Text(controller.selected.length.toString()),
          actions: [
            IconButton(
              icon: Icon(Icons.drive_file_move_outline),
              onPressed: () => _moveToGroup(context),
            ),
            if (state.selectedGroup != null) IconButton(
              icon: Icon(Icons.folder_delete_outlined),
              onPressed: () => _removeFromGroup(context),
            ),
            if (state.selectedGroup == null && areContactsCanBeDeleted)
              IconButton(
                icon: Icon(Icons.delete_outline),
                onPressed: () => _deleteContacts(context),
              ),
          ],
        );
      },
    );
  }

  bool _checkIfContactsCanBeDeleted(
      ContactsStorage? storage, BuildContext context) {
    if (storage == null){
      return false;
    }
    final authBlocState = BlocProvider.of<AuthBloc>(context).currentUser;
    return authBlocState.emailFromLogin == storage.ownerMail
        ? true
        : storage.isShared == true && storage.accessCode == 1;
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

  void _removeFromGroup(BuildContext context) async {
    final delete = await ConfirmationDialog.show(
      context,
      S.of(context).contacts_remove_from_group,
      S.of(context).contacts_remove_selected,
      S.of(context).remove,
      destructibleAction: true,
    );
    if (delete != true) {
      return;
    }
    bloc.add(RemoveContactsFromCurrentGroup(
        controller.selected.entries.map((e) => e.value).toList()));
    controller.enable = false;
  }

  void _moveToGroup(BuildContext context) async {
    final result = await GroupsSelectDialog.show(
      context,
      bloc.state.groups,
    );
    if (result == null) {
      return;
    }
    bloc.add(AddContactsToGroup(
        [result], controller.selected.entries.map((e) => e.value).toList()));
    controller.enable = false;
  }
}
