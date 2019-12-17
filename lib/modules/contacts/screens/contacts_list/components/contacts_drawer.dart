import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child:
            BlocBuilder<ContactsBloc, ContactsState>(builder: (context, state) {
          return ListView(
            children: <Widget>[
              _buildStorages(context, state),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildStorages(BuildContext context, ContactsState state) {
    if (state.storages != null && state.selectedStorage != null) {
      return Column(
        children: state.storages
            .where((s) => s.display)
            .map((s) => ListTile(
                  title: Text(s.name),
                  selected: s.sqliteId == state.selectedStorage,
                ))
            .toList(),
      );
    } else if (state.storages.isEmpty) {
      return Center(child: Text(i18n(context, "contacts_empty")));
    } else {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(child: CircularProgressIndicator()),
      );
    }
  }
}
