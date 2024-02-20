//@dart=2.9
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/identity_util.dart';
import 'package:crypto_model/crypto_model.dart';
import 'package:flutter/material.dart';

class KeyItem extends StatefulWidget {
  final PgpKey pgpKey;
  final bool external;
  final bool selected;
  final Function(bool) onSelect;

  const KeyItem({
    @required this.pgpKey,
    this.external,
    this.selected,
    this.onSelect,
  });

  @override
  _KeyItemState createState() => _KeyItemState();
}

class _KeyItemState extends BState<KeyItem> {
  @override
  Widget build(BuildContext context) {
    var textTheme = theme.textTheme;

    final length =
        widget.pgpKey.key?.length != null ? "${widget.pgpKey.length}" : "";
    final type = widget.pgpKey.isPrivate ? "private" : "public";
    final external = widget.external == true ? " (external)" : "";
    final description = "($length-bit, $type)$external";

    if (widget.onSelect == null) {
      textTheme = textTheme.apply(
        bodyColor: Colors.grey,
        displayColor: Colors.grey,
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Divider(
          color: Colors.transparent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.pgpKey.formatName(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: textTheme.bodyText2,
                    ),
                    Text(
                      description,
                      style: textTheme.caption,
                    ),
                  ],
                ),
              ),
            ),
            if (widget.selected != null)
              Checkbox(
                value: widget.selected,
                onChanged: (isSelected) {
                  widget.onSelect(isSelected);
                },
              )
          ],
        ),
        Divider(
          color: Colors.grey,
        ),
      ],
    );
  }
}
