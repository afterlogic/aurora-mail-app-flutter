import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/base_calendar_dialog.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/color_selection_field.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/text_input.dart';
import 'package:aurora_mail/modules/calendar/utils/calendar_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecurrenceSelectDialog extends StatefulWidget {
  const RecurrenceSelectDialog();

  static Future<RecurrenceData?> show(
      BuildContext context,
      ) {
    return showDialog<RecurrenceData?>(
        context: context,
        builder: (_) => RecurrenceSelectDialog()).then((value) => value);
  }

  @override
  State<RecurrenceSelectDialog> createState() => _RecurrenceSelectDialogState();
}

class _RecurrenceSelectDialogState extends State<RecurrenceSelectDialog> {
  int frequency = 2;
  bool isAlways = true;
  DateTime? untilDate;

  final List<String> daysOfWeek = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
  late final Set<String> selectedDays;

  @override
  void initState() {
    super.initState();
    selectedDays = {daysOfWeek.first};
  }


  @override
  Widget build(BuildContext context) {
    return BaseCalendarDialog(
      title: 'Weekly',
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(null);
          },
          child: Text(S.of(context).btn_save),
        ),
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: daysOfWeek.map((day) {
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    if(selectedDays.contains(day)){
                      if(selectedDays.length > 1){
                        selectedDays.remove(day);
                      }
                    }else{
                      selectedDays.add(day);
                    }

                    setState(() { });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                    decoration: BoxDecoration(
                      color: selectedDays.contains(day) ? Theme.of(context).primaryColor : Colors.transparent,
                      border: Border.all(
                        color: selectedDays.contains(day) ? Theme.of(context).primaryColor : Color(0xFFDFDFDF),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        day,
                        style: TextStyle(
                          color: selectedDays.contains(day) ? Colors.white : Theme.of(context).primaryColor,
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
                  decoration: InputDecoration(border: const OutlineInputBorder(), contentPadding: EdgeInsets.zero.copyWith(left: 8)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      value: frequency,
                      items: [1, 2, 3, 4].map((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
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
          const SizedBox(height: 16,),
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
          const SizedBox(height: 16,),
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
                            child: Icon(Icons.calendar_today_outlined, size: 16,),
                          ),

                          border: const OutlineInputBorder(gapPadding: 0),
                          contentPadding: EdgeInsets.zero.copyWith(left: 8),
                          hintText: untilDate == null
                              ? 'Select date'
                              : '${untilDate!.year}/${untilDate!.month}/${untilDate!.day}',
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

class RecurrenceData {

}