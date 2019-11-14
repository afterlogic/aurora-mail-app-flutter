import 'package:aurora_mail/modules/mail/models/compose_attachment.dart';
import 'package:aurora_mail/modules/mail/models/temp_attachment_upload.dart';
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

class MessageSending extends ComposeState {}

class MessageSent extends ComposeState {}

class MessageSavedInDrafts extends ComposeState {
  final int draftUid;

  MessageSavedInDrafts(this.draftUid);

  @override
  List<Object> get props => [draftUid];
}

class ComposeError extends ComposeState {
  final String errorMsg;

  ComposeError(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}

class ConvertingAttachments extends ComposeState {}

class ReceivedComposeAttachments extends ComposeState {
  final List<ComposeAttachment> attachments;

  ReceivedComposeAttachments(this.attachments);

  @override
  List<Object> get props => [attachments];
}
