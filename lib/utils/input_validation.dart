import 'package:aurora_mail/utils/internationalization.dart'; import 'package:aurora_mail/res/str/s.dart';
import 'package:flutter/cupertino.dart';

enum ValidationType {
  empty,
  email,
  fileName,
  uniqueName,
}

String validateInput(
  BuildContext context,
  String value,
  List<ValidationType> types, [
  List otherItems,
  String fileExtension,
]) {
  if (types.contains(ValidationType.uniqueName) && otherItems is! List) {
    throw "In order to check if a name is unique the list must be provided";
  }
  if (types.contains(ValidationType.empty) && value.isEmpty) {
    return i18n(context, S.error_input_validation_empty);
  }
  if (types.contains(ValidationType.email) && !isEmailValid(value)) {
    return i18n(context, S.error_input_validation_email);
  }
  if (types.contains(ValidationType.fileName) && !_isFileNameValid(value)) {
    return i18n(context, S.error_input_validation_name_illegal_symbol);
  }
  if (otherItems is List && types.contains(ValidationType.uniqueName)) {
    bool exists = false;
    final valueToCheck =
        fileExtension != null ? "$value.$fileExtension" : value;
    otherItems.forEach((item) {
      if (item.name == valueToCheck) exists = true;
    });

    if (exists) return i18n(context, S.error_input_validation_unique_name);
  }

  // else the field is valid
  return null;
}

bool _isFileNameValid(String fileName) {
  final regExp = new RegExp(r'["/\\*?<>|:]');

  return !regExp.hasMatch(fileName);
}

bool isEmailValid(String email) {
  final regExp = new RegExp(
      r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  final friendlyNameRegExp = new RegExp(
      r'".+" <(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))>');
  return regExp.hasMatch(email) || friendlyNameRegExp.hasMatch(email);
}
