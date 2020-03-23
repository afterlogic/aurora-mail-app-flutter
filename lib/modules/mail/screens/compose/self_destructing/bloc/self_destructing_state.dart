import 'package:aurora_mail/modules/mail/screens/compose/self_destructing/model/contact_with_key.dart';
import 'package:aurora_mail/utils/always_non_equal_object.dart';
import 'package:crypto_model/crypto_model.dart';
import 'package:equatable/equatable.dart';

abstract class SelfDestructingState extends Equatable {
  const SelfDestructingState();
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
  final PgpKey key;
  final List<ContactWithKey> contacts;

  LoadedKey(this.key, this.contacts);

  @override
  List<Object> get props => [key];
}

class ErrorState extends SelfDestructingState with AlwaysNonEqualObject {
  final String message;

  ErrorState(this.message);

  @override
  List<Object> get props => [];
}

class Encrypted extends SelfDestructingState with AlwaysNonEqualObject {
  final String subject;
  final String body;
  final String link;
  final bool isKeyBase;
  final String password;

  Encrypted(this.subject, this.body, this.link, this.isKeyBase, this.password);

  @override
  List<Object> get props => [];
}
