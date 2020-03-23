import 'package:equatable/equatable.dart';

abstract class SelfDestructingEvent extends Equatable {
  const SelfDestructingEvent();
}

class LoadContacts extends SelfDestructingEvent {
  @override
  List<Object> get props => [];
}

class LoadKey extends SelfDestructingEvent {
  @override
  List<Object> get props => [];
}
