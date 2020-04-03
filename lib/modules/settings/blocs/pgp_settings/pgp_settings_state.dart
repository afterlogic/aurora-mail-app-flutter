import 'package:aurora_mail/modules/settings/blocs/pgp_settings/pgp_settings_methods.dart';
import 'package:aurora_mail/utils/always_non_equal_object.dart';
import 'package:crypto_model/crypto_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PgpSettingsState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProgressState extends PgpSettingsState {}

class LoadedState extends PgpSettingsState {
  final List<PgpKey> myPublic;
  final List<PgpKey> myPrivate;
  final List<PgpKey> contactPublic;
  final String keyProgress;

  LoadedState(
    this.myPublic,
    this.myPrivate,
    this.contactPublic, [
    this.keyProgress = null,
  ]);

  LoadedState copyWith({
    List<PgpKey> public,
    List<PgpKey> private,
    List<PgpKey> contactPublic,
    String keyProgress,
  }) {
    return LoadedState(
      public ?? this.myPublic,
      private ?? this.myPrivate,
      contactPublic ?? this.contactPublic,
      keyProgress ?? this.keyProgress,
    );
  }

  @override
  List<Object> get props => [myPublic, myPrivate, contactPublic, keyProgress];
}

class SelectKeyForImport extends PgpSettingsState with AlwaysNonEqualObject {
  final Map<PgpKey, bool> userKeys;
  final Map<PgpKeyWithContact, bool> contactKeys;

  SelectKeyForImport(this.userKeys, this.contactKeys);

  @override
  List<Object> get props => [userKeys, contactKeys];
}

class ErrorState extends PgpSettingsState with AlwaysNonEqualObject {
  final String message;

  ErrorState(this.message);
}

class CompleteDownload extends PgpSettingsState with AlwaysNonEqualObject {
  final String filePath;

  CompleteDownload(this.filePath);
}
