import 'package:aurora_mail/modules/calendar/ui/widgets/date_time_tile.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/section_with_icon.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:flutter/material.dart';

class EditableDateInfo extends StatelessWidget {
  final bool isAllDay;
  final DateTime? selectedStartDate;
  final DateTime? selectedEndDate;
  final void Function(bool value) isAllDayChangedCallback;
  final void Function(DateTime value) selectedStartDateChangedCallback;
  final void Function(DateTime value) selectedEndDateChangedCallback;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const EditableDateInfo({
    super.key,
    required this.isAllDay,
    required this.selectedEndDate,
    required this.isAllDayChangedCallback,
    required this.selectedEndDateChangedCallback,
    required this.selectedStartDateChangedCallback,
    required this.selectedStartDate,
    required this.scaffoldKey,
  });

  datesError(BuildContext context) => showErrorSnack(
        context: context,
        scaffoldState: scaffoldKey.currentState,
        msg: ErrorToShow.message('End date must be after start date'),
      );

  @override
  Widget build(BuildContext context) {
    return SectionWithIcon(
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
              const Spacer(),
              Checkbox(
                  value: isAllDay,
                  onChanged: (value) {
                    final isAllDay = value ?? false;
                    isAllDayChangedCallback(isAllDay);
                  },
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -4))
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          DateTimeTile(
            dateTime: selectedStartDate!,
            onChanged: (DateTime value) {
              if (selectedEndDate != null && selectedEndDate!.isBefore(value)) {
                datesError(context);
              } else {
                selectedStartDateChangedCallback(value);
              }
            },
            isAllDay: isAllDay,
          ),
          const SizedBox(
            height: 16,
          ),
          DateTimeTile(
            dateTime: selectedEndDate!,
            onChanged: (DateTime value) {
              if (selectedStartDate != null &&
                  value.isBefore(selectedStartDate!)) {
                datesError(context);
              } else {
                selectedEndDateChangedCallback(value);
              }
            },
            isAllDay: isAllDay,
          ),
        ]);
  }
}
