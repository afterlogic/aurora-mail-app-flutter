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
  final List<PgpKey> public;
  final List<PgpKey> private;
  final String keyProgress;

  LoadedState(this.public, this.private, [this.keyProgress = null]);

  LoadedState copyWith(
      {List<PgpKey> public, List<PgpKey> private, String keyProgress}) {
    return LoadedState(
      public ?? this.public,
      private ?? this.private,
      keyProgress ?? this.keyProgress,
    );
  }

  @override
  List<Object> get props => [public, private,keyProgress];
}

class SelectKeyForImport extends PgpSettingsState {
  final Map<PgpKey, bool> keys;

  SelectKeyForImport(this.keys);

  @override
  List<Object> get props => [keys];
}

class ErrorState extends PgpSettingsState with AlwaysNonEqualObject {
  final String message;

  ErrorState(this.message);
}

class CompleteDownload extends PgpSettingsState with AlwaysNonEqualObject {
  final String filePath;

  CompleteDownload(this.filePath);
}
