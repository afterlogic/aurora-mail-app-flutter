import 'package:moor_flutter/moor_flutter.dart';

@DataClassName("WhiteMail")
class WhiteMailTable extends Table {
  Set<Column> get primaryKey => {mail};

  TextColumn get mail => text()();
}
