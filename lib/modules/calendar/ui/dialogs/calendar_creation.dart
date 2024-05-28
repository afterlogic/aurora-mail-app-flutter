import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/base_calendar_dialog.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/color_selection_field.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/text_input.dart';
import 'package:aurora_mail/modules/calendar/utils/calendar_colors.dart';
import 'package:flutter/material.dart';

class CalendarCreationDialog extends StatefulWidget {
  const CalendarCreationDialog();

  static Future<CalendarCreationData?> show(
    BuildContext context,
  ) {
    return showDialog<CalendarCreationData?>(
        context: context,
        builder: (_) => CalendarCreationDialog()).then((value) => value);
  }

  @override
  State<CalendarCreationDialog> createState() => _CalendarCreationDialogState();
}

class _CalendarCreationDialogState extends State<CalendarCreationDialog> {
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

  bool _subscribeToIcalFeed = false;
  Color _selectedColor = calendarColors[0];
  final List<Color> _colors = calendarColors;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController();
    _nameController = TextEditingController();
    _iCalController = TextEditingController();
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
        title: 'Create calendar',
        actions: [
          TextButton(
            onPressed: () {
              if (!_formKey.currentState!.validate()) {
                return;
              }
              Navigator.of(context).pop(CalendarCreationData(
                  title: _nameController.text,
                  description: _descriptionController.text,
                  iCalMail: _iCalController.text,
                  color: _selectedColor));
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
            Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Checkbox(
                    value: _subscribeToIcalFeed,
                    onChanged: (bool? value) {
                      setState(() {
                        _subscribeToIcalFeed = value ?? false;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Text('Subscribe to iCal feed'),
              ],
            ),
            if (_subscribeToIcalFeed) ...[
              SizedBox(height: 16),
              TextInput(
                  controller: _iCalController,
                  validator: _subscribeToIcalFeed ? _validator : null,
                  labelText: 'iCal URL'),
            ],
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
