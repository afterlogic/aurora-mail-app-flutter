import 'package:aurora_mail/modules/mail/screens/compose/self_destructing/model/contact_with_key.dart';
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

  LoadedKey(this.key);

  @override
  List<Object> get props => [key];
}
