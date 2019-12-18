import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsDrawer extends StatefulWidget {
  @override
  _ContactsDrawerState createState() => _ContactsDrawerState();
}

class _ContactsDrawerState extends State<ContactsDrawer> {
//  @override
//  void didChangeDependencies() {
//    super.didChangeDependencies();
//    BlocProvider.of<ContactsBloc>(context).add(GetContacts());
//  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: BlocBuilder<ContactsBloc, ContactsState>(builder: (context, state) {
          return ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  i18n(context, "contacts_drawer_section_storages"),
                  style: TextStyle(color: Theme.of(context).disabledColor),
                ),
              ),
              _buildStorages(context, state),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  i18n(context, "contacts_drawer_section_groups"),
                  style: TextStyle(color: Theme.of(context).disabledColor),
                ),
              ),
              _buildGroups(context, state),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildStorages(BuildContext context, ContactsState state) {
    final bloc = BlocProvider.of<ContactsBloc>(context);

    if (state.storages != null && state.selectedStorage != null) {
      return Column(
        children: state.storages
            .where((s) => s.display)
            .map((s) => ListTile(
                  title: Text(s.name),
                  selected: s.sqliteId == state.selectedStorage,
                  onTap: () {
                    bloc.add(SelectStorageGroup(storage: s));
                    Navigator.pop(context);
                  },
                ))
            .toList(),
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

  Widget _buildGroups(BuildContext context, ContactsState state) {
    final bloc = BlocProvider.of<ContactsBloc>(context);

    if (state.groups != null && state.selectedGroup != null) {
      return Column(
        children: state.groups
            .map((g) => ListTile(
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
