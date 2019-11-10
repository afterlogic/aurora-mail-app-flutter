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

class MessagesViewError extends MessageViewState {
  final String errorMsg;

  const MessagesViewError(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}
