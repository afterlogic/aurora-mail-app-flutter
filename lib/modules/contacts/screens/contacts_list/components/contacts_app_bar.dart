import 'dart:io';

import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/screens/group_view/group_view_route.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/user_selection_popup.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ContactsAppBar extends StatelessWidget implements PreferredSizeWidget {

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  const ContactsAppBar();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsBloc, ContactsState>(
      builder: (context, state) =>
          AppBar(
            leading: IconButton(
              icon: Icon(MdiIcons.sortVariant),
              onPressed: Scaffold.of(context).openDrawer,
            ),
            title: _buildTitle(context, state),
            actions: <Widget>[
              if (state.selectedGroup != null)
                IconButton(icon: Icon(Icons.remove_red_eye),
                  onPressed: () {
                    final group = state.groups.firstWhere((g) => g.uuid == state.selectedGroup);
                    final bloc = BlocProvider.of<ContactsBloc>(context);
                    Navigator.pushNamed(context, GroupViewRoute.name, arguments: GroupViewScreenArgs(group, bloc));
                  },
                ),
              if (BuildProperty.multiUserEnable)
                BlocBuilder<SettingsBloc, SettingsState>(
                  builder: (_, state) => UserSelectionPopup((state as SettingsLoaded).users),
                ),
            ],
          ),
    );
  }

  Widget _buildTitle(BuildContext context, ContactsState state) {
    if (state.selectedStorage != null && state.storages.isNotEmpty) {
      final selectedStorage = state.storages.firstWhere((s) => s.sqliteId == state.selectedStorage);

      return Column(
        crossAxisAlignment: !Platform.isIOS ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: <Widget>[
          Text(i18n(context, "contacts")),
          SizedBox(height: 3.0),
          Text(
            i18n(context, "contacts_drawer_storage_${selectedStorage.name}"),
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.caption.fontSize,
                fontWeight: FontWeight.w400),
          ),
        ],
      );
    } else if (state.selectedGroup != null && state.groups.isNotEmpty) {
      final selectedGroup = state.groups.firstWhere((g) => g.uuid == state.selectedGroup);
      return Column(
        crossAxisAlignment: !Platform.isIOS ? CrossAxisAlignment.start : CrossAxisAlignment.center,
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
    } else if (state.showAllVisibleContacts == true) {
      return Column(
        crossAxisAlignment: !Platform.isIOS ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: <Widget>[
          Text(i18n(context, "contacts")),
          SizedBox(height: 3.0),
          Text(
            i18n(context, "contacts_list_app_bar_all_contacts"),
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
