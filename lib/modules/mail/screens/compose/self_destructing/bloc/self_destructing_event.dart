import 'package:aurora_mail/modules/mail/screens/compose/self_destructing/model/contact_with_key.dart';
import 'package:aurora_mail/modules/mail/screens/compose/self_destructing/model/life_time.dart';
import 'package:aurora_mail/utils/always_non_equal_object.dart';
import 'package:crypto_model/crypto_model.dart';
import 'package:equatable/equatable.dart';

abstract class SelfDestructingEvent extends Equatable {
  const SelfDestructingEvent();
}

class LoadKey extends SelfDestructingEvent {
  final String contact;

  LoadKey(this.contact);

  @override
  List<Object> get props => [];
}

class EncryptEvent extends SelfDestructingEvent with AlwaysNonEqualObject {
  final LifeTime lifeTime;
  final bool isKeyBased;
  final bool useSign;
  final String password;

  final List<String> contacts;

  EncryptEvent(
    this.lifeTime,
    this.isKeyBased,
    this.useSign,
    this.password,
    this.contacts,
  );

  @override
  List<Object> get props => [];
}

