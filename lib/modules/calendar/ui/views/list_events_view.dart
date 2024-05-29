import 'package:aurora_mail/modules/calendar/blocs/events/events_bloc.dart';
import 'package:aurora_mail/modules/calendar/ui/models/event.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/event_card.dart';
import 'package:aurora_mail/modules/calendar/utils/date_time_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ListEventsView extends StatelessWidget {
  const ListEventsView({super.key});

  void _selectMonth(
      {required DateTime currentDate,
      required BuildContext context,
      required bool isNext}) {
    final newMonth = isNext
        ? currentDate.firstDayOfNextMonth
        : currentDate.firstDayOfPreviousMonth;
    BlocProvider.of<EventsBloc>(context).add(SelectDate(newMonth));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsBloc, EventsState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => _selectMonth(
                        currentDate: state.startIntervalDate,
                        context: context,
                        isNext: false),
                    icon: Icon(
                      Icons.chevron_left,
                      size: 30,
                    ),
                  ),
                  Text(
                    DateFormat('yMMMM').format(state.startIntervalDate),
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  IconButton(
                    onPressed: () => _selectMonth(
                        currentDate: state.startIntervalDate,
                        context: context,
                        isNext: true),
                    icon: Icon(
                      Icons.chevron_right,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: _EventList(data: state.groupSelectedEventsByDay()))
          ],
        );
      },
    );
  }
}

class _EventList extends StatelessWidget {
  final Map<DateTime, List<ViewEvent>> data;

  const _EventList({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.entries.length,
      padding: EdgeInsets.only(bottom: 4),
      itemBuilder: (context, index) {
        final key = data.keys.toList().elementAt(index);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
              width: double.infinity,
              color: Color(0xFFF6F6F6),
              child: Text(
                '${DateFormat('d MMM, yyy').format(key)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            Column(
              children: [
                for (final event in data[key]!)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                    ).copyWith(top: 8),
                    child: EventCard(event: event),
                  ),
                const SizedBox(
                  height: 8,
                )
              ],
            )
          ],
        );
      },
    );
  }
}
