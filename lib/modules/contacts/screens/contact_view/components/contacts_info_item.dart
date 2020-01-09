import 'package:flutter/material.dart';

class ContactsInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  ContactsInfoItem({this.icon, this.label, @required this.value}) : super(key: Key(value));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: icon != null
              ? Icon(icon)
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("$label",
                  style: TextStyle(
                      color: Theme.of(context)
                          .disabledColor
                          .withOpacity(0.5)))
            ],
          ),
          title: Text(value),
        ),
        Divider(height: 0.0, indent: 16.0, endIndent: 16.0),
      ],
    );
  }
}
