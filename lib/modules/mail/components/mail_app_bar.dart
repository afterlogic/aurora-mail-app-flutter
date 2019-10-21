import 'package:flutter/material.dart';

class MailAppBar extends StatefulWidget {
  @override
  _MailAppBarState createState() => _MailAppBarState();
}

class _MailAppBarState extends State<MailAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Title"),
    );
  }
}
