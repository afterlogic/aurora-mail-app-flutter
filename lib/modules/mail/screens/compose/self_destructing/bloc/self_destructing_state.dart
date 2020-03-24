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
  final ContactWithKey contact;

  LoadedKey(this.key, this.contact);

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
  final ContactWithKey contact;
  final String link;
  final bool isKeyBase;
  final String password;
  final String body;

  Encrypted(this.isKeyBase, this.password, this.body, this.contact, this.link);

  @override
  List<Object> get props => [];
}
