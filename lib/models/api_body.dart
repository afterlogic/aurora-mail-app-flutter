import 'package:flutter/cupertino.dart';

class ApiBody {
  final String module;
  final String method;
  final String parameters;

  ApiBody({
    @required this.module,
    @required this.method,
    this.parameters,
  });

  Map<String, String> toMap() {
    if (parameters != null) {
      return {'Module': module, 'Method': method, 'Parameters': parameters};
    } else {
      return {'Module': module, 'Method': method};
    }
  }
}
