//@dart=2.9
import 'package:flutter/material.dart';

class SlideHorizontalRoute extends PageRouteBuilder {
  final Widget Function(BuildContext) builder;
  final int duration;
  final RouteSettings settings;

  SlideHorizontalRoute(
      {this.settings, this.duration = 150, @required this.builder})
      : super(
            settings: settings,
            transitionDuration: Duration(milliseconds: duration),
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
              return SlideTransition(
                position: animation.drive(
                    Tween(begin: Offset(0.4, 0.0), end: Offset.zero)
                        .chain(CurveTween(curve: Curves.easeOutQuart))),
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );
            });
}
