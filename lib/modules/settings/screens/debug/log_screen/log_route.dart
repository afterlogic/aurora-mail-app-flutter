import 'dart:io';

import 'log_screen.dart';

class LogRoute {
  static const name = "LogRoute";
}

class LogRouteArg {
  final File file;
  final String content;
  final Function(File) onDelete;

  LogRouteArg(this.file, this.content, this.onDelete);
}
