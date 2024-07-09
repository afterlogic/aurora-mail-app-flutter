import 'dart:collection';

import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/base_calendar_dialog.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/participant_card.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/contacts_bloc.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/mail/screens/compose/components/compose_type_ahead.dart';
import 'package:aurora_mail/modules/mail/screens/compose/components/fit_text_field.dart';
import 'package:aurora_mail/utils/input_validation.dart';
import 'package:aurora_mail/utils/mail_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarSharingDialog extends StatefulWidget {
  final Set<Participant> participants;
  const CalendarSharingDialog(this.participants);

  static Future<Set<Participant>?> show(BuildContext context,
      {required Set<Participant> participants}) {
    return showDialog<Set<Participant>?>(
        context: context, builder: (_) => CalendarSharingDialog(participants));
  }

  @override
  State<CalendarSharingDialog> createState() => _CalendarSharingDialogState();
}

class _CalendarSharingDialogState extends State<CalendarSharingDialog> {
  final addAllContact = Contact.empty(
    fullName: 'All',
  );
  final TextEditingController _emailController = TextEditingController();
  final _composeTypeAheadFieldKey = new GlobalKey<ComposeTypeAheadFieldState>();
  final _participantsFocusNode = FocusNode();
  final Set<String> emails = {};
  late final Set<Participant> _participants;
  late final ContactsBloc _contactsBloc;
  List<Contact> lastSuggestions = [];
  String _search = "";
  String? _emailToShowDelete;

