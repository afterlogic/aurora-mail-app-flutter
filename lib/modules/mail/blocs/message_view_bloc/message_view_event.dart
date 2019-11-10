import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:equatable/equatable.dart';

abstract class MessageViewEvent extends Equatable {
  const MessageViewEvent();
}

class DownloadAttachment extends MessageViewEvent {
  final MailAttachment attachment;

  const DownloadAttachment(this.attachment);

  @override
  List<Object> get props => [attachment];
}

class StartDownload extends MessageViewEvent {
  final String fileName;

  const StartDownload(this.fileName);

  @override
  List<Object> get props => [fileName];
}

class EndDownload extends MessageViewEvent {
  final String path;

  const EndDownload(this.path);

  @override
  List<Object> get props => [path];
}
