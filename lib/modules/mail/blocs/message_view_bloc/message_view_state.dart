//@dart=2.9
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/utils/always_non_equal_object.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:crypto_worker/crypto_worker.dart';
import 'package:equatable/equatable.dart';

abstract class MessageViewState extends Equatable {
  const MessageViewState();
}

class InitialMessageViewState extends MessageViewState {
  @override
  List<Object> get props => [];
}

class DownloadStarted extends MessageViewState {
  final String fileName;

  const DownloadStarted(this.fileName);

  @override
  List<Object> get props => [fileName];
}

class DownloadFinished extends MessageViewState {
  final String path;

  const DownloadFinished(this.path);

  @override
  List<Object> get props => [path];
}

class MessagesViewError extends MessageViewState with AlwaysNonEqualObject {
  final ErrorToShow errorMsg;
  final Map<String, String> arg;

  MessagesViewError(this.errorMsg, [this.arg]);

  @override
  List<Object> get props => [errorMsg];
}

class MessageIsEncrypt extends MessageViewState {
  final EncryptType encryptType;

  const MessageIsEncrypt(this.encryptType);

  @override
  List<Object> get props => [encryptType];
}

class DecryptComplete extends MessageViewState {
  final String text;
  final bool verified;
  final EncryptType type;

  const DecryptComplete(this.text, this.verified, this.type);

  @override
  List<Object> get props => [text, verified, type.index];
}

class FolderTypeState extends MessageViewState {
  final FolderType type;

  FolderTypeState(this.type);

  @override
  List<Object> get props => [type];
}

class CheckedSafety extends MessageViewState {
  final bool safety;

  CheckedSafety(this.safety);

  @override
  List<Object> get props => [safety];
}
