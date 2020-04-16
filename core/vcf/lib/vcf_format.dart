import 'package:intl/intl.dart';
import 'package:vcf/vcf.dart';

class VcfFormat {
  int majorVersion = 3;

  static const _n = '\r\n';
  static const _nM = "((\r\n)|(\r)|(\n))";
  static const en = r"(;CHARSET=.*)?";

  String _getFormattedPhoto(
      String photoType, String url, String mediaType, bool isBase64) {
    String params;

    if (majorVersion >= 4) {
      params = isBase64 ? ';ENCODING=b;MEDIATYPE=image/' : ';MEDIATYPE=image/';
    } else if (majorVersion == 3) {
      params = isBase64 ? ';ENCODING=b;TYPE=' : ';TYPE=';
    } else {
      params = isBase64 ? ';ENCODING=BASE64;' : ';';
    }

    String formattedPhoto =
        photoType + params + mediaType + ':' + url.format + _n;
    return formattedPhoto;
  }

  String _getFormattedAddress(MailingAddress address, String encodingPrefix) {
    var formattedAddress = '';

    if (address.label.isNotEmpty ||
        address.street.isNotEmpty ||
        address.city.isNotEmpty ||
        address.stateProvince.isNotEmpty ||
        address.postalCode.isNotEmpty ||
        address.countryRegion.isNotEmpty) {
      if (majorVersion >= 4) {
        formattedAddress = 'ADR' +
            encodingPrefix +
            ';TYPE=' +
            address.type +
            (address.label.isNotEmpty
                ? ';LABEL="' + address.label.format + '"'
                : '') +
            ':;;' +
            address.street.format +
            ';' +
            address.city.format +
            ';' +
            address.stateProvince.format +
            ';' +
            address.postalCode.format +
            ';' +
            address.countryRegion.format +
            _n;
      } else {
        if (address.label.isNotEmpty) {
          formattedAddress = 'LABEL' +
              encodingPrefix +
              ';TYPE=' +
              address.type +
              ':' +
              address.label.format +
              _n;
        }
        formattedAddress += 'ADR' +
            encodingPrefix +
            ';TYPE=' +
            address.type +
            ':;;' +
            address.street.format +
            ';' +
            address.city.format +
            ';' +
            address.stateProvince.format +
            ';' +
            address.postalCode.format +
            ';' +
            address.countryRegion.format +
            _n;
      }
    }

    return formattedAddress;
  }

  String _formatVCardDate(DateTime date) {
    return DateFormat("yyyyMMdd").format(date);
  }

