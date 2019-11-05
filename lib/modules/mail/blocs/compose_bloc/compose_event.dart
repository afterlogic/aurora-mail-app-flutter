import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class ComposeEvent extends Equatable {
  const ComposeEvent();

  @override
  List<Object> get props => null;
}

class SendMessage extends ComposeEvent {
  final String to;
  final String cc;
  final String bcc;
  final String subject;
  final String messageText;
  final int draftUid;

  SendMessage({
    @required this.to,
    @required this.cc,
    @required this.bcc,
    @required this.subject,
    @required this.messageText,
    @required this.draftUid,
  });

  @override
  List<Object> get props => [to, cc, bcc, subject, messageText, draftUid];
}

class SaveToDrafts extends ComposeEvent {
  final String to;
  final String cc;
  final String bcc;
  final String subject;
  final String messageText;
  final int draftUid;

  SaveToDrafts({
    @required this.to,
    @required this.cc,
    @required this.bcc,
    @required this.subject,
    @required this.messageText,
    @required this.draftUid,
  });

  @override
  List<Object> get props => [to, cc, bcc, subject, messageText, draftUid];
}
