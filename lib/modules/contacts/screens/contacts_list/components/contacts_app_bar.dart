import 'package:aurora_mail/generated/i18n.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ContactsListAppBarAction { logout, settings, mail }

class ContactsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(ContactsListAppBarAction) onActionSelected;

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  const ContactsAppBar({Key key, this.onActionSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:
      BlocBuilder<ContactsBloc, ContactsState>(
        builder: (context, state) => _buildTitle(context, state),
      ),
      actions: <Widget>[
        PopupMenuButton(
          onSelected: onActionSelected,
          itemBuilder: (_) {
            return [
              PopupMenuItem(
                value: ContactsListAppBarAction.mail,
                child: Text(S.of(context).contacts_list_app_bar_mail),
              ),
              PopupMenuItem(
                value: ContactsListAppBarAction.settings,
                child: Text(S.of(context).messages_list_app_bar_settings),
              ),
              PopupMenuItem(
                value: ContactsListAppBarAction.logout,
                child: Text(S.of(context).messages_list_app_bar_logout),
              ),
            ];
          },
        )
      ],
    );
  }

  Widget _buildTitle(BuildContext context, ContactsState state) {
    if (state.selectedStorage != null && state.storages.isNotEmpty) {
      final selectedStorage = state.storages.firstWhere((s) => s.sqliteId == state.selectedStorage);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(S.of(context).contacts),
          SizedBox(height: 3.0),
          Text(
            selectedStorage.name,
            style: TextStyle(fontSize: Theme.of(context).textTheme.caption.fontSize, fontWeight: FontWeight.w400),
          ),
        ],
      );
    } else {
      return Text(S.of(context).contacts);
    }
  }
}
