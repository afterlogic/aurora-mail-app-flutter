import 'package:flutter/widgets.dart';

class ContactsStorage {
  final String id;
  final String name;
  final int cTag;

  const ContactsStorage({
    @required this.id,
    @required this.name,
    @required this.cTag,
  });
}
