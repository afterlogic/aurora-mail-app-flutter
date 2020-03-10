import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ContactsInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final void Function(String) emailToContact;

  ContactsInfoItem({
    @required this.icon,
    @required this.label,
    @required this.value,
    this.emailToContact,
  }) : super(key: Key(value));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(width: 16.0),
          Icon(icon, color: theme.accentColor),
          SizedBox(width: 22.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(value,
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0)),
                SizedBox(height: 5.0),
                Text(
                  label,
                  style: TextStyle(fontSize: 12.0, color: theme.disabledColor),
                ),
              ],
            ),
          ),
          emailToContact != null
              ? InkWell(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                    color: theme.accentColor,
                    child: Icon(
                      MdiIcons.emailOutline,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () => emailToContact(value),
                )
              : SizedBox(),
        ],
      ),
    );
//    return ListTile(
//      leading: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          Icon(icon, color: theme.accentColor),
//        ],
//      ),
//      title: Text(value, style: TextStyle(fontWeight: FontWeight.w500)),
//      subtitle: Text(
//        label,
//        style: TextStyle(fontSize: 12.0),
//      ),
//      trailing: Container(
//        padding: EdgeInsets.all(6.0),
//        color: theme.accentColor,
//        child: Icon(MdiIcons.emailOutline, color: Colors.white,),
//      ),
//    );
  }
}
