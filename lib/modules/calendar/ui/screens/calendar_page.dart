import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/calendar/blocs/calendars/calendars_bloc.dart';
import 'package:aurora_mail/modules/calendar/blocs/events/events_bloc.dart';
import 'package:aurora_mail/modules/calendar/blocs/notification/calendar_notification_bloc.dart';
import 'package:aurora_mail/modules/calendar/blocs/tasks/tasks_bloc.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/activity.dart';
import 'package:aurora_mail/modules/calendar/ui/models/event.dart';
import 'package:aurora_mail/modules/calendar/ui/models/task.dart';
import 'package:aurora_mail/modules/calendar/ui/screens/event_creation_page.dart';
import 'package:aurora_mail/modules/calendar/ui/screens/event_view_page.dart';
import 'package:aurora_mail/modules/calendar/ui/screens/task_creation_page.dart';
import 'package:aurora_mail/modules/calendar/ui/screens/task_view_page.dart';
import 'package:aurora_mail/modules/calendar/ui/views/day_view.dart';
import 'package:aurora_mail/modules/calendar/ui/views/month_view.dart';
import 'package:aurora_mail/modules/calendar/ui/views/tasks_view.dart';
import 'package:aurora_mail/modules/calendar/ui/views/week_view.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/calendar_drawer.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/calendar_tab.dart';
import 'package:aurora_mail/shared_ui/app_bar_icons.dart';
import 'package:aurora_mail/shared_ui/mail_bottom_app_bar.dart';
import 'package:aurora_mail/utils/extensions/bloc_provider_extensions.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:theme/app_color.dart';
import 'package:theme/app_theme.dart';

class CalendarPageArg {
  final String selectedCalendarId;
  final String selectedActivityId;
  final ActivityType type;
  CalendarPageArg(
      {required this.selectedCalendarId,
      required this.selectedActivityId,
      required this.type});
}

