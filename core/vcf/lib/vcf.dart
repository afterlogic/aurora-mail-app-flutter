import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:validators/validators.dart';
import 'package:vcf/vcf_format.dart';

class Vcf {
  String uid;
  DateTime birthday;
  DateTime anniversary;
  var cellPhone;
  var pagerPhone;
  var email;
  var workEmail;
  var otherEmail;
  String formattedName;
  String firstName;
  String middleName;
  String lastName;
  String namePrefix;
  String nameSuffix;
  String nickname;
  String gender;
  MailingAddress homeAddress;
  var homePhone;
  var homeFax;
  Photo photo;
  String note;
  String organization;
  Photo logo;
  String role;
  Map<String, String> socialUrls;
  String source;
  String jobTitle;
  String url;
  String workUrl;
  MailingAddress workAddress;
  var workPhone;
  var workFax;
  var otherPhone;
  bool isOrganization;
  String version;

  Vcf({
    this.uid,
    this.birthday,
    this.anniversary,
    this.cellPhone,
    this.pagerPhone,
    this.email,
    this.workEmail,
    this.otherEmail,
    this.formattedName,
    this.gender,
    this.homePhone,
    this.homeFax,
    this.note,
    this.organization,
    this.role,
    this.source,
    this.jobTitle,
    this.url,
    this.workUrl,
    this.workPhone,
    MailingAddress homeAddress,
    MailingAddress workAddress,
    Map<String, String> socialUrls,
    Photo logo,
    Photo photo,
    String version,
    bool isOrganization,
    String firstName,
    String middleName,
    String lastName,
    String namePrefix,
    String nameSuffix,
    String nickname,
    this.workFax,
    this.otherPhone,
  })  : workAddress = workAddress ?? MailingAddress('WORK'),
        socialUrls = socialUrls,
        photo = photo ?? Photo(),
        logo = logo ?? Photo(),
        version = version ?? '3.0',
        isOrganization = isOrganization ?? false,
        homeAddress = homeAddress ?? MailingAddress('HOME'),
        firstName = firstName ?? '',
        middleName = middleName ?? '',
        lastName = lastName ?? '',
        namePrefix = namePrefix ?? '',
        nameSuffix = nameSuffix ?? '',
        nickname = nickname ?? '';

  Vcf.fill(
    this.uid,
    this.birthday,
    this.anniversary,
    this.cellPhone,
    this.pagerPhone,
    this.email,
    this.workEmail,
    this.otherEmail,
    this.formattedName,
    this.gender,
    this.homePhone,
    this.homeFax,
    this.note,
    this.organization,
    this.role,
    this.source,
    this.jobTitle,
    this.url,
    this.workUrl,
    this.workPhone,
    this.homeAddress,
    this.workAddress,
    this.socialUrls,
    this.logo,
    this.photo,
    this.version,
    this.isOrganization,
    this.firstName,
    this.middleName,
    this.lastName,
    this.namePrefix,
    this.nameSuffix,
    this.nickname,
    this.workFax,
    this.otherPhone,
  );

  int getMajorVersion() {
    String majorVersionString =
        (this.version != null) ? this.version.split('.')[0] : '4';
    if (isNumeric(majorVersionString)) {
      return int.parse(majorVersionString);
    }
    return 4;
  }

  String getFormattedString([bool withRev = true]) =>
      VcfFormat().getString(this, withRev);

  static Vcf fromString(String string) => VcfFormat().fromString(string);
}

class Photo {
  String url;
  String mediaType;
  bool isBase64;

  attachFromUrl(String url, String mediaType) {
    this.url = url;
    this.mediaType = mediaType;
    this.isBase64 = false;
  }

  embedFromFile(String imageFileUri) async {
    this.mediaType = path
        .extension(imageFileUri)
        .trim()
        .toUpperCase()
        .replaceFirst(RegExp(r'\./g'), '');
    final fs = File(imageFileUri);
    this.url = base64.encode(fs.readAsBytesSync());
    this.isBase64 = true;
  }

  embedFromString(String base64String, String mediaType) {
    this.mediaType = mediaType;
    this.url = base64String;
    this.isBase64 = true;
  }

  Photo();

  Photo.fill(
    this.url,
    this.isBase64,
    this.mediaType,
  );
}

class MailingAddress {
  String label;

  String street;

  String city;

  String stateProvince;

  String postalCode;

  String countryRegion;

  String type;

  MailingAddress(
    this.type, {
    this.label = "",
    this.street = "",
    this.city = "",
    this.stateProvince = "",
    this.postalCode = "",
    this.countryRegion = "",
  });

  MailingAddress.fill(
    this.type,
    this.label,
    this.street,
    this.city,
    this.stateProvince,
    this.postalCode,
    this.countryRegion,
  );

  String format() {
    var out = "";
    if (city?.isNotEmpty == true) out += city;
    if (countryRegion?.isNotEmpty == true) out += countryRegion;
    if (street?.isNotEmpty == true) out += street;
    if (stateProvince?.isNotEmpty == true) out += stateProvince;
    if (postalCode?.isNotEmpty == true) out += postalCode;
    return out;
  }
}
