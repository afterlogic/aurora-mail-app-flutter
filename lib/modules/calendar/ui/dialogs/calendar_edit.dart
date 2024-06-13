import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/base_calendar_dialog.dart';
import 'package:aurora_mail/modules/calendar/ui/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/color_selection_field.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/text_input.dart';
import 'package:aurora_mail/modules/calendar/utils/calendar_colors.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class CalendarEditDialog extends StatefulWidget {
  final ViewCalendar calendar;
  const CalendarEditDialog({required this.calendar});

  static Future<ViewCalendar?> show(BuildContext context,
      {required ViewCalendar calendar}) {
    return showDialog<ViewCalendar?>(
        context: context,
        builder: (_) => CalendarEditDialog(
              calendar: calendar,
            )).then((value) => value);
  }

  @override
  State<CalendarEditDialog> createState() => _CalendarEditDialogState();
}

class _CalendarEditDialogState extends State<CalendarEditDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _iCalController;
  final _formKey = GlobalKey<FormState>();

  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter text';
    }
    return null;
  }

  late Color _selectedColor;
  final List<Color> _colors = calendarColors;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController()
      ..text = widget.calendar.description ?? '';
    _nameController = TextEditingController()
      ..text = widget.calendar.name;
    _iCalController = TextEditingController()..text = '';
    final color = _colors.firstWhereOrNull((c) => c.value == widget.calendar.color.value);
    if(color == null){
      _colors.add(widget.calendar.color);
      _selectedColor = widget.calendar.color;
    }else{
      _selectedColor = color;
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _nameController.dispose();
    _iCalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BaseCalendarDialog(
        title: 'Edit calendar',
        actions: [
          TextButton(
            onPressed: () {
              if (!_formKey.currentState!.validate()) {
                return;
              }
              Navigator.of(context).pop(widget.calendar.copyWith(
                name: _nameController.text,
                description: () => _descriptionController.text,
                color: _selectedColor,
              ));
            },
            child: Text(S.of(context).btn_save),
          ),
        ],
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextInput(
              controller: _nameController,
              labelText: 'Calendar name',
              validator: _validator,
            ),
            SizedBox(height: 16),
            TextInput(
              controller: _descriptionController,
              labelText: 'Description',
            ),
            SizedBox(height: 16),
            if(widget.calendar.isSubscribed)TextInput(
                enabled: false,
                controller: _iCalController,
                labelText: 'iCal URL'),
            SizedBox(height: 16),
            const Text(
              'Color',
            ),
            SizedBox(height: 16),
            ColorSelectionField(
              colors: _colors,
              onColorTap: (color) {
                setState(() {
                  _selectedColor = color;
                });
              },
              selectedColor: _selectedColor,
            )
          ],
        ),
      ),
    );
  }
}
