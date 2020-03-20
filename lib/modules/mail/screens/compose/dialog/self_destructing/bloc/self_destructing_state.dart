import 'package:aurora_mail/modules/mail/screens/compose/dialog/self_destructing/model/recipient_with_key.dart';
import 'package:equatable/equatable.dart';

abstract class SelfDestructingState extends Equatable {
  const SelfDestructingState();
}

class ProgressState extends SelfDestructingState {
  @override
  List<Object> get props => [];
}

class LoadedContacts extends SelfDestructingState {
  final List<RecipientWithKey> contacts;

  LoadedContacts(this.contacts);

  @override
  List<Object> get props => [contacts];
}
