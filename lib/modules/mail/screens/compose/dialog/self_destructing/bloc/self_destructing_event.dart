import 'package:equatable/equatable.dart';

abstract class SelfDestructingEvent extends Equatable {
  const SelfDestructingEvent();
}

class LoadContacts extends Equatable {
  @override
  List<Object> get props => [];
}
