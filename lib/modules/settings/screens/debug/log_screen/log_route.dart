import 'dart:io';

class LogRoute {
  static const name = "LogRoute";
}
class LogRouteArg {
  final File file;
  final String content;

  LogRouteArg(this.file, this.content);

}
