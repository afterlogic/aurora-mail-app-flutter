import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/shared_ui/confirmation_dialog.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';
import 'package:vcf/vcf.dart';

Future importContactFromVcf(
    BuildContext context,
    Vcf vcf,
    ContactsBloc bloc,
    ) async {
  final contact = Contact(
    entityId: null,
    viewEmail: firstOrNull(vcf.email) as String,
    frequency: 0,
    davContactsVCardUid: null,
    eTag: "",
    pgpPublicKey: null,
    davContactsUid: null,
    useFriendlyName: true,
    idUser: bloc.user.serverId,
    groupUUIDs: <String>[],
    userLocalId: bloc.user.localId,
    idTenant: null,
    fullName: vcf.formattedName,
    dateModified: DateTime.now().toIso8601String(),
    uuidPlusStorage: null,
    uuid: null,
    storage: StorageNames.personal,
  ).copyWith(
    entityId: null,
    parentUuid: null,
    title: "",
    firstName: vcf.firstName,
    lastName: vcf.lastName,
    nickName: vcf.nickname,
    skype: (vcf.socialUrls == null ? null : vcf.socialUrls["skype"]) ?? "",
    facebook:
    (vcf.socialUrls == null ? null : vcf.socialUrls["facebook"]) ?? "",
    personalEmail: firstOrNull(vcf.email) as String,
    personalAddress: vcf.homeAddress?.format(),
    personalCity: vcf.homeAddress?.city,
    personalState: vcf.homeAddress?.stateProvince,
    personalZip: vcf.homeAddress?.postalCode,
    personalCountry: vcf.homeAddress?.countryRegion,
    personalWeb: vcf.url ?? "",
    personalFax: (firstOrNull(vcf.homeFax) as String) ?? "",
    personalPhone: (firstOrNull(vcf.homePhone) as String) ?? "",
    personalMobile: "",
    businessEmail: firstOrNull(vcf.workEmail) as String,
    businessCompany: "",
    businessAddress: vcf.workAddress?.format(),
    businessCity: vcf.workAddress?.city,
    businessState: vcf.workAddress?.stateProvince,
    businessZip: vcf.workAddress?.postalCode,
    businessCountry: vcf.workAddress?.countryRegion,
    businessJobTitle: "",
    businessDepartment: "",
    businessOffice: "",
    businessPhone: (firstOrNull(vcf.workPhone) as String) ?? "",
    businessFax: (firstOrNull(vcf.workFax) as String) ?? "",
    businessWeb: "",
    otherEmail: firstOrNull(vcf.otherEmail) as String,
    notes: vcf.note,
    birthDay: (vcf.birthday?.millisecondsSinceEpoch) ?? 0,
    birthMonth: (vcf.birthday?.month) ?? 0,
    birthYear: (vcf.birthday?.year) ?? 0,
    auto: null,
  );
  final result = await ConfirmationDialog.show(
    context,
    null,
    i18n(context, "hint_vcf_import", {
      "name": contact.fullName ?? contact.nickName ?? contact.viewEmail ?? ""
    }),
    i18n(context, "btn_vcf_import"),
  );
  if (result == true) {
    bloc.add(CreateContact(contact));
  }
}

dynamic firstOrNull(dynamic list) {
  if (list != null && list is List) {
    if (list.isNotEmpty) {
      return list.first;
    }
  }
  return null;
}