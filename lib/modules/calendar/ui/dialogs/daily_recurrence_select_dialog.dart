import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/base_calendar_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyRecurrenceSelectDialog extends StatefulWidget {
  const DailyRecurrenceSelectDialog(
      {required this.untilDate, required this.onSaveCallback});
  final DateTime? untilDate;
  final void Function(DateTime? untilDate) onSaveCallback;

  static Future<RecurrenceData?> show(BuildContext context,
      {required DateTime? untilDate,
      required void Function(DateTime? untilDate)
          onSaveCallback}) {
    return showDialog<RecurrenceData?>(
        context: context,
        builder: (_) => DailyRecurrenceSelectDialog(
              untilDate: untilDate,
              onSaveCallback: onSaveCallback,
            )).then((value) => value);
  }

  @override
  State<DailyRecurrenceSelectDialog> createState() =>
      _DailyRecurrenceSelectDialogState();
}

class _DailyRecurrenceSelectDialogState
    extends State<DailyRecurrenceSelectDialog> {
  bool isAlways = true;
  DateTime? untilDate;

  @override
  void initState() {
    isAlways = widget.untilDate == null;
    untilDate = widget.untilDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseCalendarDialog(
      title: 'Daily',
      actions: [
        TextButton(
          onPressed: () {
            if(!isAlways && untilDate == null) return;
            widget.onSaveCallback(isAlways ? null : untilDate);
            Navigator.of(context).pop();
          },
          child: Text(S.of(context).btn_save),
        ),
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
                      if (picked != null && picked != untilDate) {
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
                          errorText: untilDate == null && !isAlways ? 'Select date' : null,
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
