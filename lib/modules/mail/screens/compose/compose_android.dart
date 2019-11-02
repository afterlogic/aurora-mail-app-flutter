import 'package:aurora_mail/config.dart';
import 'package:flutter/material.dart';

import 'components/compose_app_bar.dart';
import 'components/compose_body.dart';
import 'components/compose_section.dart';
import 'components/compose_subject.dart';

class ComposeAndroid extends StatefulWidget {
  @override
  _ComposeAndroidState createState() => _ComposeAndroidState();
}

class _ComposeAndroidState extends State<ComposeAndroid> {
  bool _showBCC = false;

  final _toEmails = new List<String>();
  final _ccEmails = new List<String>();
  final _bccEmails = new List<String>();
  final _toTextCtrl = new TextEditingController();
  final _ccTextCtrl = new TextEditingController();
  final _bccTextCtrl = new TextEditingController();
  final _subjectTextCtrl = new TextEditingController();
  final _bodyTextCtrl = new TextEditingController();

  void _onAppBarActionSelected(ComposeAppBarAction action) {
    switch(action) {
      case ComposeAppBarAction.saveToDrafts:
        break;
      case ComposeAppBarAction.send:
        // TODO: Handle this case.
        break;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(APP_BAR_HEIGHT_ANDROID),
        child: ComposeAppBar(_onAppBarActionSelected),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        children: <Widget>[
          // TODO translate
          ComposeSection(
            label: "To",
            textCtrl: _toTextCtrl,
            emails: _toEmails,
          ),
          Divider(height: 0.0),
          // TODO translate
          ComposeSection(
            label: "CC",
            textCtrl: _ccTextCtrl,
            emails: _ccEmails,
            onCCSelected: () => setState(() => _showBCC = true),
          ),
          Divider(height: 0.0),
          if (_showBCC)
            // TODO translate
            ComposeSection(
              label: "BCC",
              textCtrl: _bccTextCtrl,
              emails: _bccEmails,
            ),
          if (_showBCC)
            Divider(height: 0.0),
          ComposeSubject(textCtrl: _subjectTextCtrl),
          Divider(height: 0.0),
          ComposeBody(textCtrl: _bodyTextCtrl),
        ],
      ),
    );
  }
}
