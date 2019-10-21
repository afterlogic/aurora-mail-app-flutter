import 'package:flutter/widgets.dart';

class CustomException implements Exception {
  final String message;

  CustomException(this.message) : super();

  @override
  String toString() => message;
}