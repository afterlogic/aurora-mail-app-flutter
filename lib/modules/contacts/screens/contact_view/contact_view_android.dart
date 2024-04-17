//@dart=2.9
import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';
import 'package:aurora_mail/modules/contacts/screens/components/groups_select_dialog.dart';
import 'package:aurora_mail/modules/contacts/screens/contact_edit/components/contact_check_box.dart';
import 'package:aurora_mail/modules/contacts/screens/contact_edit/contact_edit_route.dart';
import 'package:aurora_mail/modules/contacts/screens/contact_view/components/contact_view_app_bar.dart';
import 'package:aurora_mail/modules/contacts/screens/contact_view/components/contacts_info_item.dart';
import 'package:aurora_mail/modules/contacts/utils/contact_info.dart';
import 'package:aurora_mail/modules/layout_config/layout_config.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/models/compose_actions.dart';
import 'package:aurora_mail/modules/mail/repository/search_util.dart';
import 'package:aurora_mail/modules/mail/screens/compose/compose_route.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/messages_list_route.dart';
import 'package:aurora_mail/modules/settings/blocs/pgp_settings/bloc.dart';
import 'package:aurora_mail/modules/settings/screens/pgp_settings/dialogs/import_key_dialog.dart';
import 'package:aurora_mail/modules/settings/screens/pgp_settings/screens/pgp_key_route.dart';
import 'package:aurora_mail/shared_ui/confirmation_dialog.dart';
import 'package:aurora_mail/shared_ui/optional_dialog.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/date_formatting.dart';
import 'package:aurora_mail/utils/identity_util.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:crypto_model/crypto_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactViewAndroid extends StatefulWidget {
  final Contact contact;
  final ScaffoldState contactsListScaffoldState;
  final PgpSettingsBloc pgpSettingsBloc;
  final bool isPart;
  final Function onClose;

  const ContactViewAndroid(
    this.contact,
    this.contactsListScaffoldState,
    this.pgpSettingsBloc, {
    this.isPart = false,
    this.onClose,
  });

  @override
  _ContactViewAndroidState createState() => _ContactViewAndroidState();
}

class _ContactViewAndroidState extends BState<ContactViewAndroid> {
  Contact contact;
  ContactInfo _contactInfo;
  PgpKeyWithContact pgpKey;
  PgpSettingsBloc pgpSettingsBloc;
  ContactsBloc contactsBloc;

  @override
  void initState() {
    super.initState();

    pgpSettingsBloc = widget.pgpSettingsBloc;
    contactsBloc = BlocProvider.of<ContactsBloc>(context);
    init(widget.contact);
  }

  init(Contact contact) {
    this.contact = contact;
    _contactInfo = new ContactInfo(contact);
    if (BuildProperty.cryptoEnable && !BuildProperty.legacyPgpKey) {
      if (contact?.pgpPublicKey != null) {
        contactsBloc.getKeyInfo(contact.pgpPublicKey).then((key) {
          if (key == null) {
            this.pgpKey = null;
          } else {
            this.pgpKey = PgpKeyWithContact(key, contact);
          }
          if (mounted) setState(() {});
        });
      } else {
        this.pgpKey = null;
        if (mounted) setState(() {});
      }
    }
  }

  void _onClose() {
    if (widget.isPart) {
      widget.onClose();
    } else {
      Navigator.pop(context);
    }
  }

