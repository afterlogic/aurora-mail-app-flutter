import 'package:flutter/widgets.dart';

class AppRouteObserver extends RouteObserver {
  @override
  void didPop(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    debugPrint('!!! AppRouteObserver didPop: ${route?.settings.name}');
  }

  @override
  void didPush(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    debugPrint('!!! AppRouteObserver didPush: ${route?.settings.name}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    debugPrint('!!! AppRouteObserver didReplace: ${newRoute?.settings.name}');
  }

  @override
  void didRemove(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    debugPrint('!!! AppRouteObserver didRemove: ${route?.settings.name}');
  }
}
