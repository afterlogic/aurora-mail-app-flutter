import 'package:aurora_mail/utils/always_non_equal_object.dart';
import 'package:crypto_model/crypto_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PgpSettingsEvent extends Equatable {
  @override
  List<Object> get props => null;
}

class LoadKeys extends PgpSettingsEvent implements AlwaysNonEqualObject {}

class GenerateKeys extends PgpSettingsEvent implements AlwaysNonEqualObject {
  final String mail;
  final int length;
  final String password;

  GenerateKeys(this.mail, this.length, this.password);

  @override
  List<Object> get props => [mail, length, password];
}

class DeleteKey extends PgpSettingsEvent {
  final PgpKey pgpKey;

  DeleteKey(this.pgpKey);

  @override
  List<Object> get props => [pgpKey];
}

class ParseKey extends PgpSettingsEvent implements AlwaysNonEqualObject {
  final String key;

  ParseKey(this.key);

  @override
  List<Object> get props => [key];
}

class ImportKey extends PgpSettingsEvent {
  final Map<PgpKey, bool> keys;

  ImportKey(this.keys);

  @override
  List<Object> get props => [keys];
}

class ImportFromFile extends PgpSettingsEvent implements AlwaysNonEqualObject {}
