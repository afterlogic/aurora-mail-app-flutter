import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/utils/input_validation.dart';
import 'package:aurora_mail/utils/mail_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class ComposeEmails extends StatefulWidget {
  final String label;
  final TextEditingController textCtrl;
  final List<String> emails;
  final Function onCCSelected;

  const ComposeEmails({
    Key key,
    @required this.label,
    @required this.emails,
    @required this.textCtrl,
    this.onCCSelected,
  }) : super(key: key);

  @override
  _ComposeEmailsState createState() => _ComposeEmailsState();
}

class _ComposeEmailsState extends State<ComposeEmails> {
  String _emailToShowDelete;
  String _search;

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
        context, email, [ValidationType.email, ValidationType.empty]);
    if (error == null) {
      setState(() => widget.emails.add(email));
    }
  }

  void _deleteEmail(String email) {
    setState(() => widget.emails.remove(email));
  }

  Future<List<Contact>> _buildSuggestions(String pattern) async {
    _search = pattern;
    final bloc = BlocProvider.of<ContactsBloc>(context);
    final items = await bloc.getTypeAheadContacts(pattern);

    items.removeWhere((i) {
      final friendlyName = MailUtils.getFriendlyName(i);
      return widget.emails.contains(friendlyName) || i.viewEmail == null || i.viewEmail.isEmpty;
    });

    return items;
  }


  TextSpan _searchMatch(String match) {
    final posRes = TextStyle(fontWeight: FontWeight.w700);
    final negRes = TextStyle(fontWeight: FontWeight.w400);

    if (_search == null || _search == "")
      return TextSpan(text: match, style: negRes);
    var refinedMatch = match.toLowerCase();
    var refinedSearch = _search.toLowerCase();
    if (refinedMatch.contains(refinedSearch)) {
      if (refinedMatch.substring(0, refinedSearch.length) == refinedSearch) {
        return TextSpan(
          style: posRes,
          text: match.substring(0, refinedSearch.length),
          children: [
            _searchMatch(
              match.substring(
                refinedSearch.length,
              ),
            ),
          ],
        );
      } else if (refinedMatch.length == refinedSearch.length) {
        return TextSpan(text: match, style: posRes);
      } else {
        return TextSpan(
          style: negRes,
          text: match.substring(
            0,
            refinedMatch.indexOf(refinedSearch),
          ),
          children: [
            _searchMatch(
              match.substring(
                refinedMatch.indexOf(refinedSearch),
              ),
            ),
          ],
        );
      }
    } else if (!refinedMatch.contains(refinedSearch)) {
      return TextSpan(text: match, style: negRes);
    }
    return TextSpan(
      text: match.substring(0, refinedMatch.indexOf(refinedSearch)),
      style: negRes,
      children: [
        _searchMatch(match.substring(refinedMatch.indexOf(refinedSearch)))
      ],
    );
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
                  style: Theme.of(context).textTheme.subhead),
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
                        label: Text(MailUtils.displayNameFromFriendly(e)),
                        onDeleted: e == _emailToShowDelete
                            ? () => _deleteEmail(e)
                            : null,
                      ),
                    ),
                  );
                }).toList(),
                SizedBox(
                  height: !_focusNode.hasFocus ? 0 : null,
                  child: TypeAheadField<Contact>(
                    textFieldConfiguration: TextFieldConfiguration(
                      focusNode: _focusNode,
                      controller: widget.textCtrl,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration.collapsed(
                        hintText: null,
                      ),
                      onEditingComplete: _focusNode.unfocus,
                    ),
                    animationDuration: Duration.zero,
                    getImmediateSuggestions: true,
                    noItemsFoundBuilder: (_) => SizedBox(),
                    suggestionsCallback: _buildSuggestions,
                    itemBuilder: (_, c) {
                      final friendlyName = MailUtils.getFriendlyName(c);
                      return ListTile(title: RichText(
                          text: _searchMatch(friendlyName)));
                    },
                    onSuggestionSelected: (c) {
                      final friendlyName = MailUtils.getFriendlyName(c);
                      return _addEmail(friendlyName);
                    },
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
