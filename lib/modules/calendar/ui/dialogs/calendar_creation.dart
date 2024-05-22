import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';
import 'package:aurora_mail/utils/show_dialog.dart';
import 'package:flutter/material.dart';

class CalendarCreationDialog extends StatefulWidget {
  const CalendarCreationDialog();

  static Future<void> show(
    BuildContext context,
  ) {
    return dialog<ContactsGroup?>(
        context: context,
        builder: (_) => CalendarCreationDialog()).then((value) => value);
  }

  @override
  State<CalendarCreationDialog> createState() => _CalendarCreationDialogState();
}

class _CalendarCreationDialogState extends State<CalendarCreationDialog> {
  bool _subscribeToIcalFeed = false;
  Color _selectedColor = Colors.orange;
  final List<Color> _colors = [
    Colors.orange,
    Colors.red,
    Colors.pink,
    Colors.green,
    Colors.purple,
    Colors.cyan,
    Colors.teal,
    Colors.grey,
    Colors.blue,
    Colors.lightGreen,
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      actions: [
        TextButton(
          onPressed: () {},
          child: Text('Save'),
        ),
      ],
      title: Row(
        children: [
          Text('Create calendar', style: Theme.of(context).textTheme.headline5),
          Spacer(),
          CloseButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              )
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Calendar name',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Checkbox(
                value: _subscribeToIcalFeed,
                onChanged: (bool? value) {
                  setState(() {
                    _subscribeToIcalFeed = value ?? false;
                  });
                },
              ),
              Text('Subscribe to iCal feed'),
            ],
          ),
          if (_subscribeToIcalFeed)
            TextField(
              decoration: InputDecoration(
                labelText: 'iCal URL',
                border: OutlineInputBorder(),
              ),
            ),
          SizedBox(height: 16),
          Text('Color'),
          SizedBox(height: 8),
          Wrap(
            children: _colors.map((color) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedColor = color;
                  });
                },
                child: Container(
                  width: 36,
                  height: 36,
                  margin: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: _selectedColor == color
                        ? Border.all(color: Colors.black, width: 2)
                        : null,
                  ),
                  child: _selectedColor == color
                      ? Icon(Icons.check, color: Colors.white)
                      : null,
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
