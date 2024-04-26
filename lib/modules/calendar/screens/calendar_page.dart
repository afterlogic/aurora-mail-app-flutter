import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/calendar/models/event.dart';
import 'package:aurora_mail/modules/calendar/widgets/calendar_drawer.dart';
import 'package:aurora_mail/modules/calendar/widgets/calendar_tab.dart';
import 'package:aurora_mail/modules/calendar/widgets/event_card.dart';
import 'package:aurora_mail/modules/calendar/widgets/month_event_marker.dart';
import 'package:aurora_mail/modules/calendar/widgets/short_month_day.dart';
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
  late final TabController _tabController;
  bool _showTabs = false;

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
        IntTween(begin: 140, end: 50).animate(_calendarAnimationController);
    _calendarAnimation.addListener(() {
      print(_calendarAnimationController.value);

      setState(() {});
    });
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(
        kEvents.entries.map((e) => e.value).expand((e) => e).toList());

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  final kEvents = <DateTime, List<CalendarEvent>>{}..addAll({
      DateTime.utc(kToday.year, kToday.month, kToday.day - 1): [
        Event(
            title: 'test2',
            startDate: DateTime.utc(kToday.year, kToday.month, kToday.day - 1),
            endDate: DateTime.utc(kToday.year, kToday.month, kToday.day - 1),
            id: 2,
            edge: Edge.start),
        Event(
            title: 'test4',
            startDate: DateTime.utc(kToday.year, kToday.month, kToday.day - 1),
            endDate: DateTime.utc(kToday.year, kToday.month, kToday.day - 1),
            id: 1,
            edge: Edge.start),
        const EmptyEvent(),
      ],
      DateTime.utc(kToday.year, kToday.month, kToday.day): [
        Event(
            title: 'test2',
            startDate: DateTime.utc(kToday.year, kToday.month, kToday.day - 1),
            endDate: DateTime.utc(kToday.year, kToday.month, kToday.day - 1),
            id: 2,
            edge: Edge.part),
        Event(
            title: 'test4',
            startDate: DateTime.utc(kToday.year, kToday.month, kToday.day - 1),
            endDate: DateTime.utc(kToday.year, kToday.month, kToday.day - 1),
            id: 1,
            edge: Edge.end),
        const EmptyEvent(),
      ],
      DateTime.utc(kToday.year, kToday.month, kToday.day + 1): [
        Event(
            title: 'test2',
            startDate: DateTime.utc(kToday.year, kToday.month, kToday.day - 1),
            endDate: DateTime.utc(kToday.year, kToday.month, kToday.day - 1),
            id: 2,
            edge: Edge.end),
        const EmptyEvent(),
        Event(
            title: 'test3',
            startDate: DateTime.utc(kToday.year, kToday.month, kToday.day - 1),
            endDate: DateTime.utc(kToday.year, kToday.month, kToday.day - 1),
            id: 3,
            edge: Edge.single),
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

  Widget _disabledDayBuilder(
      BuildContext context, DateTime currentDate, DateTime selectedDate) {
    return ShortMonthDay(
      height: _calendarDayTitleHeight,
      dayNumber: currentDate.day.toString(),
      hasEvents: false,
      boxColor: Colors.transparent,
      eventsMarkerColor: Theme.of(context).primaryColor.withOpacity(0.5),
      dayNumberColor: Colors.grey.shade300,
    );
  }

  Widget _outsideDayBuilder(
      BuildContext context, DateTime currentDate, DateTime selectedDate) {
    final bool containsEvents = kEvents[currentDate]?.isNotEmpty ?? false;

    return ShortMonthDay(
      height: _calendarDayTitleHeight,
      dayNumber: currentDate.day.toString(),
      hasEvents:
          _eventListAnimationController.value == 1.0 ? false : containsEvents,
      boxColor: Colors.transparent,
      eventsMarkerColor: Theme.of(context).primaryColor.withOpacity(0.5),
      dayNumberColor: Colors.grey,
    );
  }

  Widget _defaultDayBuilder(
      BuildContext context, DateTime currentDate, DateTime selectedDate) {
    final bool containsEvents = kEvents[currentDate]?.isNotEmpty ?? false;

    return ShortMonthDay(
      height: _calendarDayTitleHeight,
      dayNumber: currentDate.day.toString(),
      hasEvents:
          _eventListAnimationController.value == 1.0 ? false : containsEvents,
      boxColor: Colors.transparent,
      eventsMarkerColor: Theme.of(context).primaryColor,
      dayNumberColor: Colors.black,
    );
  }

  Widget _selectedDayBuilder(
      BuildContext context, DateTime currentDate, DateTime selectedDate) {
    final bool containsEvents = kEvents[currentDate]?.isNotEmpty ?? false;

    return ShortMonthDay(
      height: _calendarDayTitleHeight,
      dayNumber: currentDate.day.toString(),
      hasEvents:
          _eventListAnimationController.value == 1.0 ? false : containsEvents,
      boxColor: Color.fromARGB(255, 209, 230, 253),
      eventsMarkerColor: Theme.of(context).primaryColor,
      dayNumberColor: Theme.of(context).primaryColor,
    );
  }

  Widget _todayDayBuilder(
      BuildContext context, DateTime currentDate, DateTime selectedDate) {
    final bool containsEvents = kEvents[currentDate]?.isNotEmpty ?? false;

    return ShortMonthDay(
      height: _calendarDayTitleHeight,
      dayNumber: currentDate.day.toString(),
      hasEvents:
          _eventListAnimationController.value == 1.0 ? false : containsEvents,
      boxColor: Color.fromARGB(255, 240, 150, 80),
      eventsMarkerColor: Colors.white,
      dayNumberColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CalendarDrawer(),
      appBar: AMAppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(S.of(context).calendar),
            IconButton(
                onPressed: () => setState(() {
                      _showTabs = !_showTabs;
                    }),
                icon: Icon(Icons.grid_view_outlined))
          ],
        ),
      ),
      body: Column(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 100),
            child: _showTabs
                ? Padding(
                    padding:
                        const EdgeInsets.only(top: 18.0, right: 24, left: 24),
                    child: Row(
                      children: [
                        CalendarTab(
                            title: 'Month',
                            controller: _tabController,
                            index: 0),
                        const SizedBox(
                          width: 16,
                        ),
                        CalendarTab(
                            title: 'Week',
                            controller: _tabController,
                            index: 1),
                      ],
                    ),
                  )
                : SizedBox.shrink(),
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              Column(
                children: [
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
                                _calendarAnimationController
                                    .reverse()
                                    .then((_) {
                                  _calendarFormat = CalendarFormat.month;
                                  setState(() {});
                                });
                              }
                              if (details.delta.dy < -1 &&
                                  _calendarAnimationController.value == 0.0 &&
                                  _eventListAnimationController.value == 0.0) {
                                _calendarAnimationController
                                    .forward()
                                    .then((_) {
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
                              formatAnimationDuration:
                                  const Duration(milliseconds: 200),
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
                              availableGestures:
                                  AvailableGestures.horizontalSwipe,
                              headerStyle: HeaderStyle(
                                formatButtonVisible: false,
                                titleCentered: true,
                                titleTextStyle: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 20),
                                leftChevronIcon: Icon(
                                  Icons.chevron_left,
                                  size: 30,
                                ),
                                rightChevronIcon: Icon(
                                  Icons.chevron_right,
                                  size: 30,
                                ),
                              ),
                              daysOfWeekStyle: DaysOfWeekStyle(
                                  weekdayStyle: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                  weekendStyle: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700)),
                              calendarBuilders: CalendarBuilders(
                                defaultBuilder: _defaultDayBuilder,
                                todayBuilder: _todayDayBuilder,
                                selectedBuilder: _selectedDayBuilder,
                                outsideBuilder: _outsideDayBuilder,
                                disabledBuilder: _disabledDayBuilder,
                                markerBuilder:
                                    _eventListAnimationController.value == 1.0
                                        ? _extendedModeBuilder
                                        : (_, __, ___) => SizedBox.shrink(),
                              ),
                              startingDayOfWeek: StartingDayOfWeek.monday,
                              calendarStyle: const CalendarStyle(),
                              onDaySelected: _onDaySelected,
                              onRangeSelected: _onRangeSelected,
                              daysOfWeekHeight: 40,
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
                                  child: Icon(
                                    Icons.arrow_back_ios_outlined,
                                    color: Color.fromRGBO(217, 217, 217, 1),
                                    size: 18,
                                  ),
                                )
                              : const Icon(
                                  Icons.minimize_outlined,
                                  color: Color.fromRGBO(217, 217, 217, 1),
                                ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: _eventListAnimation.value as int,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 100),
                      child: _eventListAnimation.value == 0.0
                          ? const SizedBox.shrink()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  clipBehavior: Clip.hardEdge,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(246, 246, 246, 1),
                                  ),
                                  margin: EdgeInsets.only(bottom: 10),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 24.0, bottom: 24, top: 20),
                                  child: Text(
                                    'Placeholder',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color:
                                            Color.fromRGBO(150, 148, 148, 1)),
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                                Expanded(
                                  child: ValueListenableBuilder<
                                      List<CalendarEvent>>(
                                    valueListenable: _selectedEvents,
                                    builder: (context, value, _) {
                                      return  ListView.builder(
                                          
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 24.0),
                                          itemCount: value.length,
                                          itemBuilder: (context, index) {
                                            return EventCard(
                                              event: value[index],
                                            );
                                          },
                                        );

                                    },
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
              Text('Placeholder')
            ]),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar:
          MailBottomAppBar(selectedRoute: MailBottomAppBarRoutes.calendar),
    );
  }
}
