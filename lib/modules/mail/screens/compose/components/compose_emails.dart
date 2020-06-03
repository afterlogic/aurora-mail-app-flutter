import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/input_validation.dart';
import 'package:aurora_mail/utils/mail_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'compose_type_ahead.dart';
import 'fit_text_field.dart';

class ComposeEmails extends StatefulWidget {
  final String label;
  final bool enable;
  final TextEditingController textCtrl;
  final Set<String> emails;
  final Function onCCSelected;
  final FocusNode focusNode;
  final EdgeInsets padding;
  final VoidCallback onNext;

  const ComposeEmails({
    Key key,
    @required this.label,
    @required this.emails,
    @required this.textCtrl,
    this.onCCSelected,
    this.focusNode,
    this.enable = true,
    this.padding,
    this.onNext,
  }) : super(key: key);

  @override
  ComposeEmailsState createState() => ComposeEmailsState();
}

class ComposeEmailsState extends BState<ComposeEmails> {
  final textFieldKey = GlobalKey();
  final composeTypeAheadFieldKey = GlobalKey<ComposeTypeAheadFieldState>();
  String _emailToShowDelete;

  String _search;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      if (!widget.focusNode.hasFocus) {
        _addEmail(widget.textCtrl.text);
      }
      if (widget.onCCSelected != null) widget.onCCSelected();
      setState(() => _emailToShowDelete = null);
    });
  }

  Future _addEmail(String _email) async {
    final email = _email.startsWith(" ") ? _email.substring(1) : _email;
    widget.textCtrl.text = " ";
    widget.textCtrl.selection = TextSelection.collapsed(offset: 1);
    lastSuggestions = [];
    final error = validateInput(
        context, email, [ValidationType.email, ValidationType.empty]);
    if (error == null) {
      setState(() => widget.emails.add(email));
    }
    composeTypeAheadFieldKey.currentState.resize();
  }

  void _deleteEmail(String email) {
    setState(() => widget.emails.remove(email));
    composeTypeAheadFieldKey.currentState.resize();
  }

  validate() {
    final text = widget.emails.isEmpty
        ? widget.textCtrl.text
        : widget.textCtrl.text.substring(1);
    if (text.isNotEmpty) {
      _addEmail(text);
    }
  }

  List<Contact> lastSuggestions = [];

  Future<List<Contact>> _buildSuggestions(String _pattern) async {
    final pattern = _pattern.replaceAll(" ", "");
    try {
      if (pattern.isEmpty) {
        return [];
      }
      _search = pattern;

      final bloc = BlocProvider.of<ContactsBloc>(context);
      final contacts = await bloc.getTypeAheadContacts(pattern);

      contacts.removeWhere((i) => i.viewEmail.isEmpty);
      contacts.removeWhere(
          (i) => widget.emails.contains(MailUtils.getFriendlyName(i)));
      return contacts;
    } catch (e, s) {
      print(s);
      return [];
    }
  }

  _focus() {
    widget.focusNode.requestFocus();
    if (widget.onCCSelected != null) widget.onCCSelected();
  }

  _paste() async {
    _focus();
    await Future.delayed(Duration(milliseconds: 100));
    final gesture = textFieldKey.currentState
        as TextSelectionGestureDetectorBuilderDelegate;
    gesture.editableTextKey.currentState.toggleToolbar();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dropDownWidth = screenWidth / 1.25;

    TextSpan _searchMatch(String match) {
      final color = theme.textTheme.body1.color;
      final posRes = TextStyle(fontWeight: FontWeight.w700, color: color);
      final negRes = TextStyle(fontWeight: FontWeight.w400, color: color);

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

    Widget _searchContact(Contact contact) {
      return Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (contact.fullName.isNotEmpty)
                  RichText(
                    text: _searchMatch(contact.fullName),
                    maxLines: 1,
                  ),
                if (contact.viewEmail.isNotEmpty)
                  RichText(
                    text: _searchMatch(contact.viewEmail),
                    maxLines: 1,
                  ),
              ],
            ),
          ),