  Future<void> _onMainAppBarActionSelected(ContactViewAppBarAction item) async {
    final bloc = BlocProvider.of<ContactsBloc>(context);
    switch (item) {
      case ContactViewAppBarAction.find_in_email:
        Navigator.pushReplacementNamed(
          context,
          MessagesListRoute.name,
          arguments: MessagesListRouteArg(
            search:
                searchUtil.wrap(SearchPattern.Email, _contactInfo.viewEmail),
          ),
        );
        break;
      case ContactViewAppBarAction.attach:
        Navigator.pushNamed(
          context,
          ComposeRoute.name,
          arguments: ComposeScreenArgs(
            mailBloc: BlocProvider.of<MailBloc>(context),
            contactsBloc: BlocProvider.of<ContactsBloc>(context),
            composeAction: SendContacts([contact]),
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
            pgpSettingsBloc,
            bloc: BlocProvider.of<ContactsBloc>(context),
            contact: contact,
          ),
        );
        break;
      case ContactViewAppBarAction.share:
        bloc.add(ShareContacts([contact]));
        showSnack(
          context: context,
          scaffoldState: widget.contactsListScaffoldState,
          isError: false,
          message: S.of(context).contacts_shared_message(
              contact.fullName, S.of(context).contacts_drawer_storage_shared),
        );
        _onClose();
        break;
      case ContactViewAppBarAction.unshare:
        bloc.add(UnshareContacts([contact]));
        showSnack(
          context: context,
          scaffoldState: widget.contactsListScaffoldState,
          isError: false,
          message: S.of(context).contacts_shared_message(
              contact.fullName, S.of(context).contacts_drawer_storage_personal),
        );
        _onClose();
        break;
      case ContactViewAppBarAction.delete:
        final result = await ConfirmationDialog.show(
          context,
          S.of(context).contacts_delete_title,
          S.of(context).contacts_delete_desc_with_name(contact.fullName),
          S.of(context).btn_delete,
          destructibleAction: true,
        );

        if (result == true) {
          bloc.add(DeleteContacts([contact]));
          _onClose();
        }
        break;
      case ContactViewAppBarAction.add_to_group:
        final result = await GroupsSelectDialog.show(context, bloc.state.groups,);
        if(result == null){
          break;
        }
        bloc.add(AddContactsToGroup([result], [contact]));
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

  void _callContact(String phone) => launch("tel://$phone");

  void _visitWebsite(String site) => launch(site);

  @override
  Widget build(BuildContext context) {
    final c = contact;
    final birthDate = DateFormatting.formatBirthday(
      day: c.birthDay,
      month: c.birthMonth,
      year: c.birthYear,
      locale: Localizations.localeOf(context).languageCode,
      format: S.of(context).format_contacts_birth_date,
    );

    final sectionTitleTheme = theme.textTheme.bodyText1;

    final _mainInfo = _buildInfos([
//      _buildInfoItem(
//        icon: Icons.person_outline,
//        label: i18n(context, S.contacts_view_name),
//        v: c.fullName,
//      ),
      _buildInfoItem(
        icon: Icons.alternate_email,
        label: S.of(context).contacts_view_email,
        v: _contactInfo.viewEmail,
        action: InfoAction.email,
        cb: () => _emailToContacts(_contactInfo.viewEmail),
      ),
      _buildInfoItem(
        icon: MdiIcons.phone,
        label: S.of(context).contacts_view_phone,
        v: _contactInfo.viewPhone,
        action: InfoAction.call,
        cb: () => _callContact(_contactInfo.viewPhone),
      ),
      _buildInfoItem(
        icon: MdiIcons.mapMarkerOutline,
        label: S.of(context).contacts_view_address,
        v: _contactInfo.viewAddress,
      ),
      _buildInfoItem(
        icon: MdiIcons.skype,
        label: S.of(context).contacts_view_skype,
        v: c.skype,
      ),
      _buildInfoItem(
        icon: MdiIcons.facebook,
        label: S.of(context).contacts_view_facebook,
        v: c.facebook,
      ),
      _buildInfoItem(
        icon: Icons.person_outline,
        label: S.of(context).contacts_view_first_name,
        v: c.firstName,
      ),
      _buildInfoItem(
        icon: Icons.person_outline,
        label: S.of(context).contacts_view_last_name,
        v: c.lastName,
      ),
      _buildInfoItem(
        icon: Icons.person_outline,
        label: S.of(context).contacts_view_nickname,
        v: c.nickName,
      ),
    ]);

    final personalInfo = _buildInfos([
      if (_contactInfo.viewEmail != c.personalEmail)
        _buildInfoItem(
          icon: Icons.alternate_email,
          label: S.of(context).contacts_view_email,
          v: c.personalEmail,
          action: InfoAction.email,
          cb: () => _emailToContacts(c.personalEmail),
        ),
      if (_contactInfo.viewAddress != c.personalAddress)
        _buildInfoItem(
          icon: MdiIcons.mapMarkerOutline,
          label: S.of(context).contacts_view_address,
          v: c.personalAddress,
        ),
      _buildInfoItem(
        icon: MdiIcons.homeCityOutline,
        label: S.of(context).contacts_view_city,
        v: c.personalCity,
      ),
      _buildInfoItem(
        icon: MdiIcons.map,
        label: S.of(context).contacts_view_province,
        v: c.personalState,
      ),
      _buildInfoItem(
        icon: MdiIcons.postOutline,
        label: S.of(context).contacts_view_zip,
        v: c.personalZip,
      ),
      _buildInfoItem(
        icon: MdiIcons.earth,
        label: S.of(context).contacts_view_country,
        v: c.personalCountry,
      ),
      _buildInfoItem(
        icon: Icons.web,
        label: S.of(context).contacts_view_web_page,
        v: c.personalWeb,
        action: InfoAction.visitWebsite,
        cb: () => _visitWebsite(c.personalWeb),
      ),
      _buildInfoItem(
        icon: MdiIcons.fax,
        label: S.of(context).contacts_view_fax,
        v: c.personalFax,
      ),
      if (_contactInfo.viewPhone != c.personalPhone)
        _buildInfoItem(
          icon: MdiIcons.phone,
          label: S.of(context).contacts_view_phone,
          v: c.personalPhone,
          action: InfoAction.call,
          cb: () => _callContact(c.personalPhone),
        ),
      if (_contactInfo.viewPhone != c.personalMobile)
        _buildInfoItem(
          icon: MdiIcons.cellphone,
          label: S.of(context).contacts_view_mobile,
          v: c.personalMobile,
          action: InfoAction.call,
          cb: () => _callContact(c.personalMobile),
        ),
    ]);

    final businessInfo = _buildInfos([
      if (_contactInfo.viewEmail != c.businessEmail)
        _buildInfoItem(
          icon: Icons.alternate_email,
          label: S.of(context).contacts_view_email,
          v: c.businessEmail,
          action: InfoAction.email,
          cb: () => _emailToContacts(c.businessEmail),
        ),
      if (_contactInfo.viewAddress != c.businessAddress)
        _buildInfoItem(
          icon: MdiIcons.mapMarkerOutline,
          label: S.of(context).contacts_view_address,
          v: c.businessAddress,
        ),
      _buildInfoItem(
        icon: MdiIcons.homeCityOutline,
        label: S.of(context).contacts_view_city,
        v: c.businessCity,
      ),
      _buildInfoItem(
        icon: MdiIcons.map,
        label: S.of(context).contacts_view_province,
        v: c.businessState,
      ),
      _buildInfoItem(
        icon: MdiIcons.postOutline,
        label: S.of(context).contacts_view_zip,
        v: c.businessZip,
      ),
      _buildInfoItem(
        icon: MdiIcons.earth,
        label: S.of(context).contacts_view_country,
        v: c.businessCountry,
      ),
      _buildInfoItem(
        icon: MdiIcons.web,
        label: S.of(context).contacts_view_web_page,
        v: c.businessWeb,
        action: InfoAction.visitWebsite,
        cb: () => _visitWebsite(c.businessWeb),
      ),
      _buildInfoItem(
        icon: MdiIcons.fax,
        label: S.of(context).contacts_view_fax,
        v: c.businessFax,
      ),
      if (_contactInfo.viewPhone != c.businessPhone)
        _buildInfoItem(
          icon: MdiIcons.cellphone,
          label: S.of(context).contacts_view_phone,
          v: c.businessPhone,
          action: InfoAction.call,
          cb: () => _callContact(c.businessPhone),
        ),
    ]);

    final otherInfo = _buildInfos([
      if (_contactInfo.viewEmail != c.otherEmail)
        _buildInfoItem(
          icon: Icons.alternate_email,
          label: S.of(context).contacts_view_other_email,
          v: c.otherEmail,
          action: InfoAction.email,
          cb: () => _emailToContacts(c.otherEmail),
        ),
      _buildInfoItem(
        icon: MdiIcons.calendar,
        label: S.of(context).contacts_view_birthday,
        v: birthDate,
      ),
      _buildInfoItem(
        icon: MdiIcons.text,
        label: S.of(context).contacts_view_notes,
        v: c.notes,
      ),
    ]);

    final keyInfo = pgpKey == null
        ? null
        : Column(
            children: [
              InkWell(
                onTap: pgpKey == null
                    ? null
                    : () {
                        Navigator.pushNamed(
                          context,
                          PgpKeyRoute.name,
                          arguments: PgpKeyRouteArg(
                              pgpKey, null, true, pgpSettingsBloc),
                        );
                      },
                child: _buildInfoItem(
                  icon: MdiIcons.key,
                  label: S.of(context).label_pgp_public_key,
                  v: pgpKey == null
                      ? ""
                      : pgpKey.formatName() +
                          "\n${pgpKey.key?.length != null ? "(${pgpKey.length}-bit," : "("} ${pgpKey.isPrivate ? "private" : "public"})",
                ),
              ),
              if (c.storage == StorageNames.team) ...[
                ContactCheckBox(
                  S.of(context).label_pgp_sign,
                  c.autoSign,
                  (v) {
                    print(v);
                    pgpSettingsBloc.add(UpdateKeyFlags(
                        contact: c,
                        pgpSignMessages: v,
                        pgpEncryptMessages: c.autoEncrypt ?? false));
                  },
                ),
                ContactCheckBox(
                  S.of(context).label_pgp_encrypt,
                  c.autoEncrypt,
                  (v) {
                    pgpSettingsBloc.add(UpdateKeyFlags(
                        contact: c,
                        pgpEncryptMessages: v,
                        pgpSignMessages: c.autoSign ?? false));
                  },
                ),
              ]
            ],
          );

    List<Widget> _buildGroups(List<String> groupUUIDs) {
      final widgets = <Widget>[];
      final bloc = BlocProvider.of<ContactsBloc>(context);

      for (ContactsGroup group in bloc.state.groups ?? []) {
        if (groupUUIDs.contains(group.uuid)) {
          widgets.add(SizedBox(
            height: 43,
            child: Chip(
              label: Text(group.name),
            ),
          ));
        }
      }
      return widgets;
    }

    final groupInfo = _buildGroups(c.groupUUIDs);
    return Scaffold(
      appBar: widget.isPart
          ? null
          : ContactViewAppBar(
              name: c.fullName,
              allowShare: c.storage == StorageNames.personal,
              allowUnshare: c.storage == StorageNames.shared,
              allowEdit: c.storage == StorageNames.personal ||
                  c.viewEmail ==
                      BlocProvider.of<AuthBloc>(context).currentAccount.email,
              allowDelete: c.storage == StorageNames.personal ||
                  c.storage == StorageNames.shared,
              onActionSelected: _onMainAppBarActionSelected,
              hasEmail: _contactInfo.viewEmail?.isNotEmpty == true,
            ),
      body: BlocListener<ContactsBloc, ContactsState>(
        bloc: contactsBloc,
        listener: (context, state) async {
          final newContact = state.contacts.firstWhere((e) => e.uuid == c.uuid);
          final isGroupsUpdated = !listEquals(newContact.groupUUIDs, c.groupUUIDs);
          if(isGroupsUpdated){
            final result = await contactsBloc.getContact(contact.entityId);
            init(result);
          }
        },
        child: BlocListener(
          bloc: pgpSettingsBloc,
          listener: (BuildContext context, state) async {
            if (state is LoadedState || state is KeyFlagsUpdated) {
              final result = await contactsBloc.getContact(contact.entityId);
              init(result);
            }
            if (state is CompleteDownload) {
              showSnack(
                isError: false,
                context: context,
                scaffoldState: Scaffold.of(context),
                message: S.of(context).label_pgp_downloading_to(state.filePath),
              );
            }
            if (state is SelectKeyForImport) {
              _importKey(state.userKeys, state.contactKeys);
              return;
            }
            if (state is ErrorState) {
              showErrorSnack(
                context: context,
                scaffoldState: Scaffold.of(context),
                msg: state.message,
              );
            }
          },
          child: Builder(builder: (context) {
            final child = ListView(
              children: <Widget>[
                ..._mainInfo,
                if (personalInfo.isNotEmpty)
                  Divider(indent: 16.0, endIndent: 16.0),
                if (personalInfo.isNotEmpty)
                  ListTile(
                    title: Text(
                      S.of(context).contacts_view_section_home,
                      style: sectionTitleTheme,
                    ),
                  ),
                ...personalInfo,
                if (businessInfo.isNotEmpty)
                  Divider(indent: 16.0, endIndent: 16.0),
                if (businessInfo.isNotEmpty)
                  ListTile(
                    title: Text(
                      S.of(context).contacts_view_section_business,
                      style: sectionTitleTheme,
                    ),
                  ),
                ...businessInfo,
                if (otherInfo.isNotEmpty)
                  Divider(indent: 16.0, endIndent: 16.0),
                if (otherInfo.isNotEmpty)
                  ListTile(
                    title: Text(
                      S.of(context).contacts_view_section_other_info,
                      style: sectionTitleTheme,
                    ),
                  ),
                ...otherInfo,
                if (BuildProperty.cryptoEnable && keyInfo != null)
                  Divider(indent: 16.0, endIndent: 16.0),
                if (BuildProperty.cryptoEnable && keyInfo != null) keyInfo,
                if (groupInfo.isNotEmpty)
                  Divider(indent: 16.0, endIndent: 16.0),
                if (groupInfo.isNotEmpty)
                  ListTile(
                    title: Text(
                      S.of(context).contacts_view_section_groups,
                      style: sectionTitleTheme,
                    ),
                  ),
                if (groupInfo.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Wrap(
                      spacing: 16,
                      children: groupInfo,
                    ),
                  ),
              ],
            );
            if (widget.isPart) {
              return Column(
                children: [
                  if (widget.isPart) ...[
                    ContactViewAppBar(
                      name: c.fullName,
                      allowShare: c.storage == StorageNames.personal,
                      allowUnshare: c.storage == StorageNames.shared,
                      allowEdit: c.storage == StorageNames.personal ||
                          c.viewEmail ==
                              BlocProvider.of<AuthBloc>(context)
                                  .currentAccount
                                  .email,
                      allowDelete: c.storage == StorageNames.personal ||
                          c.storage == StorageNames.shared,
                      onActionSelected: _onMainAppBarActionSelected,
                      hasEmail: _contactInfo.viewEmail?.isNotEmpty == true,
                      isAppBar: false,
                    ),
                    Divider(height: 1),
                  ],
                  Expanded(
                    child: child,
                  ),
                ],
              );
            } else {
              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: LayoutConfig.formWidth,
                  ),
                  child: child,
                ),
              );
            }
          }),
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

  _importKey(Map<PgpKey, bool> userKeys,
      Map<PgpKeyWithContact, bool> contactKeys) async {
    await showDialog(
      context: context,
      builder: (_) => ImportKeyDialog(userKeys, contactKeys, pgpSettingsBloc),
    );
  }
}
