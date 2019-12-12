import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
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
              _buildStorages(state),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildStorages(ContactsState state) {
    if (state.storages != null) {
      return Column(
        children: state.storages
            .where((s) => s.display)
            .map((s) => ListTile(title: Text(s.name)))
            .toList(),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(child: CircularProgressIndicator()),
      );
    }
  }
}
