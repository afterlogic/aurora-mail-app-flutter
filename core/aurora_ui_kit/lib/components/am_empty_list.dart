import 'package:flutter/material.dart';

class AMEmptyList extends StatelessWidget {
  final String message;
  final double topMargin;

  const AMEmptyList({Key key, @required this.message, this.topMargin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: topMargin ?? 100.0,
        ),
        Center(
          child: Text(message),
        ),
      ],
    );
  }
}