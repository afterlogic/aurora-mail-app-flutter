//@dart=2.9
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/layout_config/layout_config.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';
import 'package:aurora_mail/modules/contacts/screens/contacts_list/contacts_list_route.dart';
import 'package:aurora_mail/modules/dialog_wrap.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/group_edit_app_bar.dart';

class GroupEditAndroid extends StatefulWidget {
  final ContactsGroup group;

  const GroupEditAndroid({this.group});

  @override
  _GroupEditAndroidState createState() => _GroupEditAndroidState();
}

class _GroupEditAndroidState extends BState<GroupEditAndroid>
    with NotSavedChangesMixin {
  bool _isOrg = false;
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _companyCtrl = TextEditingController();
  final _countryCtrl = TextEditingController();
  final _stateCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _streetCtrl = TextEditingController();
  final _zipCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _faxCtrl = TextEditingController();
  final _webCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.group != null) _initGroup(widget.group);
  }

  void _initGroup(ContactsGroup g) {
    _isOrg = g.isOrganization;
    _nameCtrl.text = g.name;
    _emailCtrl.text = g.email;
    _companyCtrl.text = g.company;
    _countryCtrl.text = g.country;
    _stateCtrl.text = g.state;
    _cityCtrl.text = g.city;
    _streetCtrl.text = g.street;
    _zipCtrl.text = g.zip;
    _phoneCtrl.text = g.phone;
    _faxCtrl.text = g.fax;
    _webCtrl.text = g.web;
  }

  void _onAppBarActionSelected(
      BuildContext context, GroupEditAppBarAction item) {
    switch (item) {
      case GroupEditAppBarAction.save:
        if (_nameCtrl.text.isEmpty) {
          return showSnack(
            context: context,
            scaffoldState: Scaffold.of(context),
            message: S.of(context).error_contacts_save_name_empty,
          );
        }
        FocusScope.of(context).unfocus();

        final group = _getDataFromInputs();
        final event =
            widget.group != null ? UpdateGroup(group) : CreateGroup(group);
        BlocProvider.of<ContactsBloc>(context).add(event);
        Navigator.popUntil(
            context, ModalRoute.withName(ContactsListRoute.name));
        break;
    }
  }

  ContactsGroup _getDataFromInputs() {
    final user = BlocProvider.of<AuthBloc>(context).currentUser;

    return ContactsGroup(
      uuid: widget.group?.uuid ?? '',
      userLocalId: widget.group?.userLocalId ?? user.localId,
      idUser: widget.group?.idUser ?? user.serverId,
      name: _nameCtrl.text,
      email: _emailCtrl.text,
      company: _companyCtrl.text,
      country: _countryCtrl.text,
      state: _stateCtrl.text,
      city: _cityCtrl.text,
      street: _streetCtrl.text,
      zip: _zipCtrl.text,
      phone: _phoneCtrl.text,
      fax: _faxCtrl.text,
      web: _webCtrl.text,
      isOrganization: _isOrg,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GroupEditAppBar(_onAppBarActionSelected, widget.group != null),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: LayoutConfig.formWidth,
          ),
          child: ListView(
            children: <Widget>[
              _buildInput(
                  S.of(context).contacts_view_section_group_name, _nameCtrl),
              SwitchListTile.adaptive(
                title: Text(S.of(context).contacts_group_edit_is_organization),
                value: _isOrg,
                activeColor: theme.primaryColor,
                onChanged: (v) => setState(() => _isOrg = v),
              ),
              if (_isOrg)
                Column(
                  children: <Widget>[
                    _buildInput(S.of(context).contacts_view_email, _emailCtrl,
                        TextInputType.emailAddress),
                    _buildInput(
                        S.of(context).contacts_view_company, _companyCtrl),
                    _buildInput(
                        S.of(context).contacts_view_country, _countryCtrl),
                    _buildInput(
                        S.of(context).contacts_view_province, _stateCtrl),
                    _buildInput(S.of(context).contacts_view_city, _cityCtrl),
                    _buildInput(S.of(context).contacts_view_street_address,
                        _streetCtrl),
                    _buildInput(S.of(context).contacts_view_zip, _zipCtrl),
                    _buildInput(S.of(context).contacts_view_phone, _phoneCtrl,
                        TextInputType.phone),
                    _buildInput(S.of(context).contacts_view_fax, _faxCtrl),
                    _buildInput(S.of(context).contacts_view_web_page, _webCtrl,
                        TextInputType.url),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput(
    String label,
    TextEditingController ctrl, [
    TextInputType type,
  ]) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        controller: ctrl,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          alignLabelWithHint: true,
        ),
      ),
    );
  }
}
