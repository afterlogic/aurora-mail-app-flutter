import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/contacts_bloc.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';
import 'package:aurora_mail/modules/contacts/screens/contact_view/components/contacts_info_item.dart';
import 'package:aurora_mail/modules/contacts/screens/group_edit/group_edit_route.dart';
import 'package:aurora_mail/shared_ui/confirmation_dialog.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';import 'package:aurora_mail/utils/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'components/group_view_app_bar.dart';

class GroupViewAndroid extends StatefulWidget {
  final ContactsGroup group;

  const GroupViewAndroid(this.group);

  @override
  _GroupViewAndroidState createState() => _GroupViewAndroidState();
}

class _GroupViewAndroidState extends BState<GroupViewAndroid> {
  Future<void> _onAppBarActionSelected(GroupViewAppBarAction item) async {
    final bloc = BlocProvider.of<ContactsBloc>(context);
    switch (item) {
      case GroupViewAppBarAction.sendMessage:
        break;
      case GroupViewAppBarAction.delete:
        final delete = await ConfirmationDialog.show(
          context,
          i18n(context, "contacts_group_delete_title"),
          i18n(context, "contacts_group_delete_desc_with_name", {"group": widget.group.name}),
          i18n(context, "btn_delete"),
          destructibleAction: true,
        );

        if (delete == true) {
          bloc.add(DeleteGroup(widget.group));
          Navigator.pop(context);
        }
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
      _buildInfoItem(
        icon: MdiIcons.accountGroup,
        label: i18n(context, "contacts_view_section_group_name"),
        v: g.name,
      ),
      _buildInfoItem(
        icon: Icons.alternate_email,
        label: i18n(context, "contacts_view_email"),
        v: g.email,
      ),
      _buildInfoItem(
        icon: MdiIcons.domain,
        label: i18n(context, "contacts_view_company"),
        v: g.company,
      ),
      _buildInfoItem(
        icon: MdiIcons.earth,
        label: i18n(context, "contacts_view_country"),
        v: g.country,
      ),
      _buildInfoItem(
        icon: MdiIcons.map,
        label: i18n(context, "contacts_view_province"),
        v: g.state,
      ),
      _buildInfoItem(
        icon: MdiIcons.homeCityOutline,
        label: i18n(context, "contacts_view_city"),
        v: g.city,
      ),
      _buildInfoItem(
        icon: MdiIcons.mapMarkerOutline,
        label: i18n(context, "contacts_view_street_address"),
        v: g.street,
      ),
      _buildInfoItem(
        icon: MdiIcons.postOutline,
        label: i18n(context, "contacts_view_zip"),
        v: g.zip,
      ),
      _buildInfoItem(
        icon: MdiIcons.phone,
        label: i18n(context, "contacts_view_phone"),
        v: g.phone,
      ),
      _buildInfoItem(
        icon: MdiIcons.fax,
        label: i18n(context, "contacts_view_fax"),
        v: g.fax,
      ),
      _buildInfoItem(
        icon: MdiIcons.web,
        label: i18n(context, "contacts_view_web_page"),
        v: g.web,
      ),
    ]);

    return Scaffold(
      appBar: GroupViewAppBar(onActionSelected: _onAppBarActionSelected),
      body: ListView(children: _mainInfo),
    );
  }

  List<Widget> _buildInfos(List<Widget> nullableWidgets) {
    return nullableWidgets.where((w) => w != null).toList();
  }

  Widget _buildInfoItem({@required IconData icon, @required String label, @required String v}) {
    if (v.isNotEmpty) {
      return ContactsInfoItem(icon: icon, label: label, value: v);
    } else {
      return null;
    }
  }
}
