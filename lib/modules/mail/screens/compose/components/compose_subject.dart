import 'package:flutter/material.dart';

class ComposeSubject extends StatefulWidget {
  final TextEditingController textCtrl;

  const ComposeSubject({Key key, @required this.textCtrl}) : super(key: key);

  @override
  _ComposeSubjectState createState() => _ComposeSubjectState();
}

class _ComposeSubjectState extends State<ComposeSubject> {
  var _focusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _focusNode.requestFocus,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              // TODO translate
              child:
                  Text("Subject", style: Theme.of(context).textTheme.subhead),
            ),
            SizedBox(width: 8.0),
            Flexible(
              flex: 1,
              child: Wrap(spacing: 8.0, children: [
                TextField(
                  onTap: null,
                  focusNode: _focusNode,
                  controller: widget.textCtrl,
                  decoration: InputDecoration.collapsed(
                    hintText: null,
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
