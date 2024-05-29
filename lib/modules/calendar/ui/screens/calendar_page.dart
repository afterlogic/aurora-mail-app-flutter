import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/calendar/blocs/calendars/calendars_bloc.dart';
import 'package:aurora_mail/modules/calendar/ui/screens/event_creation_page.dart';
import 'package:aurora_mail/modules/calendar/ui/views/day_view.dart';
import 'package:aurora_mail/modules/calendar/ui/views/list_events_view.dart';
import 'package:aurora_mail/modules/calendar/ui/views/month_view.dart';
import 'package:aurora_mail/modules/calendar/ui/views/week_view.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/calendar_drawer.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/calendar_tab.dart';
import 'package:aurora_mail/shared_ui/mail_bottom_app_bar.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  bool _showTabs = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    BlocProvider.of<CalendarsBloc>(context).add(GetCalendars());
  }

  @override
  void dispose() {
    super.dispose();
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
                        const SizedBox(
                          width: 16,
                        ),
                        CalendarTab(
                            title: 'Day',
                            controller: _tabController,
                            index: 2),
                        const SizedBox(
                          width: 16,
                        ),
                        CalendarTab(
                            title: 'List',
                            controller: _tabController,
                            index: 3),
                      ],
                    ),
                  )
                : SizedBox.shrink(),
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              MonthView(),
              WeekView(),
              DayView(),
              ListEventsView()
            ]),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(EventCreationPage.name);
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar:
          MailBottomAppBar(selectedRoute: MailBottomAppBarRoutes.calendar),
    );
  }
}
