import 'dart:io';

import 'package:aurora_ui_kit/components/am_app_bar.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';

class LogScreen extends StatelessWidget {
  final File file;
  final String content;

  const LogScreen(this.file, this.content);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AMAppBar(
        title: Text(file.path.split(Platform.pathSeparator).last),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              Share.text(
                file.path.split(Platform.pathSeparator).last,
                content,
                'text/plain',
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: SelectableText(
            content,
            maxLines: null,
          ),
        ),
      ),
    );
  }
}
