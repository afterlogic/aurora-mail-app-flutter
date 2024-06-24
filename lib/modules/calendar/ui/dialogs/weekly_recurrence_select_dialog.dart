import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/base_calendar_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum EveryWeekFrequency {
  every1,
  every2,
  every3,
  every4,
}

extension EveryWeekFrequencyX on EveryWeekFrequency {
  String buildString() {
    switch (this) {
      case EveryWeekFrequency.every1:
        return '1';
      case EveryWeekFrequency.every2:
        return '2';
      case EveryWeekFrequency.every3:
        return '3';
      case EveryWeekFrequency.every4:
        return '4';
    }
  }
}

enum DaysOfWeek { su, mo, tu, we, th, fr, sa }

extension DaysOfWeekX on DaysOfWeek {
  String buildString() {
    switch (this) {
      case DaysOfWeek.su:
        return 'Su';
      case DaysOfWeek.mo:
        return 'Mo';
      case DaysOfWeek.tu:
        return 'Tu';
      case DaysOfWeek.we:
        return 'We';
      case DaysOfWeek.th:
        return 'Th';
      case DaysOfWeek.fr:
        return 'Fr';
      case DaysOfWeek.sa:
        return 'Sa';
    }
  }
}

class WeeklyRecurrenceSelectDialog extends StatefulWidget {
  const WeeklyRecurrenceSelectDialog(
      {required this.frequency,
      required this.selectedDays,
      required this.untilDate,
      required this.onSaveCallback});

  final EveryWeekFrequency? frequency;
  final Set<DaysOfWeek>? selectedDays;
  final DateTime? untilDate;
  final void Function(DateTime? untilDate, EveryWeekFrequency? frequency,
      Set<DaysOfWeek>? selectedDays) onSaveCallback;

  static Future<RecurrenceData?> show(BuildContext context,
      {required EveryWeekFrequency? frequency,
      required Set<DaysOfWeek>? selectedDays,
      required DateTime? untilDate,
      required void Function(DateTime? untilDate, EveryWeekFrequency? frequency,
              Set<DaysOfWeek>? selectedDays)
          onSaveCallback}) {
    return showDialog<RecurrenceData?>(
        context: context,
        builder: (_) => WeeklyRecurrenceSelectDialog(
              frequency: frequency,
              selectedDays: selectedDays,
              untilDate: untilDate,
              onSaveCallback: onSaveCallback,
            )).then((value) => value);
  }

  @override
  State<WeeklyRecurrenceSelectDialog> createState() =>
      _WeeklyRecurrenceSelectDialogState();
}

class _WeeklyRecurrenceSelectDialogState
    extends State<WeeklyRecurrenceSelectDialog> {
  late EveryWeekFrequency frequency;
  bool isAlways = true;
  DateTime? untilDate;

  late final Set<DaysOfWeek> selectedDays;

  @override
  void initState() {
    super.initState();
    selectedDays = widget.selectedDays ?? {DaysOfWeek.mo};
    frequency = widget.frequency ?? EveryWeekFrequency.every1;
    untilDate = widget.untilDate;
  }

  @override
  Widget build(BuildContext context) {
    return BaseCalendarDialog(
      title: 'Weekly',
      actions: [
        TextButton(
          onPressed: () {
            if (!isAlways && untilDate == null) return;
            final resultDate = isAlways ? null : untilDate;
            widget.onSaveCallback(resultDate, frequency, selectedDays);
            Navigator.of(context).pop();
          },
          child: Text(S.of(context).btn_save),
        ),
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: DaysOfWeek.values.map((day) {
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (selectedDays.contains(day)) {
                      if (selectedDays.length > 1) {
                        selectedDays.remove(day);
                      }
                    } else {
                      selectedDays.add(day);
                    }

                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                    decoration: BoxDecoration(
                      color: selectedDays.contains(day)
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                      border: Border.all(
                        color: selectedDays.contains(day)
                            ? Theme.of(context).primaryColor
                            : Color(0xFFDFDFDF),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        day.buildString(),
                        style: TextStyle(
                          color: selectedDays.contains(day)
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text('Every'),
              SizedBox(width: 8),
              Expanded(
                child: InputDecorator(
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      contentPadding: EdgeInsets.zero.copyWith(left: 8)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<EveryWeekFrequency>(
                      value: frequency,
                      items: EveryWeekFrequency.values.map((value) {
                        return DropdownMenuItem<EveryWeekFrequency>(
                          value: value,
                          child: Text(value.buildString()),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          frequency = newValue!;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Radio(
                value: true,
                visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                groupValue: isAlways,
                onChanged: (bool? value) {
                  setState(() {
                    isAlways = value!;
                  });
                },
              ),
              Text('Always'),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Radio(
                value: false,
                visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                groupValue: isAlways,
                onChanged: (bool? value) {
                  setState(() {
                    isAlways = value!;
                  });
                },
              ),
              Text('Until'),
              SizedBox(width: 8),
              if (!isAlways)
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null) {
                        setState(() {
                          untilDate = picked;
                        });
                      }
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        decoration: InputDecoration(
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Icon(
                              Icons.calendar_today_outlined,
                              size: 16,
                            ),
                          ),
                          border: const OutlineInputBorder(gapPadding: 0),
                          contentPadding: EdgeInsets.zero.copyWith(left: 8),
                          errorText: untilDate == null && !isAlways
                              ? 'Select date'
                              : null,
                          hintText: untilDate == null
                              ? null
                              : '${DateFormat('yyyy/MM/dd').format(untilDate!)}',
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class RecurrenceData {}
