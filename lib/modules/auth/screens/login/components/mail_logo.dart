import 'package:flutter/material.dart';

class MailLogo extends StatelessWidget {
  final bool isBackground;

  const MailLogo({this.isBackground = false});

  @override
  Widget build(BuildContext context) {
    final size = isBackground ? 350.0 : 52.0;
    return Opacity(
      opacity: isBackground ? 0.05 : 1.0,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(500.0),
        ),
        child: Icon(Icons.alternate_email, size: isBackground ? 240.0 : 32.0 , color: Colors.white),
      ),
    );
  }
}
