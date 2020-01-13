import 'package:flutter/material.dart';

class FadeRoute extends PageRouteBuilder {
  final Widget Function(BuildContext) builder;
  final int duration;
  final RouteSettings settings;

  FadeRoute({this.settings, this.duration = 300, @required this.builder})
      : super(
            settings: settings,
            transitionDuration: Duration(milliseconds: duration),
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) => builder(context),
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
