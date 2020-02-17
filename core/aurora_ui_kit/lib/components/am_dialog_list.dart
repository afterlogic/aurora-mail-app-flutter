import 'package:flutter/material.dart';

class AMDialogList extends StatelessWidget {
  final List<Widget> children;

  const AMDialogList({Key key, @required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: screenHeight / 2.5),
      child: SingleChildScrollView(
        child: Column(
          children: children,
        ),
      ),
    );
  }
}
