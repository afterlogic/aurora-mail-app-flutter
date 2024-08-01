import 'dart:async';

import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:aurora_mail/modules/calendar/blocs/calendars/calendars_bloc.dart';
import 'package:aurora_mail/modules/calendar/blocs/events/events_bloc.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/attendee.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/days_of_week.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/every_week_frequency.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/recurrence_mode.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/reminders_option.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
import 'package:aurora_mail/modules/calendar/ui/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/ui/models/event.dart';
import 'package:aurora_mail/modules/calendar/ui/screens/attendees_page.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/activity/calendar_section.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/activity/editable_attendees_section.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/activity/editable_date_info.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/activity/editable_recurrence_section.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/activity/editable_reminders_section.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/activity/main_info.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/activity/section_divider.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class EventCreationPage extends StatefulWidget {
  static const name = "event_creation_page";
  const EventCreationPage({super.key});

  @override
  State<EventCreationPage> createState() => _EventCreationPageState();
}

class _EventCreationPageState extends State<EventCreationPage> {
  late StreamSubscription<bool> _keyboardSubscription;
  late DateTime _selectedStartDate;
  late DateTime _selectedEndDate;
  late final TextEditingController _titleController;
  late final FocusNode _titleFocus;
  late final TextEditingController _descriptionController;
  late final FocusNode _descriptionFocus;
  late final TextEditingController _locationController;
  late final FocusNode _locationFocus;
  late final CalendarsBloc _calendarsBloc;
  late final EventsBloc _eventsBloc;
  late final StreamSubscription _eventsSubscription;
  late final String _currentUserMail;
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
    final _keyboardVisibilityController = KeyboardVisibilityController();
    _keyboardSubscription =
        _keyboardVisibilityController.onChange.listen((bool visible) {
      if (visible) return;
      unfocusNodes();
    });
    _calendarsBloc = BlocProvider.of<CalendarsBloc>(context);
    _eventsBloc = BlocProvider.of<EventsBloc>(context);
    _currentUserMail =
        BlocProvider.of<AuthBloc>(context).currentUser?.emailFromLogin ?? '';
    _selectedCalendar =
        _calendarsBloc.state.availableCalendars(_currentUserMail).firstOrNull;
    _titleController = TextEditingController();
    _titleFocus = FocusNode();
    _descriptionController = TextEditingController();
    _descriptionFocus = FocusNode();
    _locationController = TextEditingController();
    _locationFocus = FocusNode();
    onEventsStateChange(_eventsBloc.state);
    _eventsSubscription = _eventsBloc.stream.listen(onEventsStateChange);
  }

  @override
  void dispose() {
    _keyboardSubscription.cancel();
    _titleController.dispose();
    _titleFocus.dispose();
    _descriptionController.dispose();
    _descriptionFocus.dispose();
    _locationController.dispose();
    _locationFocus.dispose();
    _eventsSubscription.cancel();
    super.dispose();
  }

  void onEventsStateChange(EventsState state) {
    final currentDate = DateTime.now().copyWith(second: 0, millisecond: 0, microsecond: 0);
    _selectedStartDate = state.selectedDate.copyWith(hour: currentDate.hour, minute: currentDate.minute);
    _selectedEndDate = _selectedStartDate.add(Duration(minutes: 30));
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
        calendarId: updatedFields.calendarId,
        description: updatedFields.description,
        location: updatedFields.location,
        startDate: () => updatedFields.startDate,
        allDay: updatedFields.allDay,
        reminders: updatedFields.reminders,
        endDate: () => updatedFields.endDate,
        recurrenceMode: () => updatedFields.recurrenceMode,
        recurrenceWeeklyFrequency: () =>
            updatedFields.recurrenceWeeklyFrequency,
        recurrenceWeekDays: () => updatedFields.recurrenceWeekDays,
        recurrenceUntilDate: () => updatedFields.recurrenceUntilDate,
        attendees: _attendees);
    _eventsBloc.add(UpdateEvent(updatedEvent));
  }

  void unfocusNodes() {
    final focusNodes = [_titleFocus, _locationFocus, _descriptionFocus];
    for (final node in focusNodes) {
      if (node.hasFocus) {
        node.unfocus();
      }
    }
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
      body: KeyboardDismissOnTap(
        dismissOnCapturedTaps: true,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      CalendarSection(
                        calendarId: _selectedCalendar?.id,
                        isEditable: true,
                        selectedCalendar: _selectedCalendar,
                        currentUserMail: _currentUserMail,
                        selectCalendarCallback: (value) {
                          _selectedCalendar = value;
                          setState(() {});
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MainInfo(
                        descriptionController: _descriptionController,
                        locationController: _locationController,
                        titleController: _titleController,
                        descriptionFocus: _descriptionFocus,
                        titleFocus: _titleFocus,
                        locationFocus: _locationFocus,
                        isEditable: true,
                      ),
                    ],
                  ),
                ),
                const SectionDivider(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: EditableDateInfo(
                    isAllDay: _isAllDay,
                    selectedStartDate: _selectedStartDate,
                    selectedEndDate: _selectedEndDate,
                    isAllDayChangedCallback: (value) {
                      _isAllDay = value;
                      setState(() {});
                    },
                    selectedStartDateChangedCallback: (value) {
                      _selectedStartDate = value;
                      if (_selectedStartDate.isAfter(_selectedEndDate)) {
                        _selectedEndDate =
                            _selectedStartDate.add(Duration(minutes: 30));
                      }
                      setState(() {});
                    },
                    selectedEndDateChangedCallback: (value) {
                      _selectedEndDate = value;
                      if (_selectedStartDate.isAfter(_selectedEndDate)) {
                        _selectedStartDate =
                            _selectedEndDate.subtract(Duration(minutes: 30));
                      }
                      setState(() {});
                    },
                    scaffoldKey: _scaffoldKey,
                  ),
                ),
                const SectionDivider(),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 24),
                    child: EditableRecurrenceSection(
                      selectedUntilDate: _selectedUntilDate,
                      selectedWeekDaysRepeat: _selectedWeekDaysRepeat,
                      recurrencySaveCallback: (DateTime? untilDate,
                          EveryWeekFrequency? frequency,
                          Set<DaysOfWeek>? selectedDays) {
                        _selectedUntilDate = untilDate;
                        _selectedWeeklyFrequency = frequency;
                        _selectedWeekDaysRepeat = selectedDays;
                        setState(() {});
                      },
                      selectedDateSaveCallback: (DateTime? untilDate) {
                        _selectedUntilDate = untilDate;
                        setState(() {});
                      },
                      selectedRecurrenceMode: _selectedRecurrenceMode,
                      selectedRecurrenceModeCallback: (RecurrenceMode mode) {
                        _selectedRecurrenceMode = mode;
                        setState(() {});
                      },
                      selectedWeeklyFrequency: _selectedWeeklyFrequency,
                    )),
                const SectionDivider(),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    child: EditableRemindersSection(
                      onAddCallback: (RemindersOption option) {
                        if (_selectedReminders.contains(option)) {
                          _selectedReminders.remove(option);
                        } else {
                          _selectedReminders.add(option);
                        }
                        setState(() {});
                      },
                      onDeleteCallback: (RemindersOption option) {
                        _selectedReminders.remove(option);
                        setState(() {});
                      },
                      selectedReminders: _selectedReminders,
                    )),
                const SectionDivider(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: EditableAttendeesSection(
                    attendees: _attendees,
                    onAddPressed: () {
                      Navigator.of(context)
                          .pushNamed(AttendeesPage.name,
                              arguments: AttendeesRouteArg(
                                  initAttendees: Set.of(_attendees)))
                          .then((value) {
                        if (value == null) return;
                        _attendees = Set.of(value as Set<Attendee>);
                        setState(() {});
                      });
                    },
                    onDeletedCallback: (Attendee attendee) {
                      _attendees.remove(attendee);
                      setState(() {});
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
}
