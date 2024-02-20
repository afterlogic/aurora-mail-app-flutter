//@dart=2.9
import 'package:flutter/material.dart';

class FadeRoute extends PageRouteBuilder {
  final Widget Function(BuildContext) builder;
  final int duration;
  final bool fullscreenDialog;
  final RouteSettings settings;

  FadeRoute(
      {this.settings,
      this.duration = 200,
      @required this.builder,
      this.fullscreenDialog = false})
      : super(
            settings: settings,
            transitionDuration: Duration(milliseconds: duration),
            fullscreenDialog: fullscreenDialog,
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) =>
                builder(context),
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            });
}
