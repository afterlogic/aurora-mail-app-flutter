import 'dart:async';

import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/calendar/blocs/calendars/calendars_bloc.dart';
import 'package:aurora_mail/modules/calendar/blocs/events/events_bloc.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/calendar_select_dialog.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/daily_recurrence_select_dialog.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/recurrence_mode_select_dialog.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/weekly_recurrence_select_dialog.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/reminders_dialog.dart';
import 'package:aurora_mail/modules/calendar/ui/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/ui/models/event.dart';
import 'package:aurora_mail/modules/calendar/ui/screens/attendees_page.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/attendee_card.dart';
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
  RecurrenceMode _selectedRecurrenceMode = RecurrenceMode.never;
  DateTime? _selectedUntilDate;
  Set<RemindersOption> _selectedReminders = {};
  Set<Attendee> _attendees = {};
  EveryWeekFrequency? _selectedWeeklyFrequency;
  Set<DaysOfWeek>? _selectedWeekDaysRepeat = {DaysOfWeek.mo};
  bool _isAllDay = false;

  EventCreationData get collectCreationData => EventCreationData(
      subject: _titleController.text,
      calendarId: _selectedCalendar!.id,
      description: _descriptionController.text,
      location: _locationController.text,
      startDate: _selectedStartDate,
      reminders: _selectedReminders,
      endDate: _selectedEndDate,
      allDay: _isAllDay,
      recurrenceMode: _selectedRecurrenceMode,
      recurrenceUntilDate: _selectedUntilDate,
      recurrenceWeekDays: _selectedWeekDaysRepeat,
      recurrenceWeeklyFrequency: _selectedWeeklyFrequency,
      attendees: _attendees);

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
    _selectedCalendar = _calendarsBloc.state.calendars
        ?.firstWhereOrNull((c) => c.id == e.calendarId);
    _isAllDay = e.allDay ?? false;
    _selectedReminders = e.reminders ?? {};
    _selectedWeeklyFrequency = e.recurrenceWeeklyFrequency;
    _selectedRecurrenceMode = e.recurrenceMode ?? RecurrenceMode.never;
    _selectedUntilDate = e.recurrenceUntilDate;
    _selectedWeekDaysRepeat = e.recurrenceWeekDays ?? {};
    _attendees = Set.of(e.attendees);
    setState(() {});
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
        reminders: updatedFields.reminders,
        endDate: updatedFields.endDate,
        recurrenceMode: () => updatedFields.recurrenceMode,
        recurrenceWeeklyFrequency: () =>
            updatedFields.recurrenceWeeklyFrequency,
        recurrenceWeekDays: () => updatedFields.recurrenceWeekDays,
        recurrenceUntilDate: () => updatedFields.recurrenceUntilDate,
        attendees: _attendees);
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
                          },
                          isAllDay: _isAllDay,
                        ),
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
                            },
                            isAllDay: _isAllDay,
                          );
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
                              RecurrenceModeSelectDialog.show(context,
                                      selectedOption: _selectedRecurrenceMode)
                                  .then((value) {
                                if (value == null) return;
                                _selectedRecurrenceMode = value;
                                setState(() {});
                              });
                            },
                            child: Text(
                              _selectedRecurrenceMode.buildString(context),
                              style: TextStyle(),
                            ),
                          ),
                          Spacer(),
                          if (_selectedRecurrenceMode.isUntilOptionAvailable)
                            GestureDetector(
                              onTap: () {
                                if (_selectedRecurrenceMode ==
                                    RecurrenceMode.daily) {
                                  DailyRecurrenceSelectDialog.show(context,
                                      untilDate: _selectedUntilDate,
                                      onSaveCallback: (DateTime? untilDate) {
                                    _selectedUntilDate = untilDate;
                                    setState(() {});
                                  });
                                }
                                if (_selectedRecurrenceMode ==
                                    RecurrenceMode.weekly) {
                                  WeeklyRecurrenceSelectDialog.show(context,
                                      frequency: _selectedWeeklyFrequency,
                                      selectedDays: _selectedWeekDaysRepeat,
                                      untilDate: _selectedUntilDate,
                                      onSaveCallback: (DateTime? untilDate,
                                          EveryWeekFrequency? frequency,
                                          Set<DaysOfWeek>? selectedDays) {
                                    _selectedUntilDate = untilDate;
                                    _selectedWeeklyFrequency = frequency;
                                    _selectedWeekDaysRepeat = selectedDays;
                                    setState(() {});
                                  });
                                }
                              },
                              child: _selectedUntilDate == null
                                  ? Text(
                                      'Always',
                                    )
                                  : Text(
                                      'until ${DateFormat('yyyy/MM/dd').format(_selectedUntilDate!)}'),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: _selectedReminders.length > 1 ? 0.0 : 6.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (_selectedReminders.isEmpty)
                                Text(
                                  'Reminders',
                                ),
                              ..._selectedReminders
                                  .map((e) => Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 4.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text('${e.buildString} before'),
                                            GestureDetector(
                                              onTap: () {
                                                _selectedReminders.remove(e);
                                                setState(() {});
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4.0),
                                                child: Icon(
                                                  Icons.close,
                                                  size: 12,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ))
                                  .toList()
                            ],
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                            onTap: () {
                              RemindersDialog.show(context,
                                      selectedOptions: _selectedReminders)
                                  .then((value) {
                                if (value == null) return;
                                if (_selectedReminders.contains(value)) {
                                  _selectedReminders.remove(value);
                                } else {
                                  _selectedReminders.add(value);
                                }
                                setState(() {});
                              });
                            },
                            child: const _AddIcon()),
                      ],
                    ),
                  ],
                  icon: Padding(
                    padding: EdgeInsets.only(
                        top: _selectedReminders.length > 1 ? 0.0 : 6.0),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.group,
                          size: 15,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Attendees',
                        ),
                        const Spacer(),
                        GestureDetector(
                            onTap: () => Navigator.of(context)
                                    .pushNamed(AttendeesPage.name,
                                        arguments: AttendeesRouteArg(
                                            initAttendees: Set.of(_attendees)))
                                    .then((value) {
                                  if (value == null) return;
                                  _attendees = Set.of(value as Set<Attendee>);
                                  setState(() {});
                                }),
                            child: const _AddIcon()),
                      ],
                    ),
                    Wrap(runSpacing: 4, spacing: 4, children: [
                      ..._attendees.map(
                        (e) => LayoutBuilder(builder: (context, constraints) {
                          return ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: (constraints.maxWidth / 2) - 4,
                            ),
                            child: AttendeeCard(
                              attendee: e,
                              onDelete: () => setState(
                                () {
                                  _attendees.remove(e);
                                },
                              ),
                            ),
                          );
                        }),
                      ),
                    ]),
                  ],
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
