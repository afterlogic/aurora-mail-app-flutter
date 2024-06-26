//@dart=2.9
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/layout_config/layout_config.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';
import 'package:aurora_mail/modules/contacts/screens/contact_view/components/contacts_info_item.dart';
import 'package:aurora_mail/modules/contacts/screens/group_edit/group_edit_route.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/models/compose_actions.dart';
import 'package:aurora_mail/modules/mail/screens/compose/compose_route.dart';
import 'package:aurora_mail/shared_ui/confirmation_dialog.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
          S.of(context).contacts_group_delete_title,
          S.of(context).contacts_group_delete_desc_with_name(widget.group.name),
          S.of(context).btn_delete,
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

  void _emailToGroupEmail(String email) {
    Navigator.pushNamed(
      context,
      ComposeRoute.name,
      arguments: ComposeScreenArgs(
        mailBloc: BlocProvider.of<MailBloc>(context),
        contactsBloc: BlocProvider.of<ContactsBloc>(context),
        composeAction: EmailToContacts([email]),
      ),
    );
  }

  void _callGroupPhone(String phone) => launch("tel://$phone");

  void _visitWebsite(String site) => launch(site);

  @override
  Widget build(BuildContext context) {
    final g = widget.group;

    final _mainInfo = _buildInfos([
      _buildInfoItem(
        icon: MdiIcons.accountGroup,
        label: S.of(context).contacts_view_section_group_name,
        v: g.name,
      ),
      _buildInfoItem(
        icon: Icons.alternate_email,
        label: S.of(context).contacts_view_email,
        v: g.email,
        action: InfoAction.email,
        cb: () => _emailToGroupEmail(g.email),
      ),
      _buildInfoItem(
        icon: MdiIcons.domain,
        label: S.of(context).contacts_view_company,
        v: g.company,
      ),
      _buildInfoItem(
        icon: MdiIcons.earth,
        label: S.of(context).contacts_view_country,
        v: g.country,
      ),
      _buildInfoItem(
        icon: MdiIcons.map,
        label: S.of(context).contacts_view_province,
        v: g.state,
      ),
      _buildInfoItem(
        icon: MdiIcons.homeCityOutline,
        label: S.of(context).contacts_view_city,
        v: g.city,
      ),
      _buildInfoItem(
        icon: MdiIcons.mapMarkerOutline,
        label: S.of(context).contacts_view_street_address,
        v: g.street,
      ),
      _buildInfoItem(
        icon: MdiIcons.postOutline,
        label: S.of(context).contacts_view_zip,
        v: g.zip,
      ),
      _buildInfoItem(
        icon: MdiIcons.phone,
        label: S.of(context).contacts_view_phone,
        v: g.phone,
        action: InfoAction.call,
        cb: () => _callGroupPhone(g.phone),
      ),
      _buildInfoItem(
        icon: MdiIcons.fax,
        label: S.of(context).contacts_view_fax,
        v: g.fax,
      ),
      _buildInfoItem(
        icon: MdiIcons.web,
        label: S.of(context).contacts_view_web_page,
        v: g.web,
        action: InfoAction.visitWebsite,
        cb: () => _visitWebsite(g.web),
      ),
    ]);
    return Scaffold(
      appBar: GroupViewAppBar(onActionSelected: _onAppBarActionSelected),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: LayoutConfig.formWidth,
          ),
          child: ListView(
            children: _mainInfo,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildInfos(List<Widget> nullableWidgets) {
    return nullableWidgets.where((w) => w != null).toList();
  }

  Widget _buildInfoItem({
    @required IconData icon,
    @required String label,
    @required String v,
    InfoAction action = InfoAction.none,
    void Function() cb,
  }) {
    if (v.isNotEmpty) {
      return ContactsInfoItem(
        icon: icon,
        label: label,
        value: v,
        cb: cb,
        action: action,
      );
    } else {
      return null;
    }
  }
}
