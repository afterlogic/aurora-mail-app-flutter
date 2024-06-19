import 'dart:async';

import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/calendar/blocs/calendars/calendars_bloc.dart';
import 'package:aurora_mail/modules/calendar/blocs/events/events_bloc.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/calendar_select_dialog.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/recurrence_select_dialog.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/reminders_dialog.dart';
import 'package:aurora_mail/modules/calendar/ui/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/ui/models/event.dart';
import 'package:aurora_mail/modules/calendar/ui/screens/attendees_page.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/calendar_tile.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/date_time_tile.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/section_with_icon.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/text_input.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EventCreationPage extends StatefulWidget {
  static const name = "event_creation_page";
  const EventCreationPage({super.key});

  @override
  State<EventCreationPage> createState() => _EventCreationPageState();
}

class _EventCreationPageState extends State<EventCreationPage> {
  late DateTime _selectedStartDate;
  late DateTime _selectedEndDate;
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _locationController;
  late final CalendarsBloc _calendarsBloc;
  late final EventsBloc _eventsBloc;
  late final StreamSubscription _eventsSubscription;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ViewCalendar? _selectedCalendar;
  ViewEvent? _selectedEvent;
  final Set<RemindersOption> _selectedReminders = {};
  bool _isAllDay = false;

  EventCreationData get collectCreationData => EventCreationData(
      subject: _titleController.text,
      calendarId: _selectedCalendar!.id,
      description: _descriptionController.text,
      location: _locationController.text,
      startDate: _selectedStartDate,
      endDate: _selectedEndDate,
      allDay: _isAllDay);

  @override
  void initState() {
    super.initState();
    _calendarsBloc = BlocProvider.of<CalendarsBloc>(context);
    _eventsBloc = BlocProvider.of<EventsBloc>(context);
    _selectedCalendar = _calendarsBloc.state.availableCalendars.firstOrNull;
    _titleController = TextEditingController();
    _selectedStartDate = DateTime.now();
    _selectedEndDate = _selectedStartDate.add(Duration(minutes: 30));
    _descriptionController = TextEditingController();
    _locationController = TextEditingController();
    onEventsStateChange(_eventsBloc.state);
    _eventsSubscription = _eventsBloc.stream.listen(onEventsStateChange);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _eventsSubscription.cancel();
    super.dispose();
  }

  void onEventsStateChange(EventsState state) {
    final e = state.selectedEvent;
    _selectedEvent = e;
    if (e == null) return;
    _titleController.text = e.title;
    _descriptionController.text = e.description ?? '';
    _locationController.text = e.location ?? '';
    _selectedStartDate = e.startDate;
    _selectedEndDate = e.endDate;
    _selectedCalendar = _calendarsBloc.state.availableCalendars
        .firstWhereOrNull((c) => c.id == e.calendarId);
    _isAllDay = e.allDay ?? false;
    setState(() {});
    // _descriptionController
  }

  void _onSaveEditedEvent() {
    final updatedFields = collectCreationData;
    final updatedEvent = _selectedEvent!.copyWith(
        subject: updatedFields.subject,
        title: updatedFields.subject,
        description: updatedFields.description,
        location: updatedFields.location,
        startDate: updatedFields.startDate,
        allDay: updatedFields.allDay,
        endDate: updatedFields.endDate);
    _eventsBloc.add(UpdateEvent(updatedEvent));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AMAppBar(
        title: Text(_selectedEvent == null ? 'Create Event' : 'Edit Event'),
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
                if (_selectedEvent == null) {
                  _eventsBloc.add(CreateEvent(collectCreationData));
                } else {
                  _onSaveEditedEvent();
                }
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
                                    options: state.availableCalendars)
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
                      multiLine: true,
                      controller: _descriptionController,
                      labelText: 'Description',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextInput(
                      multiLine: true,
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
                  child: SectionWithIcon(
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
                                value: _isAllDay,
                                onChanged: (value) {
                                  _isAllDay = value ?? false;
                                  setState(() {});
                                },
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                visualDensity:
                                    VisualDensity(horizontal: -4, vertical: -4))
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        DateTimeTile(
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
                          return DateTimeTile(
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
                  child: SectionWithIcon(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              RecurrenceSelectDialog.show(context);
                            },
                            child: Text(
                              'Daily',
                            ),
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
                child: SectionWithIcon(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Reminders',
                        ),
                        const Spacer(),
                        GestureDetector(
                            onTap: () {
                              RemindersDialog.show(context,
                                      selectedOptions: _selectedReminders)
                                  .then((value) {
                                    if(value == null) return;
                                    if(_selectedReminders.contains(value)){
                                      _selectedReminders.remove(value);
                                    }else{
                                      _selectedReminders.add(value);
                                    }
                                    setState(() {});

                              });
                            },
                            child: const _AddIcon()),
                      ],
                    ),
                    ..._selectedReminders.map((e) => Text(e.name)).toList()
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
                child: SectionWithIcon(
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
