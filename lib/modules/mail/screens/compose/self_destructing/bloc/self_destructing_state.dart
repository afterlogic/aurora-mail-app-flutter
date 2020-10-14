import 'package:aurora_mail/modules/mail/screens/compose/self_destructing/model/contact_with_key.dart';
import 'package:aurora_mail/utils/always_non_equal_object.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:equatable/equatable.dart';

abstract class SelfDestructingState extends Equatable {
  const SelfDestructingState();
}

class InitState extends SelfDestructingState {
  @override
  List<Object> get props => [];
}

class ProgressState extends SelfDestructingState {
  @override
  List<Object> get props => [];
}

class LoadedContacts extends SelfDestructingState {
  final List<ContactWithKey> contacts;

  LoadedContacts(this.contacts);

  @override
  List<Object> get props => [contacts];
}

class LoadedKey extends SelfDestructingState {
  final ContactWithKey sender;
  final ContactWithKey contact;

  LoadedKey(this.sender, this.contact);

  @override
  List<Object> get props => [sender.hashCode, contact.hashCode];
}

class ErrorState extends SelfDestructingState with AlwaysNonEqualObject {
  final ErrorToShow message;

  ErrorState(this.message);

  @override
  List<Object> get props => [];
}

class Encrypted extends SelfDestructingState with AlwaysNonEqualObject {
  final ContactWithKey contact;
  final String link;
  final bool isKeyBase;
  final String password;
  final String body;

  Encrypted(this.isKeyBase, this.password, this.body, this.contact, this.link);

  @override
  List<Object> get props => [];
}
