import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'mail_state.g.dart';

class MailState = _MailState with _$MailState;

abstract class _MailState with Store {
  final scaffoldKey = GlobalKey<ScaffoldState>();
}
