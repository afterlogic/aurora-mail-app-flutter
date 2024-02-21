import 'package:aurora_logger/aurora_logger.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocLogger extends BlocObserver {
  @override
  void onError(BlocBase bloc, Object error, StackTrace stacktrace) {
    logger.log("Bloc error $error in ${bloc.runtimeType}");
    FirebaseCrashlytics.instance.recordError(error, stacktrace);
    super.onError(bloc, error, stacktrace);
  }
}