  String getString(Vcf vcf, [bool withRev = true]) {
    majorVersion = vcf.getMajorVersion();

    String formattedVCardString = '';
    formattedVCardString += 'BEGIN:VCARD' + _n;
    formattedVCardString += 'VERSION:' + vcf.version + _n;

    String encodingPrefix = majorVersion >= 4 ? '' : ';CHARSET=UTF-8';
    String formattedName = vcf.formattedName;

    if (formattedName == null) {
      formattedName = '';

      [vcf.firstName, vcf.middleName, vcf.lastName].forEach((name) {
        if ((name.isNotEmpty) && (formattedName.isNotEmpty)) {
          formattedName += ' ';
        }
        formattedName += name;
      });
    }

    formattedVCardString +=
        'FN' + encodingPrefix + ':' + formattedName.format + _n;
    formattedVCardString += 'N' +
        encodingPrefix +
        ':' +
        vcf.lastName.format +
        ';' +
        vcf.firstName.format +
        ';' +
        vcf.middleName.format +
        ';' +
        vcf.namePrefix.format +
        ';' +
        vcf.nameSuffix.format +
        _n;

    if ((vcf.nickname != null) && (majorVersion >= 3)) {
      formattedVCardString +=
          'NICKNAME' + encodingPrefix + ':' + vcf.nickname.format + _n;
    }

    if (vcf.gender != null) {
      formattedVCardString += 'GENDER:' + vcf.gender.format + _n;
    }

    if (vcf.uid != null) {
      formattedVCardString +=
          'UID' + encodingPrefix + ':' + vcf.uid.format + _n;
    }

    if (vcf.birthday != null) {
      formattedVCardString += 'BDAY:' + _formatVCardDate(vcf.birthday) + _n;
    }

    if ((vcf.anniversary != null) && (majorVersion >= 4)) {
      formattedVCardString +=
          'ANNIVERSARY:' + _formatVCardDate(vcf.anniversary) + _n;
    }

    if (vcf.email != null) {
      if (vcf.email is! List) {
        vcf.email = [vcf.email];
      }
      vcf.email.forEach((_address) {
        final address = _address.toString();
        if (majorVersion >= 4) {
          formattedVCardString +=
              'EMAIL' + encodingPrefix + ';type=HOME:' + address.format + _n;
        } else if (majorVersion >= 3 && majorVersion < 4) {
          formattedVCardString += 'EMAIL' +
              encodingPrefix +
              ';type=HOME,INTERNET:' +
              address.format +
              _n;
        } else {
          formattedVCardString += 'EMAIL' +
              encodingPrefix +
              ';HOME;INTERNET:' +
              address.format +
              _n;
        }
      });
    }

    if (vcf.workEmail != null) {
      if (vcf.workEmail is! List) {
        vcf.workEmail = [vcf.workEmail];
      }
      vcf.workEmail.forEach((_address) {
        final address = _address.toString();
        if (majorVersion >= 4) {
          formattedVCardString +=
              'EMAIL' + encodingPrefix + ';type=WORK:' + address.format + _n;
        } else if (majorVersion >= 3 && majorVersion < 4) {
          formattedVCardString += 'EMAIL' +
              encodingPrefix +
              ';type=WORK,INTERNET:' +
              address.format +
              _n;
        } else {
          formattedVCardString += 'EMAIL' +
              encodingPrefix +
              ';WORK;INTERNET:' +
              address.format +
              _n;
        }
      });
    }

    if (vcf.otherEmail != null) {
      if (vcf.otherEmail is! List) {
        vcf.otherEmail = [vcf.otherEmail];
      }
      vcf.otherEmail.forEach((_address) {
        final address = _address.toString();
        if (majorVersion >= 4) {
          formattedVCardString +=
              'EMAIL' + encodingPrefix + ';type=OTHER:' + address.format + _n;
        } else if (majorVersion >= 3 && majorVersion < 4) {
          formattedVCardString += 'EMAIL' +
              encodingPrefix +
              ';type=OTHER,INTERNET:' +
              address.format +
              _n;
        } else {
          formattedVCardString += 'EMAIL' +
              encodingPrefix +
              ';OTHER;INTERNET:' +
              address.format +
              _n;
        }
      });
    }

    if (vcf.logo?.url != null) {
      formattedVCardString += _getFormattedPhoto(
          'LOGO', vcf.logo.url, vcf.logo.mediaType, vcf.logo.isBase64);
    }

    if (vcf.photo?.url != null) {
      formattedVCardString += _getFormattedPhoto(
          'PHOTO', vcf.photo.url, vcf.photo.mediaType, vcf.photo.isBase64);
    }

    if (vcf.cellPhone != null) {
      if (vcf.cellPhone is! List) {
        vcf.cellPhone = [vcf.cellPhone];
      }

      vcf.cellPhone.forEach((_number) {
        final number = _number.toString();
        if (majorVersion >= 4) {
          formattedVCardString +=
              'TEL;VALUE=uri;TYPE="voice,cell":tel:' + number.format + _n;
        } else {
          formattedVCardString += 'TEL;TYPE=CELL:' + number.format + _n;
        }
      });
    }

    if (vcf.pagerPhone != null) {
      if (vcf.pagerPhone is! List) {
        vcf.pagerPhone = [vcf.pagerPhone];
      }
      vcf.pagerPhone.forEach((_number) {
        final number = _number.toString();
        if (majorVersion >= 4) {
          formattedVCardString +=
              'TEL;VALUE=uri;TYPE="pager,cell":tel:' + number.format + _n;
        } else {
          formattedVCardString += 'TEL;TYPE=PAGER:' + number.format + _n;
        }
      });
    }

    if (vcf.homePhone != null) {
      if (vcf.homePhone is! List) {
        vcf.homePhone = [vcf.homePhone];
      }
      vcf.homePhone.forEach((_number) {
        final number = _number.toString();
        if (majorVersion >= 4) {
          formattedVCardString +=
              'TEL;VALUE=uri;TYPE="voice,home":tel:' + number.format + _n;
        } else {
          formattedVCardString += 'TEL;TYPE=HOME,VOICE:' + number.format + _n;
        }
      });
    }

    if (vcf.workPhone != null) {
      if (vcf.workPhone is! List) {
        vcf.workPhone = [vcf.workPhone];
      }
      vcf.workPhone.forEach((_number) {
        final number = _number.toString();
        if (majorVersion >= 4) {
          formattedVCardString +=
              'TEL;VALUE=uri;TYPE="voice,work":tel:' + number.format + _n;
        } else {
          formattedVCardString += 'TEL;TYPE=WORK,VOICE:' + number.format + _n;
        }
      });
    }

    if (vcf.homeFax != null) {
      if (vcf.homeFax is! List) {
        vcf.homeFax = [vcf.homeFax];
      }
      vcf.homeFax.forEach((_number) {
        final number = _number.toString();
        if (majorVersion >= 4) {
          formattedVCardString +=
              'TEL;VALUE=uri;TYPE="fax,home":tel:' + number.format + _n;
        } else {
          formattedVCardString += 'TEL;TYPE=HOME,FAX:' + number.format + _n;
        }
      });
    }

    if (vcf.workFax != null) {
      if (vcf.workFax is! List) {
        vcf.workFax = [vcf.workFax];
      }
      vcf.workFax.forEach((_number) {
        final number = _number.toString();
        if (majorVersion >= 4) {
          formattedVCardString +=
              'TEL;VALUE=uri;TYPE="fax,work":tel:' + number.format + _n;
        } else {
          formattedVCardString += 'TEL;TYPE=WORK,FAX:' + number.format + _n;
        }
      });
    }

    if (vcf.otherPhone != null) {
      if (vcf.otherPhone is! List) {
        vcf.otherPhone = [vcf.otherPhone];
      }
      vcf.otherPhone.forEach((_number) {
        final number = _number.toString();
        if (majorVersion >= 4) {
          formattedVCardString +=
              'TEL;VALUE=uri;TYPE="voice,other":tel:' + number.format + _n;
        } else {
          formattedVCardString += 'TEL;TYPE=OTHER:' + number.format + _n;
        }
      });
    }

    if (vcf.homeAddress != null) {
      formattedVCardString +=
          _getFormattedAddress(vcf.homeAddress, encodingPrefix);
    }
    if (vcf.workAddress != null) {
      formattedVCardString +=
          _getFormattedAddress(vcf.workAddress, encodingPrefix);
    }
    if (vcf.jobTitle != null) {
      formattedVCardString +=
          'TITLE' + encodingPrefix + ':' + vcf.jobTitle.format + _n;
    }

    if (vcf.role != null) {
      formattedVCardString +=
          'ROLE' + encodingPrefix + ':' + vcf.role.format + _n;
    }

    if (vcf.organization != null) {
      formattedVCardString +=
          'ORG' + encodingPrefix + ':' + vcf.organization.format + _n;
    }

    if (vcf.url != null) {
      formattedVCardString +=
          'URL' + encodingPrefix + ':' + vcf.url.format + _n;
    }

    if (vcf.workUrl != null) {
      formattedVCardString +=
          'URL;type=WORK' + encodingPrefix + ':' + vcf.workUrl.format + _n;
    }

    if (vcf.note != null) {
      formattedVCardString +=
          'NOTE' + encodingPrefix + ':' + vcf.note.format + _n;
    }

    if (vcf.socialUrls != null) {
      vcf.socialUrls.forEach((key, value) {
        if ((value != null) && (value.isNotEmpty)) {
          formattedVCardString += 'X-SOCIALPROFILE' +
              encodingPrefix +
              ';TYPE=' +
              key +
              ':' +
              vcf.socialUrls[key].format +
              _n;
        }
      });
    }

    if (vcf.source != null) {
      formattedVCardString +=
          'SOURCE' + encodingPrefix + ':' + vcf.source.format + _n;
    }
    if (withRev == true) {
      formattedVCardString += 'REV:' + DateTime.now().toIso8601String() + _n;
    }
    if (vcf.isOrganization) {
      formattedVCardString += 'X-ABShowAs:COMPANY' + _n;
    }

    formattedVCardString += 'END:VCARD' + _n;
    return formattedVCardString;
  }

