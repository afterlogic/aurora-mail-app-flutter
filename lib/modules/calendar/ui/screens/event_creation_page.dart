import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/reminders_dialog.dart';
import 'package:aurora_mail/modules/calendar/ui/screens/attendees_page.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/calendar_tile.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/text_input.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventCreationPage extends StatefulWidget {
  static const name = "calendar_creation_page";
  const EventCreationPage({super.key});

  @override
  State<EventCreationPage> createState() => _EventCreationPageState();
}

class _EventCreationPageState extends State<EventCreationPage> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _locationController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _locationController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  // #B6B5B5

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AMAppBar(
        title: Text('New Event'),
        actions: [
          TextButton(onPressed: () {}, child: Text(S.of(context).btn_save))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                CalendarTile(
                    circleColor: Colors.indigoAccent, text: 'My calendar'),
                const SizedBox(
                  height: 20,
                ),
                TextInput(
                  controller: _titleController,
                  labelText: 'Title',
                ),
                const SizedBox(
                  height: 20,
                ),
                TextInput(
                  controller: _descriptionController,
                  labelText: 'Description',
                ),
                const SizedBox(
                  height: 20,
                ),
                TextInput(
                  controller: _locationController,
                  labelText: 'Location',
                ),
              ],
            ),
          ),
          const Divider(
            color: const Color(0xFFB6B5B5),
            height: 1,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: _Section(
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Icon(
                      Icons.access_time_rounded,
                      size: 15,
                    ),
                  ),
                  children: [
                    Row(
                      children: [
                        Text(
                          'All day',
                        ),
                        Spacer(),
                        Checkbox(
                            value: false,
                            onChanged: (value) {},
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            visualDensity:
                                VisualDensity(horizontal: -4, vertical: -4))
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    _DateTimeTile(
                      dateTime: DateTime.now(),
                    )
                  ])),
          const Divider(
            color: const Color(0xFFB6B5B5),
            height: 1,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: _Section(
                children: [
                  Row(
                    children: [
                      Text(
                        'Daily',
                      ),
                      Spacer(),
                      Text(
                        'Always',
                      ),
                    ],
                  ),
                ],
                icon: Icon(
                  Icons.sync,
                  size: 15,
                ),
              )),
          const Divider(
            color: const Color(0xFFB6B5B5),
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: _Section(
              children: [
                Row(
                  children: [
                    Text(
                      'Reminders',
                    ),
                    const Spacer(),
                    GestureDetector(
                        onTap: () => RemindersDialog.show(context,
                            initialValue: RemindersOption.min5),
                        child: const _AddIcon()),
                  ],
                ),
              ],
              icon: Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Icon(
                  Icons.notifications_none,
                  size: 15,
                ),
              ),
            ),
          ),
          const Divider(
            color: const Color(0xFFB6B5B5),
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: _Section(
              children: [
                Row(
                  children: [
                    Text(
                      'Attendees',
                    ),
                    const Spacer(),
                    GestureDetector(
                        onTap: () =>
                            Navigator.of(context).pushNamed(AttendeesPage.name),
                        child: const _AddIcon()),
                  ],
                ),
              ],
              icon: Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Icon(
                  Icons.group,
                  size: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DateTimeTile extends StatelessWidget {
  const _DateTimeTile({super.key, required this.dateTime});

  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(DateFormat('E, MMM d, y').format(dateTime)),
        Spacer(),
        Text(DateFormat.jm().format(dateTime)),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({super.key, required this.children, required this.icon});

  final List<Widget> children;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      icon,
      const SizedBox(
        width: 8,
      ),
      Expanded(
        child: Column(children: children),
      ),
    ]);
  }
}

class _AddIcon extends StatelessWidget {
  const _AddIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.add,
      color: Theme.of(context).primaryColor,
      size: 26,
    );
  }
}
