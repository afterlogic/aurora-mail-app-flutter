import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/base_calendar_dialog.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/color_selection_field.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/text_input.dart';
import 'package:aurora_mail/modules/calendar/utils/calendar_colors.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/settings_bloc.dart';
import 'package:aurora_mail/utils/extensions/colors_extensions.dart';
import 'package:aurora_mail/utils/user_app_data_singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  late Color _selectedColor;
  late final List<Color> _colors;

  @override
  void initState() {
    super.initState();
    final calendarSettings = UserAppDataSingleton().getAppData?.calendarSettings;
    final serverColors = calendarSettings != null
        ? (calendarSettings["CalendarColors"] as List).cast<String>()
        : null;
    _colors = serverColors != null && serverColors.isNotEmpty
        ? serverColors.map((e) => HexColor.fromHex(e)).toList()
        : calendarColors;
    _selectedColor = _colors[0];
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
            GestureDetector(
              onTap: () {
                setState(() {
                  _subscribeToIcalFeed = !_subscribeToIcalFeed;
                });
              },
              child: Row(
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
