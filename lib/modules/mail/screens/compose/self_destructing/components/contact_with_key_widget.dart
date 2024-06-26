//@dart=2.9
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/mail/screens/compose/self_destructing/model/contact_with_key.dart';
import 'package:flutter/material.dart';

class ContactWithKeyWidget extends StatelessWidget {
  final ContactWithKey model;
  final Function(ContactWithKey) onTap;

  ContactWithKeyWidget(this.model, [this.onTap]);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var name = model.contact?.fullName;
    final hasName = !(name?.isNotEmpty != true);
    if (!hasName) {
      name = S.of(context).label_pgp_key_with_not_name;
    }
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (onTap != null) onTap(model);
      },
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  name,
                  maxLines: 1,
                  style: hasName
                      ? theme.textTheme.bodyText1
                      : theme.textTheme.caption,
                ),
                Text(
                  model.contact?.viewEmail ?? model.key?.mail ?? "",
                  maxLines: 1,
                  style: hasName
                      ? theme.textTheme.caption
                      : theme.textTheme.bodyText1,
                ),
              ],
            ),
          ),
          if (model.key != null) Icon(Icons.vpn_key)
        ],
      ),
    );
  }
}
