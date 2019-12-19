import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/contacts_bloc.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';
import 'package:aurora_mail/modules/contacts/screens/contact_view/components/contacts_info_item.dart';
import 'package:aurora_mail/modules/contacts/screens/group_edit/group_edit_route.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/group_view_app_bar.dart';

class GroupViewAndroid extends StatefulWidget {
  final ContactsGroup group;

  const GroupViewAndroid(this.group);

  @override
  _GroupViewAndroidState createState() => _GroupViewAndroidState();
}

class _GroupViewAndroidState extends State<GroupViewAndroid> {
  void _onAppBarActionSelected(GroupViewAppBarAction item) {
    final bloc = BlocProvider.of<ContactsBloc>(context);
    switch (item) {
      case GroupViewAppBarAction.sendMessage:
        break;
      case GroupViewAppBarAction.delete:
        bloc.add(DeleteGroup(widget.group));
        Navigator.pop(context);
        break;
      case GroupViewAppBarAction.edit:
        Navigator.pushNamed(
          context,
          GroupEditRoute.name,
          arguments: GroupEditScreenArgs(group: widget.group, bloc: bloc),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final g = widget.group;

    final _mainInfo = _buildInfos([
      _buildInfoItem(label: i18n(context, "contacts_view_section_group_name"), v: g.name),
      _buildInfoItem(label: i18n(context, "contacts_view_email"), v: g.email),
      _buildInfoItem(label: i18n(context, "contacts_view_company"), v: g.company),
      _buildInfoItem(label: i18n(context, "contacts_view_province"), v: g.state),
      _buildInfoItem(label: i18n(context, "contacts_view_city"), v: g.city),
      _buildInfoItem(label: i18n(context, "contacts_view_street_address"), v: g.street),
      _buildInfoItem(label: i18n(context, "contacts_view_zip"), v: g.zip),
      _buildInfoItem(label: i18n(context, "contacts_view_phone"), v: g.phone),
      _buildInfoItem(label: i18n(context, "contacts_view_fax"), v: g.fax),
      _buildInfoItem(label: i18n(context, "contacts_view_web_page"), v: g.web),
    ]);

    return Scaffold(
      appBar: GroupViewAppBar(onActionSelected: _onAppBarActionSelected),
      body: ListView(children: _mainInfo),
    );
  }

  List<Widget> _buildInfos(List<Widget> nullableWidgets) {
    return nullableWidgets.where((w) => w != null).toList();
  }

  Widget _buildInfoItem({IconData icon, String label, String v}) {
    if (v.isNotEmpty) {
      return ContactsInfoItem(icon: icon, label: label, value: v);
    } else {
      return null;
    }
  }
}
