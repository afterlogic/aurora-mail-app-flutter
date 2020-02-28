import 'package:flutter_bloc/flutter_bloc.dart';

class BlocLogger extends BlocDelegate {
  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    print(stacktrace);
    print(error);
    super.onError(bloc, error, stacktrace);
  }
}
