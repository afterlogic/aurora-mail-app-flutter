import 'package:aurora_mail/generated/i18n.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/screens/contact_edit/contact_edit_route.dart';
import 'package:aurora_mail/modules/contacts/screens/contact_view/components/contact_view_app_bar.dart';
import 'package:aurora_mail/modules/contacts/utils/contact_info.dart';
import 'package:aurora_mail/utils/date_formatting.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ContactViewAndroid extends StatefulWidget {
  final Contact contact;

  const ContactViewAndroid(this.contact);

  @override
  _ContactViewAndroidState createState() => _ContactViewAndroidState();
}

class _ContactViewAndroidState extends State<ContactViewAndroid> {
  ContactInfo _contactInfo;

  @override
  void initState() {
    super.initState();
    _contactInfo = new ContactInfo(widget.contact);
  }

  void _onMainAppBarActionSelected(ContactViewAppBarAction item) {
    switch (item) {
      case ContactViewAppBarAction.attach:
        // TODO: Handle this case.
        break;
      case ContactViewAppBarAction.sendMessage:
        // TODO: Handle this case.
        break;
      case ContactViewAppBarAction.searchMessages:
        // TODO: Handle this case.
        break;
      case ContactViewAppBarAction.edit:
        Navigator.pushNamed(context, ContactEditRoute.name);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final c = widget.contact;
    final birthDate = DateFormatting.formatBirthday(
      day: c.birthDay,
      month: c.birthMonth,
      year: c.birthYear,
      locale: Localizations.localeOf(context).languageCode,
      format: s.contacts_birth_date_format,
    );

    final _mainInfo = _buildInfos([
      _buildInfoItem(icon: Icons.person_outline, v: c.fullName),
      _buildInfoItem(icon: MdiIcons.emailOutline, v: _contactInfo.viewEmail),
      _buildInfoItem(icon: MdiIcons.phoneOutline, v: _contactInfo.viewPhone),
      _buildInfoItem(icon: MdiIcons.mapMarkerOutline, v: _contactInfo.viewAddress),
      _buildInfoItem(icon: MdiIcons.skype, v: c.skype),
      _buildInfoItem(icon: MdiIcons.facebook, v: c.facebook),
    ]);

    final personalInfo = _buildInfos([
      _buildInfoItem(label: s.contacts_view_email, v: c.personalEmail),
      _buildInfoItem(label: s.contacts_view_address, v: c.personalAddress),
      _buildInfoItem(label: s.contacts_view_city, v: c.personalCity),
      _buildInfoItem(label: s.contacts_view_province, v: c.personalState),
      _buildInfoItem(label: s.contacts_view_zip, v: c.personalZip),
      _buildInfoItem(label: s.contacts_view_country, v: c.personalCountry),
      _buildInfoItem(label: s.contacts_view_web_page, v: c.personalWeb),
      _buildInfoItem(label: s.contacts_view_fax, v: c.personalFax),
      _buildInfoItem(label: s.contacts_view_phone, v: c.personalPhone),
      _buildInfoItem(label: s.contacts_view_mobile, v: c.personalMobile),
    ]);

    final businessInfo = _buildInfos([
      _buildInfoItem(label: s.contacts_view_email, v: c.businessEmail),
      _buildInfoItem(label: s.contacts_view_address, v: c.businessAddress),
      _buildInfoItem(label: s.contacts_view_city, v: c.businessCity),
      _buildInfoItem(label: s.contacts_view_province, v: c.businessState),
      _buildInfoItem(label: s.contacts_view_zip, v: c.businessZip),
      _buildInfoItem(label: s.contacts_view_country, v: c.businessCountry),
      _buildInfoItem(label: s.contacts_view_web_page, v: c.businessWeb),
      _buildInfoItem(label: s.contacts_view_fax, v: c.businessFax),
      _buildInfoItem(label: s.contacts_view_phone, v: c.businessPhone),
    ]);

    final otherInfo = _buildInfos([
      _buildInfoItem(label: s.contacts_view_web_page, v: c.otherEmail),
      _buildInfoItem(label: s.contacts_view_birthday, v: birthDate),
      _buildInfoItem(label: s.contacts_view_notes, v: c.notes),
    ]);

    return Scaffold(
      appBar: ContactViewAppBar(onActionSelected: _onMainAppBarActionSelected),
      body: ListView(
        children: <Widget>[
          ..._mainInfo,
          if (personalInfo.isNotEmpty)
            ListTile(
              title: Text(
                s.contacts_view_section_home,
                style: Theme.of(context).textTheme.title,
              ),
            ),
          ...personalInfo,
          if (businessInfo.isNotEmpty)
            ListTile(
              title: Text(
                s.contacts_view_section_business,
                style: Theme.of(context).textTheme.title,
              ),
            ),
          ...businessInfo,
          if (otherInfo.isNotEmpty)
            ListTile(
              title: Text(
                s.contacts_view_section_other_info,
                style: Theme.of(context).textTheme.title,
              ),
            ),
          ...otherInfo,
        ],
      ),
    );
  }

  List<Widget> _buildInfos(List<Widget> nullableWidgets) {
    return nullableWidgets.where((w) => w != null).toList();
  }

  Widget _buildInfoItem({IconData icon, String label, String v}) {
    if (v.isNotEmpty) {
      return Column(
        children: <Widget>[
          ListTile(
            leading: icon != null
                ? Icon(icon)
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("$label",
                          style: TextStyle(
                              color: Theme.of(context)
                                  .disabledColor
                                  .withOpacity(0.5)))
                    ],
                  ),
            title: Text(v),
          ),
          Divider(height: 0.0, indent: 16.0, endIndent: 16.0),
        ],
      );
    } else {
      return null;
    }
  }
}
