import 'package:flutter/material.dart';

class InfoActionButton extends StatelessWidget {
  final IconData icon;
  final void Function() cb;

  const InfoActionButton({
    Key key,
    @required this.icon,
    @required this.cb,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
        color: Theme.of(context).accentColor,
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
      onTap: cb,
    );
  }
}