class CalendarPage extends StatefulWidget {
  static String? selectedCalendarId = null;
  static String? selectedActivityId = null;
  static ActivityType? activityType = null;
  final CalendarPageArg? args;
  const CalendarPage({super.key, this.args});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late final TabController _tabController;
  late final CalendarsBloc _calendarsBloc;
  bool _overlay = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _overlay = false;
    _calendarsBloc = BlocProvider.of<CalendarsBloc>(context);
    _tabController = TabController(
        length: 4,
        vsync: this,
        initialIndex: _calendarsBloc.state.selectedTabIndex ?? 0);
    BlocProvider.of<CalendarsBloc>(context).add(GetCalendars());
    if (widget.args != null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        BlocProvider.of<CalendarNotificationBloc>(context).add(
            StartSyncFromNotification(
                activityType: widget.args!.type,
                calendarId: widget.args!.selectedCalendarId,
                activityId: widget.args!.selectedActivityId));
        switch (widget.args!.type) {
          case ActivityType.event:
            Navigator.of(context).pushNamed(EventViewPage.name);
            break;
          case ActivityType.task:
            Navigator.of(context).pushNamed(TaskViewPage.name);
            break;
        }
      });
    } else if (CalendarPage.selectedCalendarId != null &&
        CalendarPage.activityType != null &&
        CalendarPage.selectedActivityId != null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        BlocProvider.of<CalendarNotificationBloc>(context).add(
            StartSyncFromNotification(
                activityType: CalendarPage.activityType!,
                calendarId: CalendarPage.selectedCalendarId!,
                activityId: CalendarPage.selectedActivityId!));
        switch (CalendarPage.activityType!) {
          case ActivityType.event:
            Navigator.of(context).pushNamed(EventViewPage.name);
            break;
          case ActivityType.task:
            Navigator.of(context).pushNamed(TaskViewPage.name);
            break;
        }
      });
    } else {
      BlocProvider.of<EventsBloc>(context).add(const StartSync());
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      BlocProviderExtensions.tryOf<EventsBloc>(context)?.add(const StartSync());
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    _overlay = false;
    _calendarsBloc.add(SaveTabIndex(_tabController.index));
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: GlobalKey<ScaffoldState>(),
      drawer: CalendarDrawer(),
      appBar: AMAppBar(
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) => IconButton(
            icon: AppBarIcons.burger(context: context),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text(S.of(context).calendar),
        backgroundColor: AppColor.appBarBackground,
        shadow: BoxShadow(color: Colors.transparent),
      ),
      body: Column(
        children: [
          if (BuildProperty.useAppBarDivider)
            Container(
              height: 1,
              color: AppColor.appBarDivider,
            ),
          Expanded(
            child: Stack(
              children: [
                _BlocErrorsHandler(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 18.0, right: 24, left: 24),
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
                                    title: 'Tasks',
                                    controller: _tabController,
                                    index: 3),
                                const SizedBox(
                                  width: 16,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                                controller: _tabController,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  const MonthView(),
                                  const WeekView(),
                                  const DayView(),
                                  const TasksView(),
                                ]),
                          )
                        ],
                      ),
                      Positioned(
                        top: 25,
                        left: 0,
                        right: 0,
                        child: BlocBuilder<EventsBloc, EventsState>(
                          buildWhen: (previous, current) =>
                              previous.status != current.status,
                          builder: (context, state) {
                            return state.status.isLoading
                                ? IgnorePointer(
                                    child: Center(
                                      child: RefreshProgressIndicator(
                                        backgroundColor: Colors.white,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                if (_overlay)
                  Positioned.fill(
                    child: GestureDetector(
                        onTap: () {
                          _overlay = false;
                          setState(() {});
                        },
                        child: Container(
                          color: BuildProperty
                                  .disableScreenShadowFloatingActionButton
                              ? Colors.black.withOpacity(0.2)
                              : Colors.transparent,
                        )),
                  ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _overlay
          ? Stack(
              children: [
                // Overlay buttons (positioned above main button)
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Create Event button with label (first - more commonly used)
                    if (BuildProperty.usePlusIconForActionButtons) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              BlocProvider.of<EventsBloc>(context)
                                  .add(SelectEvent(null));
                              _overlay = false;
                              setState(() {});
                              Navigator.of(context).pushNamed(
                                EventCreationPage.name,
                              );
                            },
                            child: BuildProperty.useCustomInputStyles
                                ? Container(
                                    padding: const EdgeInsets.only(
                                      top: 12,
                                      left: 16,
                                      right: 24,
                                      bottom: 12,
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      shadows: [
                                        BoxShadow(
                                          color: Color(0x19000000),
                                          blurRadius: 16,
                                          offset: Offset(0, 8),
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        _buildCalendarIcon(
                                            'event', Icons.event),
                                        SizedBox(width: 8),
                                        Text(
                                          'Create event',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: const Color(0xFF031743),
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            height: 1.35,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.8),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          'Create event',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      AMFloatingActionButton(
                                        backgroundColor: Colors.white,
                                        child: IconTheme(
                                          data: AppTheme.floatIconTheme,
                                          child: Icon(Icons.event,
                                              size: 32, color: Colors.black),
                                        ),
                                        shadow: BuildProperty
                                                .disableShadowFloatingActionButton
                                            ? null
                                            : BoxShadow(),
                                        onPressed: () {
                                          BlocProvider.of<EventsBloc>(context)
                                              .add(SelectEvent(null));
                                          _overlay = false;
                                          setState(() {});
                                          Navigator.of(context).pushNamed(
                                            EventCreationPage.name,
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Create Task button with label
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              BlocProvider.of<TasksBloc>(context)
                                  .add(SelectTask(null));
                              _overlay = false;
                              setState(() {});
                              Navigator.of(context).pushNamed(
                                TaskCreationPage.name,
                              );
                            },
                            child: BuildProperty.useCustomInputStyles
                                ? Container(
                                    padding: const EdgeInsets.only(
                                      top: 12,
                                      left: 16,
                                      right: 24,
                                      bottom: 12,
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      shadows: [
                                        BoxShadow(
                                          color: Color(0x19000000),
                                          blurRadius: 16,
                                          offset: Offset(0, 8),
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        _buildCalendarIcon(
                                            'task', Icons.add_task),
                                        SizedBox(width: 8),
                                        Text(
                                          'Create task',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: const Color(0xFF031743),
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            height: 1.35,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.8),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          'Create task',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      AMFloatingActionButton(
                                        heroTag: 'task',
                                        backgroundColor: Colors.white,
                                        child: IconTheme(
                                          data: AppTheme.floatIconTheme,
                                          child: Icon(Icons.add_task,
                                              color: Colors.black),
                                        ),
                                        shadow: BuildProperty
                                                .disableShadowFloatingActionButton
                                            ? null
                                            : BoxShadow(),
                                        onPressed: () {
                                          BlocProvider.of<TasksBloc>(context)
                                              .add(SelectTask(null));
                                          _overlay = false;
                                          setState(() {});
                                          Navigator.of(context).pushNamed(
                                            TaskCreationPage.name,
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                          ),
                        ],
                      ),
                      // Space for the main button
                      const SizedBox(height: 72), // Height of FAB + some margin
                    ] else ...[
                      // Original layout for other builds - single event button
                      AMFloatingActionButton(
                        child: IconTheme(
                          data: AppTheme.floatIconTheme,
                          child: Icon(Icons.event, size: 32),
                        ),
                        shadow: BuildProperty.disableShadowFloatingActionButton
                            ? null
                            : BoxShadow(),
                        onPressed: () {
                          BlocProvider.of<EventsBloc>(context)
                              .add(SelectEvent(null));
                          _overlay = false;
                          setState(() {});
                          Navigator.of(context).pushNamed(
                            EventCreationPage.name,
                          );
                        },
                      ),
                      // Space for the main button
                      const SizedBox(height: 72), // Height of FAB + some margin
                    ],
                  ],
                ),
                // Main close button (positioned at the bottom right)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: AMFloatingActionButton(
                    child: IconTheme(
                      data: AppTheme.floatIconTheme,
                      child: Icon(Icons.close),
                    ),
                    shadow: BuildProperty.disableShadowFloatingActionButton
                        ? null
                        : BoxShadow(),
                    onPressed: () {
                      _overlay = false;
                      setState(() {});
                    },
                  ),
                ),
              ],
            )
          : AMFloatingActionButton(
              child: IconTheme(
                data: AppTheme.floatIconTheme,
                child: Icon(BuildProperty.usePlusIconForActionButtons
                    ? Icons.add
                    : MdiIcons.plus),
              ),
              shadow: BuildProperty.disableShadowFloatingActionButton
                  ? null
                  : BoxShadow(),
              onPressed: () {
                _overlay = true;
                setState(() {});
              },
            ),
      bottomNavigationBar:
          MailBottomAppBar(selectedRoute: MailBottomAppBarRoutes.calendar),
    );
  }

  Widget _buildCalendarIcon(String iconName, IconData fallbackIcon) {
    if (BuildProperty.useCustomInputStyles) {
      final iconPath = '${BuildProperty.image_dir}/calendar/$iconName.svg';
      return SvgPicture.asset(
        iconPath,
        width: 28,
        height: 28,
        placeholderBuilder: (context) => Icon(
          fallbackIcon,
          size: 28,
          color: const Color(0xFF031743),
        ),
      );
    }
    return Icon(
      fallbackIcon,
      size: 28,
      color: const Color(0xFF031743),
    );
  }
}

class _BlocErrorsHandler extends StatelessWidget {
  const _BlocErrorsHandler({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(listeners: [
      BlocListener<TasksBloc, TasksState>(
          listenWhen: (previous, current) =>
              previous.error != current.error &&
              current.error != null &&
              current.status.isError,
          listener: (context, state) {
            showErrorSnack(
              context: context,
              scaffoldState: Scaffold.of(context),
              msg: state.error,
            );
          }),
      BlocListener<CalendarNotificationBloc, CalendarNotificationState>(
          listenWhen: (previous, current) => previous != current,
          listener: (context, state) {
            if (state.error != null) {
              showErrorSnack(
                context: context,
                scaffoldState: Scaffold.of(context),
                msg: state.error,
              );
            }
            if (state.activityFromNotification != null &&
                state.activityType != null) {
              switch (state.activityType!) {
                case ActivityType.event:
                  BlocProvider.of<EventsBloc>(context).add(
                      SelectEvent(state.activityFromNotification as ViewEvent));
                  break;
                case ActivityType.task:
                  BlocProvider.of<TasksBloc>(context).add(
                      SelectTask(state.activityFromNotification as ViewTask));
                  break;
              }
            }
          }),
      BlocListener<EventsBloc, EventsState>(
          listenWhen: (previous, current) =>
              previous.error != current.error &&
              current.error != null &&
              current.status.isError,
          listener: (context, state) {
            showErrorSnack(
              context: context,
              scaffoldState: Scaffold.of(context),
              msg: state.error,
            );
          }),
      BlocListener<CalendarsBloc, CalendarsState>(
          listenWhen: (previous, current) =>
              previous.error != current.error &&
              current.error != null &&
              current.status.isError,
          listener: (context, state) {
            showErrorSnack(
              context: context,
              scaffoldState: Scaffold.of(context),
              msg: state.error,
            );
          }),
    ], child: child);
  }
}
