import 'package:vcf/vcf.dart';
import 'package:vcf/vcf_format.dart';

main() {
  final string = (testVcf
        ..photo = null
        ..logo = null)
      .getFormattedString(false);

  final vcf = VcfFormat().fromString(string)
    ..photo = null
    ..logo = null;

  assert(vcf.getFormattedString(false) == string);

  VcfFormat().fromString(testString);

  final url = "url \n url \r\n  url;";
  final vcfEncode = testVcf..url = url;
  final encodeString = vcfEncode.getFormattedString();
  final vcfDecode = VcfFormat().fromString(encodeString);
  print(vcfDecode.url);
  assert(vcfDecode.url == url);
}

final testVcf = Vcf.fill(
  "uid",
  DateTime.now(),
  DateTime.now(),
  "cellPhone",
  ["pagerPhone"],
  "email",
  "workEmail",
  "otherEmail",
  "formattedName",
  "gender",
  "homePhone",
  "homeFax",
  "note",
  "organization",
  "role",
  "source",
  "jobTitle",
  "url",
  "workUrl",
  "workPhone",
  MailingAddress.fill(
    "home",
    "",
    //todo label not supported
    "street",
    "city",
    "stateProvince",
    "postalCode",
    "countryRegion",
  ),
  MailingAddress.fill(
    "work",
    "",
    //todo label not supported
    "street",
    "city",
    "stateProvince",
    "postalCode",
    "countryRegion",
  ),
  {"socialUrls": "socialUrls"},
  Photo.fill("url", true, "mediaType"),
  //todo Photo not supported
  Photo.fill("url", true, "mediaType"),
  //todo Photo not supported
  "version",
  true,
  "firstName",
  "middleName",
  "lastName",
  "namePrefix",
  "nameSuffix",
  "nickname",
  "workFax",
  "otherPhone",
);
const testString = """
BEGIN:VCARD
VERSION:3.0
PRODID:-//Sabre//Sabre VObject 4.2.2//EN
UID:ad327719-5883-4cd6-af71-7dbdd6d4f530
FN:Ivan Lomakin
N:;;;;;
X-OFFICE:
X-USE-FRIENDLY-NAME:1
TITLE:
NICKNAME:
NOTE:
ORG:;
ADR;TYPE=HOME:;;Таганрог;;;;
EMAIL;TYPE=HOME:lomakin.ivan@gmail.com
EMAIL;TYPE=WORK,PREF:i.lomakin@afterlogic.com
END:VCARD
""";
