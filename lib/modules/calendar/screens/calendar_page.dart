import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/calendar/models/event.dart';
import 'package:aurora_mail/modules/calendar/widgets/month_event_marker.dart';
import 'package:aurora_mail/shared_ui/mail_bottom_app_bar.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>
    with TickerProviderStateMixin {
  late final ValueNotifier<List<CalendarEvent>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  late final AnimationController _eventListAnimationController;
  late final Animation _eventListAnimation;
  late final AnimationController _calendarAnimationController;
  late final Animation _calendarAnimation;

  final double _calendarDayTitleHeight = 36;

  @override
  void initState() {
    super.initState();
    _eventListAnimationController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _eventListAnimation =
        IntTween(begin: 100, end: 0).animate(_eventListAnimationController);
    _eventListAnimation.addListener(() => setState(() {}));
    _calendarAnimationController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _calendarAnimation =
        IntTween(begin: 140, end: 40).animate(_calendarAnimationController);
    _calendarAnimation.addListener(() {
      print(_calendarAnimationController.value);

      setState(() {});
    });
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(
        kEvents.entries.map((e) => e.value).expand((e) => e).toList());
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  final kEvents = <DateTime, List<CalendarEvent>>{}..addAll({
      DateTime.utc(kToday.year, kToday.month, kToday.day - 1): [
        const Event('test2', 2, edge: Edge.start),
        const Event('test4', 1, edge: Edge.start),
        const EmptyEvent(),
      ],
      DateTime.utc(kToday.year, kToday.month, kToday.day): [
        const Event('test2', 2, edge: Edge.part),
        const Event('test4', 1, edge: Edge.end),
        const EmptyEvent(),
      ],
      DateTime.utc(kToday.year, kToday.month, kToday.day + 1): [
        const Event('test2', 2, edge: Edge.end),
        const EmptyEvent(),
        const Event('test3', 3, edge: Edge.single),
      ]
    });

  List<CalendarEvent> _getEventsForDay(DateTime day) {
    // Implementation example

    return kEvents[day] ?? [];
  }

  List<CalendarEvent> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  Widget? _extendedModeBuilder(ctx, time, List<CalendarEvent> events) {
    // print(kEvents);
    // print(events);
    if (events.isEmpty) {
      return null;
    }
    return Padding(
      padding: EdgeInsets.only(top: _calendarDayTitleHeight),
      child: Column(
        children: events
            .map<Widget>((e) => MonthEventMarker(
                  event: e,
                ))
            .toList(),
      ),
    );
  }

  Widget _defaultDayBuilder(BuildContext context, DateTime currentDate, DateTime selectedDate){
    final bool containsEvents = kEvents[currentDate]?.isNotEmpty ?? false;

    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: _calendarDayTitleHeight,
        width: _calendarDayTitleHeight,
        child:
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Text(currentDate.day.toString(),),
              const SizedBox(height: 4,),
              if(containsEvents) Container(
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).primaryColor),
              ),
            ],
          ),
        ),),);

  }

  Widget _todayDayBuilder(BuildContext context, DateTime currentDate, DateTime selectedDate){
    final bool containsEvents = kEvents[currentDate]?.isNotEmpty ?? false;

    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: EdgeInsets.all(4.0),
        height: _calendarDayTitleHeight,
        width: _calendarDayTitleHeight,
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.5),
              borderRadius: BorderRadius.circular(4)
        ),
        child:
        Column(
          children: [
            Text(currentDate.day.toString(),),
            const SizedBox(height: 4,),
            if(containsEvents) Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Theme.of(context).primaryColor),
            ),
          ],
        ),),);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AMAppBar(
        title: Text(S.of(context).calendar),
      ),
      body: Column(
        children: [
          // Flexible(child: child)
          Expanded(
            flex: _calendarAnimation.value as int,
            child: Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    onVerticalDragUpdate: (details) {
                      // details.delta.dy > 1 - scroll up (finger from top to bottom)
                      // _animationController.value == 1.0 - ListView collapsed
                      // _calendarAnimationController.value == 1.0 - calendar shows 1 week
                      if (details.delta.dy > 1 &&
                          _calendarAnimationController.value == 1.0 &&
                          _eventListAnimationController.value == 0.0) {
                        _calendarAnimationController.reverse().then((_) {
                          _calendarFormat = CalendarFormat.month;
                          setState(() {});
                        });
                      }
                      if (details.delta.dy < -1 &&
                          _calendarAnimationController.value == 0.0 &&
                          _eventListAnimationController.value == 0.0) {
                        _calendarAnimationController.forward().then((_) {
                          _calendarFormat = CalendarFormat.week;
                          setState(() {});
                        });
                      }

                      if (details.delta.dy > 1 &&
                          _eventListAnimationController.value == 0.0 &&
                          _calendarAnimationController.value == 0.0) {
                        _eventListAnimationController.forward();
                      }
                      if (details.delta.dy < -1 &&
                          _eventListAnimationController.value == 1.0 &&
                          _calendarAnimationController.value == 0.0) {
                        _eventListAnimationController.reverse();
                      }
                    },
                    child: TableCalendar<CalendarEvent>(
                      firstDay: kFirstDay,
                      rowHeight: 10,
                      formatAnimationDuration: const Duration(seconds: 1),
                      lastDay: kLastDay,
                      shouldFillViewport: true,
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      rangeStartDay: _rangeStart,
                      rangeEndDay: _rangeEnd,
                      calendarFormat: _calendarFormat,
                      rangeSelectionMode: _rangeSelectionMode,
                      eventLoader: _getEventsForDay,
                      availableGestures: AvailableGestures.horizontalSwipe,
                      calendarBuilders: CalendarBuilders(
                        defaultBuilder: _defaultDayBuilder,
                        todayBuilder: _todayDayBuilder,
                        markerBuilder:
                            _eventListAnimationController.value == 1.0
                                ? _extendedModeBuilder
                                : (_, __, ___) => SizedBox.shrink(),
                      ),
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      calendarStyle: const CalendarStyle(),
                      onDaySelected: _onDaySelected,
                      onRangeSelected: _onRangeSelected,
                      onFormatChanged: (format) {
                        if (_calendarFormat != format) {
                          setState(() {
                            _calendarFormat = format;
                          });
                        }
                      },
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                      },
                    ),
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: _eventListAnimationController.value == 1.0
                      ? const RotatedBox(
                          quarterTurns: 1,
                          child: Icon(Icons.arrow_back_ios_outlined),
                        )
                      : const Icon(Icons.minimize_outlined),
                ),
              ],
            ),
          ),
          Expanded(
            flex: _eventListAnimation.value as int,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 100),
              child: _eventListAnimation.value == 0.0
                  ? const SizedBox.shrink()
                  : ValueListenableBuilder<List<CalendarEvent>>(
                      valueListenable: _selectedEvents,
                      builder: (context, value, _) {
                        return ListView.builder(
                          itemCount: value.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 4.0,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: ListTile(
                                onTap: () => print('${value[index]}'),
                                title: Text('${value[index]}'),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          MailBottomAppBar(selectedRoute: MailBottomAppBarRoutes.calendar),
    );
  }
}
