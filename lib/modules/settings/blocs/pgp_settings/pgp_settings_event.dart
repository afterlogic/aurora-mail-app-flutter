//@dart=2.9
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/settings/blocs/pgp_settings/pgp_settings_methods.dart';
import 'package:aurora_mail/utils/always_non_equal_object.dart';
import 'package:crypto_model/crypto_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PgpSettingsEvent extends Equatable {
  @override
  List<Object> get props => null;
}

class LoadKeys extends PgpSettingsEvent with AlwaysNonEqualObject {}

class GenerateKeys extends PgpSettingsEvent with AlwaysNonEqualObject {
  final String name;
  final String mail;
  final int length;
  final String password;

  GenerateKeys(this.name, this.mail, this.length, this.password);

  @override
  List<Object> get props => [mail, length, password];
}

class UpdateKeyFlags extends PgpSettingsEvent {
  final Contact contact;
  final bool pgpEncryptMessages;
  final bool pgpSignMessages;

  UpdateKeyFlags({@required this.contact, this.pgpEncryptMessages, this.pgpSignMessages});

  @override
  List<Object> get props => [contact, pgpEncryptMessages, pgpSignMessages];
}

class DeleteKey extends PgpSettingsEvent {
  final PgpKey pgpKey;

  DeleteKey(this.pgpKey);

  @override
  List<Object> get props => [pgpKey];
}

class ParseKey extends PgpSettingsEvent with AlwaysNonEqualObject {
  final String key;

  ParseKey(this.key);

  @override
  List<Object> get props => [key];
}

class ImportKey extends PgpSettingsEvent with AlwaysNonEqualObject {
  final Map<PgpKey, bool> userKey;
  final Map<PgpKeyWithContact, bool> contactKey;

  ImportKey(this.userKey, this.contactKey);

  @override
  List<Object> get props => [];
}

class ImportFromFile extends PgpSettingsEvent with AlwaysNonEqualObject {}

class DownloadKeys extends PgpSettingsEvent with AlwaysNonEqualObject {
  final List<PgpKey> pgpKeys;

  DownloadKeys(this.pgpKeys);
}

class ShareKeys extends PgpSettingsEvent with AlwaysNonEqualObject {
  final List<PgpKey> pgpKeys;
  final Rect rect;
  ShareKeys(this.pgpKeys, this.rect);
}
