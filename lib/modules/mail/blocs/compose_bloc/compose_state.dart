import 'package:aurora_mail/modules/mail/models/compose_attachment.dart';
import 'package:aurora_mail/modules/mail/models/temp_attachment_upload.dart';
import 'package:aurora_mail/utils/always_non_equal_object.dart';
import 'package:crypto_worker/crypto_worker.dart';
import 'package:equatable/equatable.dart';

abstract class ComposeState extends Equatable {
  const ComposeState();

  @override
  List<Object> get props => [];
}

class InitialComposeState extends ComposeState {}

class UploadStarted extends ComposeState {
  final TempAttachmentUpload tempAttachment;

  UploadStarted(this.tempAttachment);

  @override
  List<Object> get props => [tempAttachment];
}

class AttachmentUploaded extends ComposeState {
  final ComposeAttachment composeAttachment;

  AttachmentUploaded(this.composeAttachment);

  @override
  List<Object> get props => [composeAttachment];
}

class MessageSending extends ComposeState with AlwaysNonEqualObject {}

class MessageSent extends ComposeState with AlwaysNonEqualObject {}

class MessageSavedInDrafts extends ComposeState {
  final int draftUid;

  MessageSavedInDrafts(this.draftUid);

  @override
  List<Object> get props => [draftUid];
}

class ComposeError extends ComposeState with AlwaysNonEqualObject {
  final String errorMsg;
  final Map<String, String> arg;

  ComposeError(this.errorMsg, [this.arg]);

  @override
  List<Object> get props => [errorMsg, arg];
}

class ConvertingAttachments extends ComposeState {}

class ReceivedComposeAttachments extends ComposeState {
  final List<ComposeAttachment> attachments;

  ReceivedComposeAttachments(this.attachments);

  @override
  List<Object> get props => [attachments];
}

class EncryptComplete extends ComposeState with AlwaysNonEqualObject {
  final EncryptType type;
  final String text;

  EncryptComplete(this.text, this.type);

  @override
  List<Object> get props => [text, type];
}

class DecryptedState extends ComposeState {
  @override
  List<Object> get props => [];
}
