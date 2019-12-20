import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ContactsListAppBarAction { logout, settings, mail, viewGroup }

class ContactsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(ContactsListAppBarAction, {ContactsGroup group}) onActionSelected;

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  const ContactsAppBar({Key key, this.onActionSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsBloc, ContactsState>(
      builder: (context, state) =>
          AppBar(
            title: _buildTitle(context, state),
            actions: <Widget>[
              if (state.selectedGroup != null && state.selectedGroup != "")
                IconButton(icon: Icon(Icons.remove_red_eye),
                  onPressed: () {
                    final group = state.groups.firstWhere((g) => g.uuid == state.selectedGroup);
                    return onActionSelected(ContactsListAppBarAction.viewGroup, group: group);
                  },
                ),
              PopupMenuButton(
                onSelected: onActionSelected,
                tooltip: i18n(context, "contacts_list_app_bar_view_group"),
                itemBuilder: (_) {
                  return [
                    PopupMenuItem(
                      value: ContactsListAppBarAction.mail,
                      child: Text(i18n(context, "contacts_list_app_bar_mail")),
                    ),
                    PopupMenuItem(
                      value: ContactsListAppBarAction.settings,
                      child: Text(
                          i18n(context, "messages_list_app_bar_settings")),
                    ),
                    PopupMenuItem(
                      value: ContactsListAppBarAction.logout,
                      child: Text(
                          i18n(context, "messages_list_app_bar_logout")),
                    ),
                  ];
                },
              )
            ],
          ),
    );
  }

  Widget _buildTitle(BuildContext context, ContactsState state) {
    if (state.selectedStorage != null &&
        state.selectedStorage != -1 &&
        state.storages.isNotEmpty) {
      final selectedStorage =
      state.storages.firstWhere((s) => s.sqliteId == state.selectedStorage);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(i18n(context, "contacts")),
          SizedBox(height: 3.0),
          Text(
            selectedStorage.name,
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.caption.fontSize,
                fontWeight: FontWeight.w400),
          ),
        ],
      );
    } else if (state.selectedGroup != null &&
        state.selectedGroup != "" &&
        state.groups.isNotEmpty) {
      final selectedGroup = state.groups.firstWhere((g) => g.uuid == state.selectedGroup);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(i18n(context, "contacts")),
          SizedBox(height: 3.0),
          Text(
            "# " + selectedGroup.name,
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.caption.fontSize,
                fontWeight: FontWeight.w400),
          ),
        ],
      );
    } else {
      return Text(i18n(context, "contacts"));
    }
  }
}
