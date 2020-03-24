import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClipboardLabel extends StatelessWidget {
  final String link;
  final String description;
  final Function onTap;

  const ClipboardLabel(this.link, this.description, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
        Clipboard.setData(ClipboardData(text: link));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(description),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.content_copy),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    link,
                    maxLines: null,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
