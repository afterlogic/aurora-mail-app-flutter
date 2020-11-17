import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class SettingsNavigator {
  Future pushNamed(String name, {dynamic arguments});

  Future setRoot(String name, {dynamic arguments});

  pop();
}

class SettingsNavigatorMock implements SettingsNavigator {
  final NavigatorState state;

  SettingsNavigatorMock(this.state);

  @override
  pop() {
    return state.pop();
  }

  @override
  Future pushNamed(String name, {arguments}) {
    return state.pushNamed(name, arguments: arguments);
  }

  @override
  Future setRoot(String name, {arguments}) {
    return state.pushNamed(name, arguments: arguments);
  }
}

class SettingsNavigatorWidget extends StatefulWidget {
  final String initialRoute;
  final Route<dynamic> Function(RouteSettings settings) routeFactory;
  final Function onUpdate;

  const SettingsNavigatorWidget({
    Key key,
    this.initialRoute,
    this.routeFactory,
    this.onUpdate,
  }) : super(key: key);

  @override
  SettingsNavigatorState createState() => SettingsNavigatorState();

  static SettingsNavigator of(BuildContext context) {
    try {
      return Provider.of<SettingsNavigator>(context, listen: false);
    } catch (_) {
      return SettingsNavigatorMock(Navigator.of(context));
    }
  }
}

class _NavigatorRoute {
  final Widget widget;
  final Completer completer;
  final String name;

  _NavigatorRoute(this.widget, this.name) : completer = Completer();
}

class SettingsNavigatorState extends State<SettingsNavigatorWidget>
    with TickerProviderStateMixin
    implements SettingsNavigator {
  final _stack = <_NavigatorRoute>[];

  _NavigatorRoute get current => _stack.last;

  @override
  initState() {
    super.initState();
    _add(widget.initialRoute);
  }

  Completer _add(String name, [dynamic arg]) {
    final route =
        widget.routeFactory(RouteSettings(name: name, arguments: arg));
    if (route is ModalRoute) {
      final child = route.buildPage(
        context,
        AnimationController(
          duration: Duration(milliseconds: 300),
          vsync: this,
        ),
        AnimationController(
          duration: Duration(milliseconds: 300),
          vsync: this,
        ),
      );
      final settingsRoute = _NavigatorRoute(child, name);

      _stack.add(settingsRoute);
      return settingsRoute.completer;
    }
    return null;
  }

  Future pushNamed(String name, {dynamic arguments}) {
    final future = _add(name, arguments)?.future;
    setState(() {});
    widget.onUpdate();
    return future;
  }

  bool pop() {
    if (_stack.length == 1) {
      return true;
    } else {
      final last = _stack.removeLast();
      setState(() {});
      widget.onUpdate();
      last.completer.complete();
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return pop();
      },
      child: _stack.isEmpty
          ? SizedBox.shrink()
          : Provider<SettingsNavigator>.value(
              value: this,
              child: current.widget,
            ),
    );
  }

  @override
  Future setRoot(String name, {arguments}) {
    _stack.clear();
    return pushNamed(name, arguments: arguments);
  }
}
