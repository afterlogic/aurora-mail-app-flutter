import 'package:flutter/material.dart';

class SizedDialogContent extends StatelessWidget {
  final Widget child;

  const SizedDialogContent({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.height / 2,
      height: size.height / 2,
      child: child,
    );
  }
}
