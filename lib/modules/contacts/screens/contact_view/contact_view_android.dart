import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/screens/contact_edit/contact_edit_route.dart';
import 'package:aurora_mail/modules/contacts/screens/contact_view/components/contact_view_app_bar.dart';
import 'package:aurora_mail/modules/contacts/screens/contact_view/components/contacts_info_item.dart';
import 'package:aurora_mail/modules/contacts/utils/contact_info.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/models/compose_actions.dart';
import 'package:aurora_mail/modules/mail/screens/compose/compose_route.dart';
import 'package:aurora_mail/shared_ui/confirmation_dialog.dart';
import 'package:aurora_mail/utils/date_formatting.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ContactViewAndroid extends StatefulWidget {
  final Contact contact;
  final ScaffoldState contactsListScaffoldState;

  const ContactViewAndroid(this.contact, this.contactsListScaffoldState);

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

  Future<void> _onMainAppBarActionSelected(ContactViewAppBarAction item) async {
    final bloc = BlocProvider.of<ContactsBloc>(context);
    switch (item) {
      case ContactViewAppBarAction.attach:
        Navigator.pushNamed(
          context,
          ComposeRoute.name,
          arguments: ComposeScreenArgs(
            mailBloc: BlocProvider.of<MailBloc>(context),
            contactsBloc: BlocProvider.of<ContactsBloc>(context),
            composeAction: SendContacts([widget.contact]),
          ),
        );
        break;
      case ContactViewAppBarAction.searchMessages:
      // TODO: Handle this case.
        break;
      case ContactViewAppBarAction.edit:
        Navigator.pushNamed(
          context,
          ContactEditRoute.name,
          arguments: ContactEditScreenArgs(
            bloc: BlocProvider.of<ContactsBloc>(context),
            contact: widget.contact,
          ),
        );
        break;
      case ContactViewAppBarAction.share:
        bloc.add(ShareContacts([widget.contact]));
        showSnack(
          context: context,
          scaffoldState: widget.contactsListScaffoldState,
          isError: false,
          msg: i18n(
            context,
            "contacts_shared_message",
            {"contact": widget.contact.fullName, "storage": i18n(context, "contacts_drawer_storage_shared")},
          ),
        );
        Navigator.pop(context);
        break;
      case ContactViewAppBarAction.unshare:
        bloc.add(UnshareContacts([widget.contact]));
        showSnack(
          context: context,
          scaffoldState: widget.contactsListScaffoldState,
          isError: false,
          msg: i18n(
            context,
            "contacts_shared_message",
            {"contact": widget.contact.fullName, "storage": i18n(context, "contacts_drawer_storage_personal")},
          ),
        );
        Navigator.pop(context);
        break;
      case ContactViewAppBarAction.delete:
        final result = await ConfirmationDialog.show(
          context,
          i18n(context, "contacts_delete_title"),
          i18n(context, "contacts_delete_desc_with_name", {"contact": widget.contact.fullName}),
          i18n(context, "btn_delete"),
          destructibleAction: true,
        );

        if (result == true) {
          bloc.add(DeleteContacts([widget.contact]));
          Navigator.pop(context);
        }
        break;
    }
  }

  void _emailToContacts(String email) {
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

  @override
  Widget build(BuildContext context) {
    final c = widget.contact;
    final birthDate = DateFormatting.formatBirthday(
      day: c.birthDay,
      month: c.birthMonth,
      year: c.birthYear,
      locale: Localizations.localeOf(context).languageCode,
      format: i18n(context, "contacts_birth_date_format"),
    );

    final sectionTitleTheme = Theme.of(context).textTheme.body2;

    final _mainInfo = _buildInfos([
      _buildInfoItem(
        icon: Icons.person_outline,
        label: i18n(context, "contacts_view_name"),
        v: c.fullName,
      ),
      _buildInfoItem(
        icon: Icons.alternate_email,
        label: i18n(context, "contacts_view_email"),
        v: _contactInfo.viewEmail,
        emailToContact: _emailToContacts,
      ),
      _buildInfoItem(
        icon: MdiIcons.phoneOutline,
        label: i18n(context, "contacts_view_phone"),
        v: _contactInfo.viewPhone,
      ),
      _buildInfoItem(
        icon: MdiIcons.mapMarkerOutline,
        label: i18n(context, "contacts_view_address"),
        v: _contactInfo.viewAddress,
      ),
      _buildInfoItem(
        icon: MdiIcons.skype,
        label: i18n(context, "contacts_view_skype"),
        v: c.skype,
      ),
      _buildInfoItem(
        icon: MdiIcons.facebook,
        label: i18n(context, "contacts_view_facebook"),
        v: c.facebook,
      ),
      _buildInfoItem(
        icon: Icons.person_outline,
        label: i18n(context, "contacts_view_first_name"),
        v: c.firstName,
      ),
      _buildInfoItem(
        icon: Icons.person_outline,
        label: i18n(context, "contacts_view_last_name"),
        v: c.lastName,
      ),
      _buildInfoItem(
        icon: Icons.person_outline,
        label: i18n(context, "contacts_view_nickname"),
        v: c.nickName,
      ),
    ]);

    final personalInfo = _buildInfos([
      _buildInfoItem(
        icon: Icons.alternate_email,
        label: i18n(context, "contacts_view_email"),
        v: c.personalEmail,
        emailToContact: _emailToContacts,
      ),
      _buildInfoItem(
        icon: MdiIcons.mapMarkerOutline,
        label: i18n(context, "contacts_view_address"),
        v: c.personalAddress,
      ),
      _buildInfoItem(
        icon: MdiIcons.homeCityOutline,
        label: i18n(context, "contacts_view_city"),
        v: c.personalCity,
      ),
      _buildInfoItem(
        icon: MdiIcons.map,
        label: i18n(context, "contacts_view_province"),
        v: c.personalState,
      ),
      _buildInfoItem(
        icon: MdiIcons.postOutline,
        label: i18n(context, "contacts_view_zip"),
        v: c.personalZip,
      ),
      _buildInfoItem(
        icon: MdiIcons.earth,
        label: i18n(context, "contacts_view_country"),
        v: c.personalCountry,
      ),
      _buildInfoItem(
        icon: Icons.web,
        label: i18n(context, "contacts_view_web_page"),
        v: c.personalWeb,
      ),
      _buildInfoItem(
        icon: MdiIcons.fax,
        label: i18n(context, "contacts_view_fax"),
        v: c.personalFax,
      ),
      _buildInfoItem(
        icon: MdiIcons.phoneOutline,
        label: i18n(context, "contacts_view_phone"),
        v: c.personalPhone,
      ),
      _buildInfoItem(
        icon: MdiIcons.cellphone,
        label: i18n(context, "contacts_view_mobile"),
        v: c.personalMobile,
      ),
    ]);

    final businessInfo = _buildInfos([
      _buildInfoItem(
        icon: Icons.alternate_email,
        label: i18n(context, "contacts_view_email"),
        v: c.businessEmail,
        emailToContact: _emailToContacts,
      ),
      _buildInfoItem(
        icon: MdiIcons.mapMarkerOutline,
        label: i18n(context, "contacts_view_address"),
        v: c.businessAddress,
      ),
      _buildInfoItem(
        icon: MdiIcons.homeCityOutline,
        label: i18n(context, "contacts_view_city"),
        v: c.businessCity,
      ),
      _buildInfoItem(
        icon: MdiIcons.map,
        label: i18n(context, "contacts_view_province"),
        v: c.businessState,
      ),
      _buildInfoItem(
        icon: MdiIcons.postOutline,
        label: i18n(context, "contacts_view_zip"),
        v: c.businessZip,
      ),
      _buildInfoItem(
        icon: MdiIcons.earth,
        label: i18n(context, "contacts_view_country"),
        v: c.businessCountry,
      ),
      _buildInfoItem(
        icon: MdiIcons.web,
        label: i18n(context, "contacts_view_web_page"),
        v: c.businessWeb,
      ),
      _buildInfoItem(
        icon: MdiIcons.fax,
        label: i18n(context, "contacts_view_fax"),
        v: c.businessFax,
      ),
      _buildInfoItem(
        icon: MdiIcons.cellphone,
        label: i18n(context, "contacts_view_phone"),
        v: c.businessPhone,
      ),
    ]);

    final otherInfo = _buildInfos([
      _buildInfoItem(
        icon: Icons.web,
        label: i18n(context, "contacts_view_web_page"),
        v: c.otherEmail,
      ),
      _buildInfoItem(
        icon: MdiIcons.calendar,
        label: i18n(context, "contacts_view_birthday"),
        v: birthDate,
      ),
      _buildInfoItem(
        icon: MdiIcons.text,
        label: i18n(context, "contacts_view_notes"),
        v: c.notes,),
    ]);

    return Scaffold(
      appBar: ContactViewAppBar(
        allowShare: c.storage == StorageNames.personal,
        allowUnshare: c.storage == StorageNames.shared,
        allowEdit: c.storage == StorageNames.personal || c.viewEmail == BlocProvider.of<AuthBloc>(context).currentAccount.email,
        allowDelete: c.storage == StorageNames.personal || c.storage == StorageNames.shared,
        onActionSelected: _onMainAppBarActionSelected,
      ),
      body: ListView(
        children: <Widget>[
          ..._mainInfo,
          if (personalInfo.isNotEmpty)
            Divider(indent: 16.0, endIndent: 16.0),
          if (personalInfo.isNotEmpty)
            ListTile(
              title: Text(
                i18n(context, "contacts_view_section_home"),
                style: sectionTitleTheme,
              ),
            ),
          ...personalInfo,
          if (businessInfo.isNotEmpty)
            Divider(indent: 16.0, endIndent: 16.0),
          if (businessInfo.isNotEmpty)
            ListTile(
              title: Text(
                i18n(context, "contacts_view_section_business"),
                style: sectionTitleTheme,
              ),
            ),
          ...businessInfo,
          if (otherInfo.isNotEmpty)
            Divider(indent: 16.0, endIndent: 16.0),
          if (otherInfo.isNotEmpty)
            ListTile(
              title: Text(
                i18n(context, "contacts_view_section_other_info"),
                style: sectionTitleTheme,
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

  Widget _buildInfoItem({
    @required IconData icon,
    @required String label,
    @required String v,
    void Function(String) emailToContact,
  }) {
    if (v.isNotEmpty) {
      return ContactsInfoItem(icon: icon, label: label, value: v, emailToContact: emailToContact);
    } else {
      return null;
    }
  }
}
