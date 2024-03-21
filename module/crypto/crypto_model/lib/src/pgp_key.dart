import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';

class PgpKey {
  final String? name;
  final String mail;
  final String key;
  final bool isPrivate;
  final int? length;

  PgpKey({
    this.name,
    required this.mail,
    required this.isPrivate,
    required this.key,
    required this.length,
  });

  PgpKey.fill(
    this.name,
    this.mail,
    this.isPrivate,
    this.key,
    this.length,
  );
}

class PgpKeyWithContact implements PgpKey {
  final PgpKey pgpKey;
  final Contact contact;

  PgpKeyWithContact(this.pgpKey, this.contact);

  String? get name => pgpKey.name;

  String get mail => pgpKey.mail;

  String get key => pgpKey.key;

  bool get isPrivate => pgpKey.isPrivate;

  int? get length => pgpKey.length;
}
