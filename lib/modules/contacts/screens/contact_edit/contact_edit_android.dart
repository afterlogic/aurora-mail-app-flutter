//@dart=2.9
import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/layout_config/layout_config.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/screens/contact_edit/components/contact_edit_app_bar.dart';
import 'package:aurora_mail/modules/contacts/screens/contacts_list/contacts_list_route.dart';
import 'package:aurora_mail/modules/dialog_wrap.dart';
import 'package:aurora_mail/modules/settings/blocs/pgp_settings/bloc.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/show_dialog.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:crypto_model/crypto_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/contact_birth_date_picker.dart';
import 'components/contact_check_box.dart';
import 'components/contact_input.dart';
import 'components/contact_primary_input.dart';
import 'components/contact_title.dart';
import 'components/key_input.dart';
import 'dialog/confirm_edit_dialog.dart';

class ContactEditAndroid extends StatefulWidget {
  final Contact contact;
  final PgpSettingsBloc pgpSettingsBloc;

  ContactEditAndroid(
    this.pgpSettingsBloc, {
    this.contact,
  });

  @override
  _ContactEditAndroidState createState() => _ContactEditAndroidState();
}

class _ContactEditAndroidState extends BState<ContactEditAndroid>
    with NotSavedChangesMixin {
  ContactsBloc _bloc;
  bool _showAllFields = false;
  int _primaryEmail = 0;
  int _primaryPhone = 0;
  int _primaryAddress = 0;
  PgpKey pgpKey;
  final _fullName = TextEditingController();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _nickName = TextEditingController();
  final _skype = TextEditingController();
  final _facebook = TextEditingController();
  final _personalEmail = TextEditingController();
  final _personalAddress = TextEditingController();
  final _personalCity = TextEditingController();
  final _personalState = TextEditingController();
  final _personalZip = TextEditingController();
  final _personalCountry = TextEditingController();
  final _personalWeb = TextEditingController();
  final _personalFax = TextEditingController();
  final _personalPhone = TextEditingController();
  final _personalMobile = TextEditingController();
  final _businessEmail = TextEditingController();
  final _businessCompany = TextEditingController();
  final _businessAddress = TextEditingController();
  final _businessCity = TextEditingController();
  final _businessState = TextEditingController();
  final _businessZip = TextEditingController();
  final _businessCountry = TextEditingController();
  final _businessJobTitle = TextEditingController();
  final _businessDepartment = TextEditingController();
  final _businessOffice = TextEditingController();
  final _businessPhone = TextEditingController();
  final _businessFax = TextEditingController();
  final _businessWeb = TextEditingController();
  final _otherEmail = TextEditingController();
  final _notes = TextEditingController();
  bool autoSign = false;
  bool autoEncrypt = false;
  int _birthDay = 0;
  int _birthMonth = 0;
  int _birthYear = 0;
  List<String> _selectedGroupsUuids;
  PgpSettingsBloc pgpSettingsBloc;

  @override
  void initState() {
    super.initState();
    pgpSettingsBloc = widget.pgpSettingsBloc;
    _bloc = BlocProvider.of<ContactsBloc>(context);
    if (BuildProperty.cryptoEnable) {
      if (widget.contact?.pgpPublicKey != null) {
        widget.pgpSettingsBloc
            .parseKey(widget.contact.pgpPublicKey)
            .then((value) {
          if (value.isNotEmpty) {
            pgpKey = value.first;
            setState(() {});
          }
        });
      }
    }
    final selectedGroup = _bloc.state.selectedGroup;

    _selectedGroupsUuids = [];

    if (widget.contact != null) {
      _initContact(widget.contact);
      _selectedGroupsUuids = widget.contact.groupUUIDs.toList();
    } else {
      if (selectedGroup != null) _selectedGroupsUuids.add(selectedGroup);
    }
    _initTextUpdatingCrutch();
  }

  void _initContact(Contact c) {
    _primaryEmail = c.primaryEmail;
    _primaryPhone = c.primaryPhone;
    _primaryAddress = c.primaryAddress;
    _fullName.text = c.fullName;
    _firstName.text = c.firstName;
    _lastName.text = c.lastName;
    _nickName.text = c.nickName;
    _skype.text = c.skype;
    _facebook.text = c.facebook;
    _personalEmail.text = c.personalEmail;
    _personalAddress.text = c.personalAddress;
    _personalCity.text = c.personalCity;
    _personalState.text = c.personalState;
    _personalZip.text = c.personalZip;
    _personalCountry.text = c.personalCountry;
    _personalWeb.text = c.personalWeb;
    _personalFax.text = c.personalFax;
    _personalPhone.text = c.personalPhone;
    _personalMobile.text = c.personalMobile;
    _businessEmail.text = c.businessEmail;
    _businessCompany.text = c.businessCompany;
    _businessAddress.text = c.businessAddress;
    _businessCity.text = c.businessCity;
    _businessState.text = c.businessState;
    _businessZip.text = c.businessZip;
    _businessCountry.text = c.businessCountry;
    _businessJobTitle.text = c.businessJobTitle;
    _businessDepartment.text = c.businessDepartment;
    _businessOffice.text = c.businessOffice;
    _businessPhone.text = c.businessPhone;
    _businessFax.text = c.businessFax;
    _businessWeb.text = c.businessWeb;
    _otherEmail.text = c.otherEmail;
    _notes.text = c.notes;
    _birthDay = c.birthDay;
    _birthMonth = c.birthMonth;
    _birthYear = c.birthYear;
    autoSign = c.autoSign ?? false;
    autoEncrypt = c.autoEncrypt ?? false;
  }

  void _initTextUpdatingCrutch() {
    // To update primary values in real time

    _personalEmail.addListener(() => setState(() {}));
    _businessEmail.addListener(() => setState(() {}));
    _otherEmail.addListener(() => setState(() {}));
    _personalMobile.addListener(() => setState(() {}));
    _personalPhone.addListener(() => setState(() {}));
    _businessPhone.addListener(() => setState(() {}));
    _personalAddress.addListener(() => setState(() {}));
    _businessAddress.addListener(() => setState(() {}));
  }

  void _onAppBarActionSelected(
      BuildContext context, ContactEditAppBarAction item) async {
    switch (item) {
      case ContactEditAppBarAction.save:
        if (_getPrimaryEmailCtrl().text.isEmpty) {
          return showSnack(
            context: context,
            scaffoldState: Scaffold.of(context),
            message: S.of(context).error_contacts_email_empty,
          );
        }

        FocusScope.of(context).unfocus();
        FreeKeyAction freeKey;

        final contact = _getDataFromInputs();
        if (widget.contact?.pgpPublicKey == null &&
            pgpKey != null &&
            pgpKey.mail != contact.viewEmail) {
          return showSnack(
            context: context,
            scaffoldState: Scaffold.of(context),
            message: S.of(context).error_contact_pgp_key_will_not_be_valid,
          );
        } else if (widget.contact != null &&
            contact.pgpPublicKey != null &&
            pgpKey.mail != contact.viewEmail) {
          final confirm = await _confirm();

          if (confirm == null) {
            return;
          } else {
            freeKey = confirm;
          }
        }

        final event = widget.contact != null
            ? UpdateContact(
                contact,
                freeKey,
                widget.contact.pgpPublicKey != contact.pgpPublicKey,
              )
            : CreateContact(contact);

        _bloc.add(event);
        Navigator.popUntil(
            context, ModalRoute.withName(ContactsListRoute.name));
        break;
    }
  }

  Future<FreeKeyAction> _confirm() {
    return dialog(
      context: context,
      builder: (_) {
        return ConfirmationEditDialog();
      },
    );
  }

  void _onDateSelected(List<int> time) {
    setState(() {
      _birthDay = time[0];
      _birthMonth = time[1];
      _birthYear = time[2];
    });
  }

  Contact _getDataFromInputs() {
    final user = BlocProvider.of<AuthBloc>(context).currentUser;

    return Contact(
      entityId: widget.contact?.entityId ?? null,
      uuid: widget.contact?.uuid ?? null,
      userLocalId: widget.contact?.userLocalId ?? user.localId,
      uuidPlusStorage: widget.contact?.uuidPlusStorage ?? null,
      parentUuid: widget.contact?.parentUuid ?? null,
      idUser: widget.contact?.idUser ?? user.serverId,
      idTenant: widget.contact?.idTenant ?? null,
      storage: widget.contact?.storage ?? StorageNames.personal,
      fullName: _fullName.text,
      useFriendlyName: widget.contact?.useFriendlyName ?? null,
      primaryEmail: _primaryEmail,
      primaryPhone: _primaryPhone,
      primaryAddress: _primaryAddress,
      viewEmail: _getPrimaryEmailCtrl().text,
      title: widget.contact?.title ?? "",
      firstName: _firstName.text,
      lastName: _lastName.text,
      nickName: _nickName.text,
      skype: _skype.text,
      facebook: _facebook.text,
      personalEmail: _personalEmail.text,
      personalAddress: _personalAddress.text,
      personalCity: _personalCity.text,
      personalState: _personalState.text,
      personalZip: _personalZip.text,
      personalCountry: _personalCountry.text,
      personalWeb: _personalWeb.text,
      personalFax: _personalFax.text,
      personalPhone: _personalPhone.text,
      personalMobile: _personalMobile.text,
      businessEmail: _businessEmail.text,
      businessCompany: _businessCompany.text,
      businessAddress: _businessAddress.text,
      businessCity: _businessCity.text,
      businessState: _businessState.text,
      businessZip: _businessZip.text,
      businessCountry: _businessCountry.text,
      businessJobTitle: _businessJobTitle.text,
      businessDepartment: _businessDepartment.text,
      businessOffice: _businessOffice.text,
      businessPhone: _businessPhone.text,
      businessFax: _businessFax.text,
      businessWeb: _businessWeb.text,
      otherEmail: _otherEmail.text,
      notes: _notes.text,
      birthDay: _birthDay,
      birthMonth: _birthMonth,
      birthYear: _birthYear,
      eTag: widget.contact?.eTag ?? "",
      auto: widget.contact?.auto ?? null,
      frequency: widget.contact?.frequency ?? 0,
      dateModified:
          widget.contact?.dateModified ?? DateTime.now().toIso8601String(),
      davContactsUid: widget.contact?.davContactsUid ?? null,
      davContactsVCardUid: widget.contact?.davContactsVCardUid ?? null,
      groupUUIDs: _selectedGroupsUuids,
      pgpPublicKey: pgpKey?.key,
      autoEncrypt: autoEncrypt,
      autoSign: autoSign,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ContactEditAppBar(
        _onAppBarActionSelected,
        isEdit: widget.contact != null,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: LayoutConfig.formWidth,
          ),
          child: Form(
            child: ListView(
              children: <Widget>[
                ContactInput(
                    S.of(context).contacts_view_display_name, _fullName),
                _buildPrimaryEmail(),
                _buildPrimaryPhone(),
                _buildPrimaryAddress(),
                ContactInput(S.of(context).contacts_view_skype, _skype),
                ContactInput(S.of(context).contacts_view_facebook, _facebook),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: GestureDetector(
                      child: Text(_showAllFields
                          ? S.of(context).contacts_view_hide_additional_fields
                          : S.of(context).contacts_view_show_additional_fields),
                      onTap: () {
                        // crutch
                        _personalEmail.text = _personalEmail.text;
                        _personalAddress.text = _personalAddress.text;
                        _personalPhone.text = _personalPhone.text;
                        _personalMobile.text = _personalMobile.text;
                        _businessEmail.text = _businessEmail.text;
                        _businessAddress.text = _businessAddress.text;
                        _businessPhone.text = _businessPhone.text;
                        _otherEmail.text = _otherEmail.text;
                        setState(() => _showAllFields = !_showAllFields);
                      },
                    ),
                  ),
                ),
                if (_showAllFields)
                  Column(
                    children: <Widget>[
                      ContactInput(
                          S.of(context).contacts_view_first_name, _firstName),
                      ContactInput(
                          S.of(context).contacts_view_last_name, _lastName),
                      ContactInput(
                          S.of(context).contacts_view_nickname, _nickName),
                      ContactTile(S.of(context).contacts_view_section_home),
                      ContactInput(S.of(context).contacts_view_personal_email,
                          _personalEmail,
                          keyboardType: TextInputType.emailAddress),
                      ContactInput(S.of(context).contacts_view_personal_address,
                          _personalAddress),
                      ContactInput(
                          S.of(context).contacts_view_city, _personalCity),
                      ContactInput(
                          S.of(context).contacts_view_province, _personalState),
                      ContactInput(
                          S.of(context).contacts_view_zip, _personalZip),
                      ContactInput(S.of(context).contacts_view_country,
                          _personalCountry),
                      ContactInput(
                          S.of(context).contacts_view_web_page, _personalWeb),
                      ContactInput(
                          S.of(context).contacts_view_fax, _personalFax,
                          keyboardType: TextInputType.phone),
                      ContactInput(
                          S.of(context).contacts_view_phone, _personalPhone,
                          keyboardType: TextInputType.phone),
                      ContactInput(
                          S.of(context).contacts_view_mobile, _personalMobile,
                          keyboardType: TextInputType.phone),
                      ContactTile(S.of(context).contacts_view_section_business),
                      ContactInput(S.of(context).contacts_view_business_email,
                          _businessEmail,
                          keyboardType: TextInputType.emailAddress),
                      ContactInput(S.of(context).contacts_view_company,
                          _businessCompany),
                      ContactInput(S.of(context).contacts_view_personal_address,
                          _businessAddress),
                      ContactInput(
                          S.of(context).contacts_view_city, _businessCity),
                      ContactInput(
                          S.of(context).contacts_view_province, _businessState),
                      ContactInput(
                          S.of(context).contacts_view_zip, _businessZip),
                      ContactInput(S.of(context).contacts_view_country,
                          _businessCountry),
                      ContactInput(S.of(context).contacts_view_job_title,
                          _businessJobTitle),
                      ContactInput(S.of(context).contacts_view_department,
                          _businessDepartment),
                      ContactInput(
                          S.of(context).contacts_view_office, _businessOffice),
                      ContactInput(
                          S.of(context).contacts_view_web_page, _businessWeb),
                      ContactInput(
                          S.of(context).contacts_view_fax, _businessFax,
                          keyboardType: TextInputType.phone),
                      ContactInput(
                          S.of(context).contacts_view_phone, _businessPhone,
                          keyboardType: TextInputType.phone),
                      ContactTile(
                          S.of(context).contacts_view_section_other_info),
                      ContactBirthDatePicker(
                        birthDay: _birthDay,
                        birthMonth: _birthMonth,
                        birthYear: _birthYear,
                        onPicked: _onDateSelected,
                      ),
                      ContactInput(
                          S.of(context).contacts_view_other_email, _otherEmail,
                          keyboardType: TextInputType.emailAddress),
                      ContactInput(S.of(context).contacts_view_notes, _notes),
                      if (BuildProperty.cryptoEnable &&
                          !BuildProperty.legacyPgpKey) ...[
                        ContactTile(S.of(context).label_contact_pgp_settings),
                        KeyInput(
                          pgpSettingsBloc,
                          pgpKey,
                          (key) {
                            setState(() {
                              pgpKey = key;
                            });
                          },
                          (error) {},
                        ),
                        if (pgpKey != null)
                          Column(
                            children: [
                              ContactTile(
                                  S.of(context).hint_auto_encrypt_messages,
                                  theme.textTheme.subtitle1),
                              ContactCheckBox(
                                S.of(context).label_pgp_sign,
                                autoSign,
                                (v) => setState(() => autoSign = v),
                              ),
                              ContactCheckBox(
                                S.of(context).label_pgp_encrypt,
                                autoEncrypt,
                                (v) => setState(() => autoEncrypt = v),
                              ),
                            ],
                          ),
                      ],
                      ContactTile(S.of(context).contacts_view_section_groups),
                      ..._bloc.state.groups.map((g) {
                        return CheckboxListTile(
                          title: Text("# " + g.name),
                          value: _selectedGroupsUuids.contains(g.uuid),
                          onChanged: (v) {
                            setState(() {
                              if (v)
                                _selectedGroupsUuids.add(g.uuid);
                              else
                                _selectedGroupsUuids
                                    .removeWhere((id) => id == g.uuid);
                            });
                          },
                        );
                      }).toList(),
                      SizedBox(height: 24.0),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// PrimaryEmail: {'Personal': 0, 'Business': 1, 'Other': 2},
  /// PrimaryPhone: {'Mobile': 0, 'Personal': 1, 'Business': 2},
  /// PrimaryAddress: {'Personal': 0, 'Business': 1},

  TextEditingController _getPrimaryEmailCtrl() {
    switch (_primaryEmail) {
      case 0:
        return _personalEmail;
      case 1:
        return _businessEmail;
      case 2:
        return _otherEmail;
      default:
        throw "Unknown primaryEmail $_primaryEmail";
    }
  }

  TextEditingController _getPrimaryPhoneCtrl() {
    switch (_primaryPhone) {
      case 0:
        return _personalMobile;
      case 1:
        return _personalPhone;
      case 2:
        return _businessPhone;
      default:
        throw "Unknown primaryPhone $_primaryPhone";
    }
  }

  TextEditingController _getPrimaryAddressCtrl() {
    switch (_primaryAddress) {
      case 0:
        return _personalAddress;
      case 1:
        return _businessAddress;
      default:
        throw "Unknown primaryAddress $_primaryAddress";
    }
  }

  Widget _buildPrimaryEmail() {
    final label = S.of(context).contacts_view_email;

    if (!_showAllFields) {
      return ContactInput(label, _getPrimaryEmailCtrl(),
          keyboardType: TextInputType.emailAddress);
    } else {
      final options = [
        "${S.of(context).contacts_view_personal_email}",
        "${S.of(context).contacts_view_business_email}",
        "${S.of(context).contacts_view_other_email}",
      ];
      return ContactPrimaryInput<int>(
        (int value) => setState(() => _primaryEmail = value),
        _primaryEmail,
        label,
        options,
        (value) => options.indexOf(value),
        _getPrimaryEmailCtrl(),
        keyboardType: TextInputType.emailAddress,
      );
    }
  }

  Widget _buildPrimaryPhone() {
    final label = S.of(context).contacts_view_phone;

    if (!_showAllFields) {
      return ContactInput(label, _getPrimaryPhoneCtrl(),
          keyboardType: TextInputType.phone);
    } else {
      final options = [
        "${S.of(context).contacts_view_mobile}",
        "${S.of(context).contacts_view_personal_phone}",
        "${S.of(context).contacts_view_business_phone}",
      ];
      return ContactPrimaryInput<int>(
        (int value) => setState(() => _primaryPhone = value),
        _primaryPhone,
        label,
        options,
        (value) => options.indexOf(value),
        _getPrimaryPhoneCtrl(),
        keyboardType: TextInputType.phone,
      );
    }
  }

  Widget _buildPrimaryAddress() {
    final label = S.of(context).contacts_view_address;

    if (!_showAllFields) {
      return ContactInput(label, _getPrimaryAddressCtrl());
    } else {
      final options = [
        "${S.of(context).contacts_view_personal_address}",
        "${S.of(context).contacts_view_business_address}",
      ];
      return ContactPrimaryInput<int>(
        (int value) => setState(() => _primaryAddress = value),
        _primaryAddress,
        label,
        options,
        (value) => options.indexOf(value),
        _getPrimaryAddressCtrl(),
      );
    }
  }
}
