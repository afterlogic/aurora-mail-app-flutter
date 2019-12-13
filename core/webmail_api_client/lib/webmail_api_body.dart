import 'package:flutter/cupertino.dart';

class WebMailApiBody {
  final String module;
  final String method;
  final String parameters;

  WebMailApiBody({
    this.module,
    @required this.method,
    this.parameters,
  });

  Map<String, String> toMap(String moduleName) {
    if (moduleName == null && module == null) {
      throw "Module name is unknown";
    }
    if (parameters != null) {
      return {
        'Module': module ?? moduleName,
        'Method': method,
        'Parameters': parameters,
      };
    } else {
      return {'Module': module ?? moduleName, 'Method': method};
    }
  }
}
