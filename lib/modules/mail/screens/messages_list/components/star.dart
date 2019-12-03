import 'package:aurora_mail/generated/i18n.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/settings_bloc.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Star extends StatefulWidget {
  final bool value;
  final bool enabled;
  final Function(bool) onPressed;

  const Star({Key key, @required this.value, this.enabled = true, @required this.onPressed})
      : super(key: key);

  @override
  _StarState createState() => _StarState();
}

class _StarState extends State<Star> with TickerProviderStateMixin {
  final _animDuration = new Duration(milliseconds: 130);
  AnimationController _parentCtrl;
  Animation<double> _scaleAnimation;
  bool _isStarred;

  @override
  void initState() {
    super.initState();
    _isStarred = widget.value;
    _parentCtrl = new AnimationController(vsync: this, duration: _animDuration);
    _parentCtrl.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _parentCtrl.reverse();
      }
    });
    _parentCtrl.addListener(() {
      setState(() {});
    });
    _scaleAnimation = new Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
        new CurvedAnimation(parent: _parentCtrl, curve: Curves.easeInOut));
  }

  Future _setStarred(bool isStarred) async {
    _parentCtrl.forward(from: 0.0);
    setState(() => _isStarred = isStarred);
    // wait forward and reverse
    await Future.delayed(_animDuration);
    await Future.delayed(_animDuration);
    widget.onPressed(isStarred);
  }

  @override
  Widget build(BuildContext context) {
    if (_isStarred) {
      return Transform.scale(
          scale: 1 + _scaleAnimation.value / 4,
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(Icons.star, color: Colors.amber),
            onPressed: widget.enabled ? () => _setStarred(false) : null,
          ));
    } else {
      return Transform.scale(
        scale: 1 - _scaleAnimation.value / 7,
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(
            Icons.star_border,
            color: Theme.of(context).disabledColor.withOpacity(widget.enabled ? 0.1 : 0.0),
          ),
          onPressed: widget.enabled ? () => _setStarred(true) : null,
        ),
      );
    }
  }
}
