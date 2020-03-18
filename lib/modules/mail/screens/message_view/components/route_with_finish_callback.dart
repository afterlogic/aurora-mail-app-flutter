import 'package:flutter/cupertino.dart';

class RouteWithFinishCallback extends CupertinoPageRoute {
  RouteAnimationListener routeAnimationListener;

  RouteWithFinishCallback({
    @required WidgetBuilder builder,
    String title,
    RouteSettings settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
    @required this.routeAnimationListener,
  }) : super(
          builder: builder,
          title: title,
          settings: settings,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    animation.addStatusListener(routeEndListener);
    return super.buildTransitions(
      context,
      animation,
      secondaryAnimation,
      child,
    );
  }

  routeEndListener(AnimationStatus status) {
    if (status == AnimationStatus.completed &&
        routeAnimationListener?.onComplete != null) {
      routeAnimationListener?.onComplete();
      routeAnimationListener?.onComplete = null;
    }
  }
}

class RouteAnimationListener {
  Function onComplete;
}
