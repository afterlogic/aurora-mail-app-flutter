import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
import 'package:aurora_mail/modules/contacts/screens/group_edit/group_edit_route.dart';
import 'package:aurora_mail/res/icons/webmail_icons.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ContactsDrawer extends StatefulWidget {
  @override
  _ContactsDrawerState createState() => _ContactsDrawerState();
}

class _ContactsDrawerState extends State<ContactsDrawer> {

  void _addGroup() {
    Navigator.pushNamed(
      context,
      GroupEditRoute.name,
      arguments: GroupEditScreenArgs(bloc: BlocProvider.of<ContactsBloc>(context)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListTileTheme(
        selectedColor: Theme.of(context).accentColor,
        style: ListTileStyle.drawer,
        child: SafeArea(
          child: BlocBuilder<ContactsBloc, ContactsState>(builder: (context, state) {
            return ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    i18n(context, "contacts_drawer_section_storages").toUpperCase(),
                    style: TextStyle(color: Theme.of(context).disabledColor),
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
                        i18n(context, "contacts_drawer_section_groups").toUpperCase(),
                        style: TextStyle(color: Theme.of(context).disabledColor),
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color: Theme.of(context).accentColor),
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
    );
  }

  Widget _buildStorages(BuildContext context, ContactsState state) {
    final bloc = BlocProvider.of<ContactsBloc>(context);
    final visibleStorages = state.storages?.where((s) => s.display);

    if (visibleStorages != null) {
      return Column(
        children: [
          ListTile(
            leading: Icon(MdiIcons.accountGroup),
            title: Text(i18n(context, "contacts_drawer_storage_all")),
            selected: state.showAllVisibleContacts,
            onTap: () {
              bloc.add(SelectStorageGroup());
              Navigator.pop(context);
            },
          ),
          ...visibleStorages
            .map((s) {
          if (s.id == StorageNames.personal) {
            return _buildStorageTile(name: s.id, icon: WebMailIcons.personal, s: s, state: state);
          } else if (s.id == StorageNames.shared) {
            return _buildStorageTile(name: s.id, icon: WebMailIcons.shared_with_all, s: s, state: state);
          } else if (s.id == StorageNames.team) {
            return _buildStorageTile(name: s.id, icon: Icons.business_center, s: s, state: state);
          } else {
            return _buildStorageTile(icon: MdiIcons.folderAccountOutline, s: s, state: state);
          }
        }).toList(),
        ],
      );
    } else if (state.storages != null && state.storages.isEmpty) {
      return Center(child: Text(i18n(context, "contacts_empty")));
    } else {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(child: CircularProgressIndicator()),
      );
    }
  }

  Widget _buildStorageTile({
    String name,
    @required ContactsStorage s,
    @required IconData icon,
    @required ContactsState state,
  }) {
    final bloc = BlocProvider.of<ContactsBloc>(context);
    return ListTile(
      leading: Icon(icon),
      title: Text(name != null ? i18n(context, "contacts_drawer_storage_$name") : s.name),
      selected: s.sqliteId == state.selectedStorage,
      onTap: () {
        bloc.add(SelectStorageGroup(storage: s));
        Navigator.pop(context);
      },
    );
  }

  Widget _buildGroups(BuildContext context, ContactsState state) {
    final bloc = BlocProvider.of<ContactsBloc>(context);

    if (state.groups != null) {
      return Column(
        children: state.groups
            .map((g) =>
            ListTile(
              leading: Icon(MdiIcons.pound),
              title: Text(g.name),
                  selected: g.uuid == state.selectedGroup,
                  onTap: () {
                    bloc.add(SelectStorageGroup(group: g));
                    Navigator.pop(context);
                  },
                ))
            .toList(),
      );
    } else if (state.groups != null && state.groups.isEmpty) {
      return Center(child: Text(i18n(context, "contacts_groups_empty")));
    } else {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(child: CircularProgressIndicator()),
      );
    }
  }
}
