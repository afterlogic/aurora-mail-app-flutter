import 'package:flutter/material.dart';

class Star extends StatefulWidget {
  final bool value;
  final Function(bool) onPressed;

  const Star({Key key, @required this.value, @required this.onPressed})
      : super(key: key);

  @override
  _StarState createState() => _StarState();
}

class _StarState extends State<Star> with TickerProviderStateMixin {
  AnimationController _sizeAnimationController;
  bool _isStarred;

  @override
  void initState() {
    super.initState();
    _isStarred = widget.value;
    _sizeAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 100));
    _sizeAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _sizeAnimationController.reverse();
      }
    });
    _sizeAnimationController.addListener(() {
      setState(() {});
    });
  }

  void _setStarred(bool isStarred) {
    _sizeAnimationController.forward(from: 0.0);
    setState(() => _isStarred = isStarred);
    widget.onPressed(isStarred);
  }

  @override
  Widget build(BuildContext context) {
    if (_isStarred) {
      return Transform.scale(
          scale: 1 + _sizeAnimationController.value / 3,
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(Icons.star, color: Colors.amber),
            onPressed: () => _setStarred(false),
          ));
    } else {
      return Transform.scale(
        scale: 1 - _sizeAnimationController.value / 7,
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(
            Icons.star_border,
            color: Theme.of(context).disabledColor.withOpacity(0.1),
          ),
          onPressed: () => _setStarred(true),
        ),
      );
    }
  }
}
