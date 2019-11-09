import 'package:aurora_mail/utils/input_validation.dart';
import 'package:flutter/material.dart';

class ComposeSection extends StatefulWidget {
  final String label;
  final TextEditingController textCtrl;
  final List<String> emails;
  final Function onCCSelected;

  const ComposeSection({
    Key key,
    @required this.label,
    @required this.emails,
    @required this.textCtrl,
    this.onCCSelected,
  }) : super(key: key);

  @override
  _ComposeSectionState createState() => _ComposeSectionState();
}

class _ComposeSectionState extends State<ComposeSection> {
  String _emailToShowDelete;
  var _focusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _focusNode.unfocus();
        _addEmail(widget.textCtrl.text);
      }

      if (widget.onCCSelected != null) widget.onCCSelected();
      setState(() => _emailToShowDelete = null);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  Future _addEmail(String email) async {
    widget.textCtrl.text = "";
    final error = validateInput(
        email, [ValidationType.email, ValidationType.empty]);
    if (error == null) {
      setState(() => widget.emails.add(email));
    }
  }

  void _deleteEmail(String email) {
    setState(() => widget.emails.remove(email));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _focusNode.requestFocus();
        if (widget.onCCSelected != null) widget.onCCSelected();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(widget.label,
                  style: Theme
                      .of(context)
                      .textTheme
                      .subhead),
            ),
            SizedBox(width: 8.0),
            Flexible(
              flex: 1,
              child: Wrap(spacing: 8.0, children: [
                ...widget.emails.map((e) {
                  return SizedBox(
                    height: 43.0,
                    child: GestureDetector(
                      onTap: () {
                        if (_emailToShowDelete == e) {
                          setState(() => _emailToShowDelete = null);
                        } else {
                          setState(() => _emailToShowDelete = e);
                        }
                      },
                      child: Chip(
                        label: Text(e),
                        onDeleted: e == _emailToShowDelete
                            ? () => _deleteEmail(e)
                            : null,
                      ),
                    ),
                  );
                }).toList(),
                SizedBox(
                  height: !_focusNode.hasFocus ? 0 : null,
                  child: TextField(
                    focusNode: _focusNode,
                    controller: widget.textCtrl,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration.collapsed(
                      hintText: null,
                    ),
                    onEditingComplete: _focusNode.unfocus,
                  ),
                ),
              ]),
            ),
            if (_focusNode.hasFocus && false)
              SizedBox(
                height: 24.0,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.add),
                  onPressed: null,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