  Vcf fromString(String _string) {
    final vcf = Vcf();
    String string = _string.encode;
    BetweenResult result;

    result = string.between("${_nM}VERSION$en:", _nM);
    vcf.version = result.result.decode;

    result = string.between("${_nM}FN$en:", _nM);
    vcf.formattedName = result.result.decode;

    result = string.between("${_nM}N$en:", _nM);
    final splitN = result.result?.split(";")?.iterator;
    if (splitN != null) {
      if (splitN.moveNext()) {
        vcf.lastName = splitN.current.decode;
        if (splitN.moveNext()) {
          vcf.firstName = splitN.current.decode;
          if (splitN.moveNext()) {
            vcf.middleName = splitN.current.decode;
            if (splitN.moveNext()) {
              vcf.namePrefix = splitN.current.decode;
              if (splitN.moveNext()) {
                vcf.nameSuffix = splitN.current.decode;
              }
            }
          }
        }
      }
    }

    result = string.between("${_nM}NICKNAME$en:", _nM);
    vcf.nickname = result.result.decode;

    result = string.between("${_nM}GENDER$en:", _nM);
    vcf.gender = result.result.decode;

    result = string.between("${_nM}UID$en:", _nM);
    vcf.uid = result.result.decode;

    result = string.between("${_nM}BDAY$en:", _nM);
    vcf.birthday = _parseVCardDate(result.result);

    result = string.between("${_nM}ANNIVERSARY$en:", _nM);
    vcf.anniversary = _parseVCardDate(result.result);

    String emailSearch = string;
    vcf.email = [];
    vcf.workEmail = [];
    vcf.otherEmail = [];
    while (emailSearch != null) {
      result = emailSearch.between("${_nM}EMAIL$en;", _nM);
      if (result.result == null) {
        break;
      }
      final type = result.result.between(null, ":").result;
      if (type.contains("HOME")) {
        vcf.email.add(result.result.between(":", null).result.decode);
      } else if (type.contains("WORK")) {
        vcf.workEmail.add(result.result.between(":", null).result.decode);
      } else if (type.contains("OTHER")) {
        vcf.otherEmail.add(result.result.between(":", null).result.decode);
      }
      if (result.end == -1) {
        emailSearch = null;
      } else {
        emailSearch = emailSearch.substring(result.end);
      }
    }
    //todo vcf.logo not supported

    //todo vcf.photo not supported

    String phoneSearch = string;
    vcf.homeFax = [];
    vcf.workFax = [];
    vcf.pagerPhone = [];
    vcf.cellPhone = [];
    vcf.homePhone = [];
    vcf.workPhone = [];
    vcf.otherPhone = [];

    while (phoneSearch != null) {
      result = phoneSearch.between("${_nM}TEL$en;", _nM);
      if (result.result == null) {
        break;
      }
      final type = result.result.between(null, ":").result;
      if (type.contains("HOME,FAX") || type.contains("fax,home")) {
        vcf.homeFax.add(result.result.between("tel:", null).result.decode);
      } else if (type.contains("WORK,FAX") || type.contains("fax,work")) {
        vcf.workFax.add(result.result.between("tel:", null).result.decode);
      } else if (type.contains("PAGER") || type.contains("pager")) {
        vcf.pagerPhone.add(result.result.between("tel:", null).result.decode);
      } else if (type.contains("CELL") || type.contains("cell")) {
        vcf.cellPhone.add(result.result.between("tel:", null).result.decode);
      } else if (type.contains("HOME") || type.contains("home")) {
        vcf.homePhone.add(result.result.between("tel:", null).result.decode);
      } else if (type.contains("WORK") || type.contains("work")) {
        vcf.workPhone.add(result.result.between("tel:", null).result.decode);
      } else {
        vcf.otherPhone.add(result.result.between("tel:", null).result.decode);
      }
      if (result.end == -1) {
        phoneSearch = null;
      } else {
        phoneSearch = phoneSearch.substring(result.end);
      }
    }

    final addressList = _parseFormattedAddress(string);
    vcf.homeAddress = addressList.firstWhere(
      (item) => item.type.contains(RegExp("home", caseSensitive: false)),
      orElse: () => null,
    );
    vcf.workAddress = addressList.firstWhere(
      (item) => item.type.contains(RegExp("work", caseSensitive: false)),
      orElse: () => null,
    );

    result = string.between("${_nM}TITLE$en:", _nM);
    vcf.jobTitle = result.result.decode;

    result = string.between("${_nM}ROLE$en:", _nM);
    vcf.role = result.result.decode;

    result = string.between("${_nM}ORG$en:", _nM);
    vcf.organization = result.result.decode;

    result = string.between("${_nM}URL$en:", _nM);
    vcf.url = result.result.decode;

    result = string.between("${_nM}URL;type=WORK$en:", _nM);
    vcf.workUrl = result.result.decode;

    result = string.between("${_nM}NOTE$en:", _nM);
    vcf.note = result.result.decode;

    String socialUrlsSearch = string;
    vcf.socialUrls = {};
    while (socialUrlsSearch != null) {
      result = socialUrlsSearch.between("${_nM}X-SOCIALPROFILE$en;", _nM);
      if (result.result == null) {
        break;
      }
      final type = result.result.between("TYPE=", ":").result.decode;
      vcf.socialUrls[type] = result.result.between(":", null).result.decode;
      if (result.end == -1) {
        socialUrlsSearch = null;
      } else {
        socialUrlsSearch = socialUrlsSearch.substring(result.end);
      }
    }
    result = string.between("${_nM}SOURCE$en:", _nM);
    vcf.source = result.result.decode;

    result = string.between("${_nM}X-ABShowAs$en:", _nM);
    vcf.isOrganization = result.result?.contains("COMPANY") == true;
    return vcf;
  }

