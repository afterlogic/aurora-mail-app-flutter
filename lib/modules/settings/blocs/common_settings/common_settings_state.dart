import 'package:equatable/equatable.dart';

abstract class CommonSettingsState extends Equatable {
  const CommonSettingsState();
}

class InitialCommonSettingsState extends CommonSettingsState {
  @override
  List<Object> get props => [];
}
