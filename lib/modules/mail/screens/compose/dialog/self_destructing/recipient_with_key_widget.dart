import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';

import 'model/recipient_with_key.dart';

class RecipientWidget extends StatelessWidget {
  final RecipientWithKey model;
  final Function(RecipientWithKey) onTap;

  RecipientWidget(this.model, [this.onTap]);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var name = model.contact?.fullName;
    final hasName = !(name?.isNotEmpty != true);
    if (!hasName) {
      name = i18n(context, "no_name");
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
                      ? theme.textTheme.body2
                      : theme.textTheme.body2.apply(color: Colors.grey),
                ),
                Text(
                  model?.contact?.viewEmail ?? model.key.mail,
                  maxLines: 1,
                  style: theme.textTheme.caption,
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
