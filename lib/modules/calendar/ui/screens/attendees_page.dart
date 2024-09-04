import 'dart:async';

import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/calendar/blocs/events/events_bloc.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/InviteStatus.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/attendee.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/attendee_card.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/mail/screens/compose/components/compose_type_ahead.dart';
import 'package:aurora_mail/modules/mail/screens/compose/components/fit_text_field.dart';
import 'package:aurora_mail/utils/input_validation.dart';
import 'package:aurora_mail/utils/mail_utils.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendeesRouteArg {
  final Set<Attendee> initAttendees;
  AttendeesRouteArg({required this.initAttendees});
}

class AttendeesPage extends StatefulWidget {
  static const name = "attendees_page";
  const AttendeesPage({super.key, required this.initAttendees});

  final Set<Attendee> initAttendees;

  @override
  State<AttendeesPage> createState() => _AttendeesPageState();
}

class _AttendeesPageState extends State<AttendeesPage> {
  final TextEditingController _emailController = TextEditingController();
  final _composeTypeAheadFieldKey = new GlobalKey<ComposeTypeAheadFieldState>();
  final _attendeesFocusNode = FocusNode();
  final Set<String> emails = {};
  late final Set<Attendee> _attendees;
  late final ContactsBloc _contactsBloc;
  List<Contact> lastSuggestions = [];
  String _search = "";
  String? _emailToShowDelete;


  @override
  void initState() {
    super.initState();
    _contactsBloc = BlocProvider.of<ContactsBloc>(context);
    _attendees = Set.of(widget.initAttendees);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dropDownWidth = screenWidth / 1.25;

    return Scaffold(
      appBar: AMAppBar(
        title: Text('Add attendee'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(_attendees);
              },
              child: Text(S.of(context).btn_save))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<EventsBloc, EventsState>(
                builder: (context, state) {
                  if (state.selectedEvent?.owner?.isNotEmpty ?? false) {
                    return Column(
                      children: [
                        const SizedBox(height: 8),
                        Text('Organizer: ${state.selectedEvent!.owner!}',
                            style: TextStyle(color: Colors.grey)),
                      ],
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFB6B5B5)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: InkWell(
                        // onLongPress: true ? _paste : null,
                        onTap: () {
                          if (_attendeesFocusNode.hasFocus) {
                            _attendeesFocusNode.unfocus();
                          } else {
                            _attendeesFocusNode.requestFocus();
                          }
                        },
                        child: ComposeTypeAheadField<Contact>(
                          key: _composeTypeAheadFieldKey,
                          textFieldConfiguration: TextFieldConfiguration(
                            focusNode: _attendeesFocusNode,
                            enabled: true,
                            controller: _emailController,
                          ),
                          animationDuration: Duration.zero,
                          suggestionsBoxDecoration: SuggestionsBoxDecoration(
                            color: Theme.of(context).cardColor,
                            constraints: BoxConstraints(
                              minWidth: dropDownWidth,
                              maxWidth: dropDownWidth,
                            ),
                          ),
                          suggestionsBoxVerticalOffset: 0.0,
                          suggestionsBoxHorizontalOffset:
                              screenWidth - dropDownWidth - 16 * 2,
                          autoFlipDirection: true,
                          hideOnLoading: true,
                          keepSuggestionsOnLoading: true,
                          getImmediateSuggestions: true,
                          noItemsFoundBuilder: (_) => SizedBox(),
                          suggestionsCallback: (pattern) async =>
                              lastSuggestions =
                                  await _buildSuggestions(pattern),
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
                            _attendeesFocusNode.requestFocus();
                            _addEmail(MailUtils.getFriendlyName(c));
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  flex: 1,
                                  child: FutureBuilder<Map<String, Contact>>(
                                    future: getContacts(),
                                    builder: (context, result) {
                                      return Wrap(spacing: 8.0, children: [
                                        ...emails.map((e) {
                                          final displayName = MailUtils
                                              .displayNameFromFriendly(e);
                                          Contact? contact;
                                          if (BuildProperty.cryptoEnable &&
                                              !BuildProperty.legacyPgpKey) {
                                            contact = result.data != null
                                                ? result.data![e]
                                                : null;
                                          }

                                          return SizedBox(
                                            height: 43.0,
                                            child: GestureDetector(
                                              onTap: () {
                                                if (_emailToShowDelete == e) {
                                                  setState(() =>
                                                      _emailToShowDelete =
                                                          null);
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
                                                label: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(displayName),
                                                    SizedBox(width: 5),
                                                    if (contact
                                                            ?.autoEncrypt ==
                                                        true)
                                                      Icon(
                                                          Icons.lock_outline),
                                                    if (contact?.autoSign ==
                                                        true)
                                                      Icon(
                                                          Icons.edit_outlined)
                                                  ],
                                                ),
                                                onDeleted: e ==
                                                        _emailToShowDelete
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
                                              focusNode: _attendeesFocusNode,
                                              controller: _emailController,
                                              autofocus: true,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              decoration:
                                                  InputDecoration.collapsed(
                                                hintText: null,
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
                    ),
                  ),
                  SizedBox(width: 8),
                  SizedBox(
                    height: 53,
                    width: 53,
                    child: ElevatedButton(
                      onPressed: _addAttendees,
                      child: Icon(Icons.add),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ..._attendees.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: AttendeeCard(
                    attendee: e,
                    onDelete: () => setState(() {
                      _attendees.remove(e);
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addAttendees() {
    if(_emailController.text.isNotEmpty && _emailController.text != " "){
      onSubmitFromKeyboard();
    }
    final attendees = emails.map((e) => Attendee(
        access: 0,
        email: MailUtils.emailFromFriendly(e),
        name: MailUtils.displayNameFromFriendly(e),
        status: InviteStatus.pending));
    _attendees.addAll(attendees);
    emails.clear();
    _attendeesFocusNode.unfocus();
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
    _attendeesFocusNode.unfocus();
  }

  Future _addEmail(String _email) async {
    final email = _email.startsWith(" ") ? _email.substring(1) : _email;
    _emailController.text = " ";
    _emailController.selection = TextSelection.collapsed(offset: 1);
    lastSuggestions = [];
    final String? error = validateInput(
        context, email, [ValidationType.email, ValidationType.empty]);
    if (error == null) {
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
              if (contact.fullName.isNotEmpty)
                RichText(
                  text: _searchMatch(
                      match: contact.fullName,
                      search: search,
                      context: context),
                  maxLines: 1,
                ),
              if (contact.viewEmail.isNotEmpty)
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
        if (BuildProperty.cryptoEnable &&
            (contact.pgpPublicKey?.length ?? 0) > 5)
          Icon(Icons.vpn_key),
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
