//@dart=2.9
import 'dart:async';

import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
import 'package:aurora_mail/modules/contacts/screens/group_edit/group_edit_route.dart';
import 'package:aurora_mail/res/icons/webmail_icons.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/storage_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ContactsDrawer extends StatefulWidget {
  @override
  _ContactsDrawerState createState() => _ContactsDrawerState();
}

class _ContactsDrawerState extends BState<ContactsDrawer> {
  ContactsBloc contactsBloc;

  @override
  void initState() {
    super.initState();
    contactsBloc = BlocProvider.of<ContactsBloc>(context);
  }

  void _addGroup() {
    Navigator.pushNamed(
      context,
      GroupEditRoute.name,
      arguments: GroupEditScreenArgs(bloc: contactsBloc),
    );
  }

  Future<void> _onRefresh() {
    final completer = Completer();
    contactsBloc.add(GetContacts(completer: completer));
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        backgroundColor: Colors.white,
        color: Colors.black,
        child: ListTileTheme(
          selectedColor: theme.primaryColor,
          style: ListTileStyle.drawer,
          child: SafeArea(
            child: BlocBuilder<ContactsBloc, ContactsState>(
                builder: (context, state) {
              return ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      S.of(context).contacts_drawer_section_storages,
                      style: TextStyle(color: theme.disabledColor),
                    ),
                  ),
                  _buildStorages(context, state),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          S.of(context).contacts_drawer_section_groups,
                          style: TextStyle(color: theme.disabledColor),
                        ),
                        IconButton(
                          icon: Icon(Icons.add, color: theme.primaryColor),
                          onPressed: _addGroup,
                        ),
                      ],
                    ),
                  ),
                  _buildGroups(context, state),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildStorages(BuildContext context, ContactsState state) {
    final visibleStorages = state.storages?.where((s) => s.display);

    final isAllVisible = visibleStorages != null && visibleStorages.length > 1;
    if (visibleStorages != null) {
      return Column(
        children: [
          if (isAllVisible)
            ListTile(
              leading: Icon(MdiIcons.accountGroup),
              title: Text(S.of(context).contacts_drawer_storage_all),
              selected: state.showAllVisibleContacts == true,
              onTap: () {
                contactsBloc.add(SelectStorageGroup());
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
            ),
          ...visibleStorages.map((s) {
            if (s.id == StorageNames.personal) {
              return _buildStorageTile(
                  icon: WebMailIcons.personal, s: s, state: state);
            } else if (s.id == StorageNames.shared) {
              return _buildStorageTile(
                  icon: WebMailIcons.shared_with_all, s: s, state: state);
            } else if (s.id == StorageNames.team) {
              return _buildStorageTile(
                  icon: Icons.business_center, s: s, state: state);
            } else {
              return _buildStorageTile(
                  icon: WebMailIcons.personal, s: s, state: state);
            }
          }).toList(),
        ],
      );
    } else if (state.storages != null && state.storages.isEmpty) {
      return Center(child: Text(S.of(context).contacts_empty));
    } else {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(child: CircularProgressIndicator()),
      );
    }
  }

  Widget _buildStorageTile({
    @required ContactsStorage s,
    @required IconData icon,
    @required ContactsState state,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        s.displayName.length > 6 && s.displayName.substring(0, 6) == 'LABEL_'
            ? getStorageName(s.displayName.substring(6), context)
            : s.displayName == null
                ? s.name
                : s.displayName.toString(),
      ),
      selected: s.id == state.selectedStorage,
      onTap: () {
        contactsBloc.add(SelectStorageGroup(storage: s));
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      },
    );
  }

  Widget _buildGroups(BuildContext context, ContactsState state) {
    if (state.groups != null) {
      return Column(
        children: state.groups
            .map((g) => ListTile(
                  leading: Icon(MdiIcons.pound),
                  title: Text(g.name),
                  selected: g.uuid == state.selectedGroup,
                  onTap: () {
                    contactsBloc.add(SelectStorageGroup(group: g));
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                ))
            .toList(),
      );
    } else if (state.groups != null && state.groups.isEmpty) {
      return Center(child: Text(S.of(context).contacts_groups_empty));
    } else {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(child: CircularProgressIndicator()),
      );
    }
  }
}
