import 'dart:convert';
import 'dart:io';

import 'package:aurora_ui_kit/components/am_app_bar.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';

class LogScreen extends StatelessWidget {
  final File file;
  final String content;
  final Function(File) onDelete;

  const LogScreen(this.file, this.content, this.onDelete);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AMAppBar(
        title: Text(file.path.split(Platform.pathSeparator).last),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              Share.file(
                file.path.split(Platform.pathSeparator).last,
                file.path.split(Platform.pathSeparator).last,
                utf8.encode(content),
                'text/plain',
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              onDelete(file);
              Navigator.pop(context);
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