  @override
  void initState() {
    super.initState();
    _contactsBloc = BlocProvider.of<ContactsBloc>(context);
    _participants = widget.participants;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = 400.0;
    final dropDownWidth = screenWidth / 1.25;

    return BaseCalendarDialog(
      title: 'Share calendar',
      content: SizedBox(
        height: 200,
        width: screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFB6B5B5)),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: InkWell(
                          onTap: emails.isNotEmpty ? null : () {
                            if (_participantsFocusNode.hasFocus) {
                              _participantsFocusNode.unfocus();
                            } else {
                              _participantsFocusNode.requestFocus();
                            }
                          },
                          child: ComposeTypeAheadField<Contact>(
                            key: _composeTypeAheadFieldKey,
                            textFieldConfiguration: TextFieldConfiguration(
                              focusNode: _participantsFocusNode,
                              enabled: true,
                              controller: _emailController,
                            ),
                            animationDuration: Duration.zero,
                            suggestionsBoxDecoration: SuggestionsBoxDecoration(
                              color: Theme.of(context).cardColor,
                              constraints: constraints,
                            ),
                            suggestionsBoxVerticalOffset: 0.0,
                            suggestionsBoxHorizontalOffset: -8 ,
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
                                child: _SearchContact(
                                  contact: c,
                                  search: _search,
                                ),
                              );
                            },
                            onSuggestionSelected: (c) {
                              if(_participantsFocusNode.hasFocus){
                                _participantsFocusNode.unfocus();
                              }
                              if (c == addAllContact) {
                                _addEmail(ParticipantAll.addAllIdentifier);
                              } else {
                                _addEmail(MailUtils.getFriendlyName(c));
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    flex: 1,
                                    child: FutureBuilder<Map<String, Contact>>(
                                      future: getContacts(),
                                      builder: (context, result) {
                                        return Wrap(children: [
                                          ...emails.map((e) {
                                            final displayName = e ==
                                                    ParticipantAll.addAllIdentifier
                                                ? 'All'
                                                : MailUtils.displayNameFromFriendly(
                                                    e);

                                            return SizedBox(
                                              height: 43.0,
                                              child: GestureDetector(
                                                onTap: () {
                                                  if (_emailToShowDelete == e) {
                                                    setState(() =>
                                                        _emailToShowDelete = null);
                                                  } else {
                                                    setState(() =>
                                                        _emailToShowDelete = e);
                                                  }
                                                },
                                                child: Chip(
                                                  avatar: CircleAvatar(
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                    child: Text(
                                                      displayName[0],
                                                      style: TextStyle(
                                                          color: Colors.white),
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
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12),
                                            child: FitTextField(
                                              controller: _emailController,
                                              child: TextField(
                                                // key: textFieldKey,
                                                enabled: true,
                                                focusNode: _participantsFocusNode,
                                                controller: _emailController,
                                                autofocus: true,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                decoration:
                                                    InputDecoration.collapsed(
                                                  hintText: 'Add',
                                                ),
                                                onChanged: (value) {
                                                  if (emails.isNotEmpty &&
                                                      value.isEmpty) {
                                                    _emailController.text = " ";
                                                    _emailController.selection =
                                                        TextSelection.collapsed(
                                                            offset: 1);
                                                    _deleteEmail(emails.last);
                                                  } else if (value.length > 1 &&
                                                      value.endsWith(" ")) {
                                                    onSubmitFromKeyboard();
                                                  }
                                                },
                                                onEditingComplete: () {
                                                  onSubmitFromKeyboard();
                                                },
                                              ),
                                            ),
                                          ),
                                        ]);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  ),
                ),
                SizedBox(width: 8),
                SizedBox(
                  height: 53,
                  width: 53,
                  child: ElevatedButton(
                    onPressed: _addParticipants,
                    child: Icon(Icons.add),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: SplayTreeSet<Participant>.from(
                  _participants,
                  (a, b) => a.email.compareTo(b.email),
                )
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ParticipantCard(
                          participant: e,
                          onDelete: () => setState(() {
                            _participants.remove(e);
                          }),
                          onSelectedPermissionsOption:
                              (ParticipantPermissions? permission) {
                            if (permission == null) return;
                            _participants.remove(e);
                            _participants
                                .add(e.copyWith(permissions: permission));
                            setState(() {});
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
            )),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(_participants);
          },
          child: Text('Save'),
        ),
      ],
    );
  }

  void _addParticipants() {
    final participants = emails.map((e) => e == ParticipantAll.addAllIdentifier
        ? ParticipantAll(
            permissions: ParticipantPermissions.read,
          )
        : Participant(
            email: MailUtils.emailFromFriendly(e),
            name: MailUtils.displayNameFromFriendly(e),
            permissions: ParticipantPermissions.read));
    _participants.removeWhere((e) => emails.contains(e.email));
    _participants.addAll(participants);
    emails.clear();
    _participantsFocusNode.unfocus();
    setState(() {});
  }

  void _deleteEmail(String email) {
    setState(() => emails.remove(email));
    _composeTypeAheadFieldKey.currentState?.reopen();
  }

  onSubmitFromKeyboard() {
    if (lastSuggestions.isEmpty) {
      if (isEmailValid(_emailController.text.replaceAll(" ", ""))) {
        _addEmail(_emailController.text.replaceAll(" ", ""));
        _composeTypeAheadFieldKey.currentState?.clear();
      }
    } else {
      _addEmail(MailUtils.getFriendlyName(lastSuggestions.first));
      _composeTypeAheadFieldKey.currentState?.clear();
    }
    _participantsFocusNode.unfocus();
  }

  Future _addEmail(String _email) async {
    final email = _email.startsWith(" ") ? _email.substring(1) : _email;
    _emailController.text = " ";
    _emailController.selection = TextSelection.collapsed(offset: 1);
    lastSuggestions = [];
    final String? error = validateInput(
        context, email, [ValidationType.email, ValidationType.empty]);
    if (error == null || _email == ParticipantAll.addAllIdentifier) {
      setState(() => emails.add(email));
    }
    _composeTypeAheadFieldKey.currentState?.reopen();
  }

  Future<Map<String, Contact>> getContacts() async {
    if (emails.isEmpty) {
      return {};
    }
    final contacts = <String, Contact>{};
    for (String emailWithName in emails) {
      String? email;
      final match = RegExp("<(.*)?>").firstMatch(emailWithName);
      if (match != null && match.groupCount > 0) {
        if (match.group(1) != null) email = match.group(1)!;
      } else {
        email = emailWithName;
      }
      if (email == null) continue;
      final emailContacts = await _contactsBloc.getContactsByEmail(email);
      if (emailContacts.isNotEmpty) {
        final contact = emailContacts.firstWhere(
          (element) => element.storage == "personal",
          orElse: () => emailContacts.first,
        );
        final displayName = MailUtils.getFriendlyName(contact);
        contacts[displayName] = contact;
      }
    }
    return contacts;
  }

  Future<List<Contact>> _buildSuggestions(String _pattern) async {
    final pattern = _pattern.replaceAll(" ", "");
    try {
      if (pattern.isEmpty) {
        return [];
      }
      _search = pattern;
      final contacts = await _contactsBloc.getTypeAheadContacts(pattern);

      contacts.removeWhere((i) => i.viewEmail.isEmpty);
      contacts
          .removeWhere((i) => emails.contains(MailUtils.getFriendlyName(i)));
      contacts.add(addAllContact);
      return contacts;
    } catch (e, s) {
      print(s);
      return [];
    }
  }
}

class _SearchContact extends StatelessWidget {
  const _SearchContact(
      {super.key, required this.contact, required this.search});

  final Contact contact;
  final String search;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (contact.fullName?.isNotEmpty == true)
                RichText(
                  text: _searchMatch(
                      match: contact.fullName,
                      search: search,
                      context: context),
                  maxLines: 1,
                ),
              if (contact.viewEmail?.isNotEmpty == true)
                RichText(
                  text: _searchMatch(
                      match: contact.viewEmail,
                      search: search,
                      context: context),
                  maxLines: 1,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

TextSpan _searchMatch(
    {required String match,
    required String search,
    required BuildContext context}) {
  final color = Theme.of(context).textTheme.bodyText2?.color;
  final posRes = TextStyle(fontWeight: FontWeight.w700, color: color);
  final negRes = TextStyle(fontWeight: FontWeight.w400, color: color);

  if (search == "") return TextSpan(text: match, style: negRes);
  var refinedMatch = match.toLowerCase();
  var refinedSearch = search.toLowerCase();
  if (refinedMatch.contains(refinedSearch)) {
    if (refinedMatch.substring(0, refinedSearch.length) == refinedSearch) {
      return TextSpan(
        style: posRes,
        text: match.substring(0, refinedSearch.length),
        children: [
          _searchMatch(
            match: match.substring(
              refinedSearch.length,
            ),
            search: search,
            context: context,
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
            match: match.substring(
              refinedMatch.indexOf(refinedSearch),
            ),
            search: search,
            context: context,
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
      _searchMatch(
        match: match.substring(refinedMatch.indexOf(refinedSearch)),
        search: search,
        context: context,
      )
    ],
  );
}
