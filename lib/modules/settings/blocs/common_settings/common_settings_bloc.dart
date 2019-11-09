import 'dart:async';

import 'package:bloc/bloc.dart';

import './bloc.dart';

class CommonSettingsBloc
    extends Bloc<CommonSettingsEvent, CommonSettingsState> {
  @override
  CommonSettingsState get initialState => InitialCommonSettingsState();

  @override
  Stream<CommonSettingsState> mapEventToState(
    CommonSettingsEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
