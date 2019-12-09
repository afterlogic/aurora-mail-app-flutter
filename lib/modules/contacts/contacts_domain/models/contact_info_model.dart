import 'package:flutter/widgets.dart';

class ContactInfo {
  final String uuid;
  final int cTag;
  final String eTag;
  final String storage;

  ContactInfo({
    @required this.uuid,
    @required this.cTag,
    @required this.eTag,
    @required this.storage,
  });
}
