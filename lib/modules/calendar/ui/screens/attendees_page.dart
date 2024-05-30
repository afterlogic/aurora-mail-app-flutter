import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/reminders_dialog.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/calendar_tile.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/text_input.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendeesPage extends StatefulWidget {
  static const name = "attendees_page";
  const AttendeesPage({super.key});

  @override
  State<AttendeesPage> createState() => _AttendeesPageState();
}

class _AttendeesPageState extends State<AttendeesPage> {
  final TextEditingController _emailController = TextEditingController();
  final List<String> _attendees = [
    '"John" <user2@domain.com>',
    '"Bill" <user3@domain.com>',
    '"Simpson" <user4@domain.com>',
    'user5@domain.com',
  ];

  String organizer = 'user@domain.com';
  String selectedUser = 'user1@domain.com';

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AMAppBar(
        title: Text('Add attendee'),
        actions: [
          TextButton(onPressed: () {}, child: Text(S.of(context).btn_save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Organizer: $organizer', style: TextStyle(color: Colors.grey)),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedUser,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedUser = newValue!;
                      });
                    },
                    items: <String>[
                      'user1@domain.com',
                      'user2@domain.com',
                      'user3@domain.com'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
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
            Expanded(
              child: ListView.builder(
                itemCount: _attendees.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.blue[50],
                    child: ListTile(
                      leading: Icon(Icons.circle, color: Colors.orange),
                      title: Text(_attendees[index]),
                      trailing: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            _attendees.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