//todo
//          if ((contact.pgpPublicKey?.length ?? 0) > 5) Icon(Icons.vpn_key),
        ],
      );
    }

    return Container(
      padding: widget.padding,
      decoration: BoxDecoration(
        color: widget.enable ? null : theme.disabledColor.withAlpha(20),
      ),
      child: InkWell(
        onLongPress: widget.enable ? _paste : null,
        onTap: widget.enable ? _focus : null,
        child: ComposeTypeAheadField<Contact>(
          key: composeTypeAheadFieldKey,
          textFieldConfiguration: TextFieldConfiguration(
            focusNode: widget.focusNode,
            enabled: widget.enable,
            controller: widget.textCtrl,
          ),
          animationDuration: Duration.zero,
          suggestionsBoxDecoration: SuggestionsBoxDecoration(
            color: theme.cardColor,
            constraints: BoxConstraints(
              minWidth: dropDownWidth,
              maxWidth: dropDownWidth,
            ),
          ),
          suggestionsBoxVerticalOffset: 0.0,
          suggestionsBoxHorizontalOffset: screenWidth - dropDownWidth - 16 * 2,
          autoFlipDirection: true,
          hideOnLoading: true,
          keepSuggestionsOnLoading: true,
          getImmediateSuggestions: true,
          noItemsFoundBuilder: (_) => SizedBox(),
          suggestionsCallback: (pattern) async =>
              lastSuggestions = await _buildSuggestions(pattern),
          itemBuilder: (_, c) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: _searchContact(c),
            );
          },
          onSuggestionSelected: (c) {
            widget.focusNode.requestFocus();
            return _addEmail(MailUtils.getFriendlyName(c));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0),
                  child: Text(widget.label, style: theme.textTheme.subhead),
                ),
                SizedBox(width: 8.0),
                Flexible(
                  flex: 1,
                  child: Wrap(spacing: 8.0, children: [
                    ...widget.emails.map((e) {
                      final displayName = MailUtils.displayNameFromFriendly(e);
                      return SizedBox(
                        height: 43.0,
                        child: GestureDetector(
                          onTap: widget.enable
                              ? () {
                                  if (_emailToShowDelete == e) {
                                    setState(() => _emailToShowDelete = null);
                                  } else {
                                    setState(() => _emailToShowDelete = e);
                                  }
                                }
                              : null,
                          child: Chip(
                            avatar: CircleAvatar(
                              backgroundColor: theme.accentColor,
                              child: Text(
                                displayName[0],
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            label: Text(displayName),
                            onDeleted: e == _emailToShowDelete
                                ? () => _deleteEmail(e)
                                : null,
                          ),
                        ),
                      );
                    }).toList(),
                    FitTextField(
                      controller: widget.textCtrl,
                      child: TextField(
                        key: textFieldKey,
                        enabled: widget.enable,
                        focusNode: widget.focusNode,
                        controller: widget.textCtrl,
                        autofocus: true,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration.collapsed(
                          hintText: null,
                        ),
                        onChanged: (value) {
                          if (widget.emails.isNotEmpty && value.isEmpty) {
                            widget.textCtrl.text = " ";
                            widget.textCtrl.selection =
                                TextSelection.collapsed(offset: 1);
                            _deleteEmail(widget.emails.last);
                          } else if (value.length > 1 && value.endsWith(" ")) {
                            if (lastSuggestions.isEmpty) {
                              widget.onNext();
                            } else {
                              _addEmail(MailUtils.getFriendlyName(
                                  lastSuggestions.first));
                            }
                          }
                        },
                        onEditingComplete: () {
                          if (lastSuggestions.isEmpty) {
                            widget.onNext();
                          } else {
                            _addEmail(MailUtils.getFriendlyName(
                                lastSuggestions.first));
                            composeTypeAheadFieldKey.currentState.clear();
                          }
                        },
                      ),
                    ),
                  ]),
                ),
                if (widget.focusNode.hasFocus && false)
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
        ),
      ),
    );
  }
}