  List<MailingAddress> _parseFormattedAddress(String string) {
    BetweenResult result;
    String addressSearch = string;
    List<MailingAddress> addressList = [];
    while (addressSearch != null) {
      result = addressSearch.between("${_nM}ADR$en;", _nM);
      if (result.result == null) {
        break;
      }
      MailingAddress address =
          MailingAddress(result.result.between("TYPE=", "[:;]").result);
      final iterator =
          result.result.between(":;;", null).result.split(";").iterator;
      if (iterator.moveNext()) {
        address.street = iterator.current.decode;
        if (iterator.moveNext()) {
          address.city = iterator.current.decode;
          if (iterator.moveNext()) {
            address.stateProvince = iterator.current.decode;
            if (iterator.moveNext()) {
              address.postalCode = iterator.current.decode;
              if (iterator.moveNext()) {
                address.countryRegion = iterator.current.decode;
              }
            }
          }
        }
      }
      addressList.add(address);
      if (result.end == -1) {
        break;
      } else {
        addressSearch = addressSearch.substring(result.end);
      }
    }
    return addressList;
  }

  DateTime _parseVCardDate(String string) {
    try {
      return DateFormat("yyyy-MM-dd").parse(string.substring(0, 4) +
          "-" +
          string.substring(4, 6) +
          "-" +
          string.substring(6, 8));
    } catch (e) {
      return null;
    }
  }
}
extension _Util on String {
  BetweenResult between(String start, String end) {
    final string = this;
    final startIndex =
        start == null ? 0 : RegExp(start).firstMatch(string)?.end ?? -1;
    if (startIndex == -1) {
      return BetweenResult(0, null);
    }
    final endIndex =
        end == null ? this.length : (string.indexOf(RegExp(end), startIndex));
    if (startIndex == -1) {
      return BetweenResult(0, null);
    }
    final result = string.substring(startIndex, endIndex);
    return BetweenResult(endIndex, result);
  }

  String get encode {
    if (this != null && this.isNotEmpty) {
      return this
          .replaceAll('\\n', en0)
          .replaceAll('\\,', en1)
          .replaceAll('\\;', en2)
          .replaceAll('\\r', en3);
    }
    return this;
  }

  String get decode {
    if (this != null && this.isNotEmpty) {
      return this
          .replaceAll(en0, '\n')
          .replaceAll(en1, ',')
          .replaceAll(en2, ';')
          .replaceAll(en3, '\r');
    }
    return this;
  }
  String get format {
    if (this?.isNotEmpty == true) {
      return this
          .replaceAll('\n', '\\n')
          .replaceAll('\r', '\\r')
          .replaceAll(',', '\\,')
          .replaceAll(';', '\\;');
    }
    return this;
  }

  static const en0 = '\$\\e\\n\\0\$';
  static const en1 = '\$\\e\\n\\1\$';
  static const en2 = '\$\\e\\n\\2\$';
  static const en3 = '\$\\e\\n\\3\$';
}

class BetweenResult {
  final int end;
  final String result;

  BetweenResult(this.end, this.result);
}
