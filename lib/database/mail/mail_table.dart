import 'package:moor_flutter/moor_flutter.dart';

@DataClassName("Message")
class Mail extends Table {
  IntColumn get localId => integer().autoIncrement()();
}
