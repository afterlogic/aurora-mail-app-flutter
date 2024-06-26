import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/reminders_dialog.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/calendar_tile.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/text_input.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/mail/screens/compose/components/compose_emails.dart';
import 'package:aurora_mail/modules/mail/screens/compose/components/compose_type_ahead.dart';
import 'package:aurora_mail/modules/mail/screens/compose/components/fit_text_field.dart';
import 'package:aurora_mail/utils/mail_utils.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AttendeesPage extends StatefulWidget {
  static const name = "attendees_page";
  const AttendeesPage({super.key});

  @override
  State<AttendeesPage> createState() => _AttendeesPageState();
}

class _AttendeesPageState extends State<AttendeesPage> {
  final TextEditingController _emailController = TextEditingController();
  final _composeTypeAheadFieldKey = new GlobalKey<ComposeTypeAheadFieldState>();
  final _attendeesFocusNode = FocusNode();
  final Set<String> emails = {};
  late final ContactsBloc _contactsBloc;
  List<Contact> lastSuggestions = [];
  String _search = "";
  String? _emailToShowDelete;

  final List<String> _attendees = [
    '"John" <user2@domain.com>',
    '"Bill" <user3@domain.com>',
    '"Simpson" <user4@domain.com>',
    'user5@domain.com',
  ];

  String organizer = 'user@domain.com';
  String selectedUser = 'user1@domain.com';

  @override
  void initState() {
    super.initState();
    _contactsBloc = BlocProvider.of<ContactsBloc>(context);
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
          TextButton(onPressed: () {}, child: Text(S.of(context).btn_save))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SizedBox(
            height: 400,
            width: screenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Organizer: $organizer', style: TextStyle(color: Colors.grey)),
                SizedBox(height: 8),
                Row(
                  children: [
                    // Expanded(
                    //   child: DropdownButtonFormField<String>(
                    //     value: selectedUser,
                    //     onChanged: (String? newValue) {
                    //       setState(() {
                    //         selectedUser = newValue!;
                    //       });
                    //     },
                    //     items: <String>[
                    //       'user1@domain.com',
                    //       'user2@domain.com',
                    //       'user3@domain.com'
                    //     ].map<DropdownMenuItem<String>>((String value) {
                    //       return DropdownMenuItem<String>(
                    //         value: value,
                    //         child: Text(value),
                    //       );
                    //     }).toList(),
                    //     decoration: InputDecoration(
                    //       border: OutlineInputBorder(),
                    //     ),
                    //   ),
                    // ),
                    Expanded(
                      child: Container(
                        child: InkWell(
                          // onLongPress: true ? _paste : null,
                          onTap: () => _attendeesFocusNode.requestFocus(),
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
                              _attendeesFocusNode.requestFocus();
                              //TODO add attendee
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Text('Select',
                                        style: Theme.of(context).textTheme.subtitle1),
                                  ),
                                  SizedBox(width: 8.0),
                                  Flexible(
                                    flex: 1,
                                    child: FutureBuilder<Map<String, Contact>>(
                                      future: getContacts(),
                                      builder: (context, result) {
                                        return Wrap(spacing: 8.0, children: [
                                          ...emails.map((e) {
                                            final displayName =
                                                MailUtils.displayNameFromFriendly(e);
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
                                                onTap: true
                                                    ? () {
                                                        if (_emailToShowDelete == e) {
                                                          setState(() =>
                                                              _emailToShowDelete =
                                                                  null);
                                                        } else {
                                                          setState(() =>
                                                              _emailToShowDelete = e);
                                                        }
                                                      }
                                                    : null,
                                                child: Chip(
                                                  avatar: CircleAvatar(
                                                    backgroundColor: Theme.of(context)
                                                        .primaryColor,
                                                    child: Text(
                                                      displayName[0],
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  label: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Text(displayName),
                                                      SizedBox(width: 5),
                                                      if (contact?.autoEncrypt ==
                                                          true)
                                                        Icon(Icons.lock_outline),
                                                      if (contact?.autoSign == true)
                                                        Icon(Icons.edit_outlined)
                                                    ],
                                                  ),
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
                                                focusNode: _attendeesFocusNode,
                                                controller: _emailController,
                                                autofocus: true,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                decoration: InputDecoration.collapsed(
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
                                                    // onSubmit();
                                                  }
                                                },
                                                onEditingComplete: () {
                                                  // onSubmit();
                                                },
                                              ),
                                            ),
                                          ),
                                        ]);
                                      },
                                    ),
                                  ),
                                  if (_attendeesFocusNode.hasFocus && false)
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
                      ),
                    ),
                    SizedBox(width: 8),
                    SizedBox(
                      height: 62,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (selectedUser.isNotEmpty) {
                              _attendees.add(selectedUser);
                            }
                          });
                        },
                        child: Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                // Expanded(
                //   child: ListView.builder(
                //     itemCount: _attendees.length,
                //     itemBuilder: (context, index) {
                //       return Card(
                //         color: Colors.blue[50],
                //         child: ListTile(
                //           leading: Icon(Icons.circle, color: Colors.orange),
                //           title: Text(_attendees[index]),
                //           trailing: IconButton(
                //             icon: Icon(Icons.close),
                //             onPressed: () {
                //               setState(() {
                //                 _attendees.removeAt(index);
                //               });
                //             },
                //           ),
                //         ),
                //       );
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _deleteEmail(String email) {
    setState(() => emails.remove(email));
    _composeTypeAheadFieldKey.currentState?.reopen();
    // widget.onChange();
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
      if(email == null) continue;
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
