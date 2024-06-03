import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/calendar/blocs/calendars/calendars_bloc.dart';
import 'package:aurora_mail/modules/calendar/blocs/events/events_bloc.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/calendar_select_dialog.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/reminders_dialog.dart';
import 'package:aurora_mail/modules/calendar/ui/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/ui/screens/attendees_page.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/calendar_tile.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/text_input.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  ViewCalendar? _selectedCalendar;
  late DateTime _selectedStartDate;
  late DateTime _selectedEndDate;
  late final CalendarsBloc _calendarsBloc;
  late final EventsBloc _eventsBloc;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _calendarsBloc = BlocProvider.of<CalendarsBloc>(context);
    _eventsBloc = BlocProvider.of<EventsBloc>(context);
    _selectedCalendar = _calendarsBloc.state.calendars?.firstOrNull;
    _titleController = TextEditingController();
    _selectedStartDate = DateTime.now();
    _selectedEndDate = _selectedStartDate.add(Duration(minutes: 30));
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

  EventCreationData get collectCreationData => EventCreationData(
      subject: _titleController.text,
      calendarId: _selectedCalendar!.id,
      startDate: _selectedStartDate,
      endDate: _selectedEndDate);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AMAppBar(
        title: Text('New Event'),
        actions: [
          TextButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  return;
                }
                if (_selectedCalendar == null) {
                  showErrorSnack(
                      context: context,
                      scaffoldState: _scaffoldKey.currentState,
                      msg: ErrorToShow.message('Please select calendar'));
                  return;
                }
                _eventsBloc.add(CreateEvent(collectCreationData));
                Navigator.of(context).pop();
              },
              child: Text(S.of(context).btn_save))
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    BlocBuilder<CalendarsBloc, CalendarsState>(
                      bloc: _calendarsBloc,
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            CalendarSelectDialog.show(context,
                                    initialValue: _selectedCalendar,
                                    options: state.calendars ?? [])
                                .then((value) {
                              if (value != null) _selectedCalendar = value;
                              setState(() {});
                            });
                          },
                          child: (_selectedCalendar != null)
                              ? CalendarTile(
                                  circleColor: _selectedCalendar!.color,
                                  text: _selectedCalendar!.name)
                              : TextButton(
                                  onPressed: null,
                                  child: Text('Select calendar')),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextInput(
                      controller: _titleController,
                      labelText: 'Title',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter text';
                        }
                        return null;
                      },
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
                            dateTime: _selectedStartDate,
                            onChanged: (DateTime value) {
                              setState(() {
                                _selectedStartDate = value;
                              });
                            }),
                        const SizedBox(
                          height: 16,
                        ),
                        Builder(builder: (context) {
                          return _DateTimeTile(
                              dateTime: _selectedEndDate,
                              onChanged: (DateTime value) {
                                if (value.isBefore(_selectedStartDate)) {
                                  showErrorSnack(
                                    context: context,
                                    scaffoldState: _scaffoldKey.currentState,
                                    msg: ErrorToShow.message(
                                        'End date must be after start date'),
                                  );
                                } else {
                                  setState(() {
                                    _selectedEndDate = value;
                                  });
                                }
                              });
                        })
                      ])),
              const Divider(
                color: const Color(0xFFB6B5B5),
                height: 1,
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: _Section(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Attendees',
                        ),
                        const Spacer(),
                        GestureDetector(
                            onTap: () => Navigator.of(context)
                                .pushNamed(AttendeesPage.name),
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
        ),
      ),
    );
  }
}

class _DateTimeTile extends StatelessWidget {
  const _DateTimeTile(
      {super.key, required this.dateTime, required this.onChanged});

  final Function(DateTime) onChanged;
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDatePicker(
                context: context,
                initialDate: dateTime,
                firstDate: DateTime(1980),
                lastDate: DateTime(2040))
            .then((value) {
          if (value != null) {
            final DateTime result = dateTime.copyWith(
                year: value.year, month: value.month, day: value.day);
            showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(dateTime))
                .then((value) {
              if (value != null) {
                onChanged(
                    result.copyWith(hour: value.hour, minute: value.minute));
              } else {
                onChanged(result);
              }
            });
          }
        });
      },
      child: Row(
        children: [
          Text(DateFormat('E, MMM d, y').format(dateTime)),
          Spacer(),
          Text(DateFormat.jm().format(dateTime)),
        ],
      ),
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
