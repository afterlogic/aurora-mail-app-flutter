import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/filters.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/base_calendar_dialog.dart';
import 'package:flutter/material.dart';

class ActivityFilterDialog extends StatefulWidget {
  final ActivityFilter selectedFilter;
  const ActivityFilterDialog({required this.selectedFilter});

  static Future<ActivityFilter?> show(BuildContext context,
      {required ActivityFilter selectedFilter}) {
    return showDialog<ActivityFilter?>(
        context: context,
        builder: (_) => ActivityFilterDialog(
              selectedFilter: selectedFilter,
            ));
  }

  @override
  State<ActivityFilterDialog> createState() => _ActivityFilterDialogState();
}

class _ActivityFilterDialogState extends State<ActivityFilterDialog> {
  late ActivityDateFilter _selectedDateFilter;
  late ActivityStatusFilter _selectedStatusFilter;

  @override
  void initState() {
    super.initState();
    _selectedDateFilter = widget.selectedFilter.date;
    _selectedStatusFilter = widget.selectedFilter.status;
  }

  @override
  Widget build(BuildContext context) {
    return BaseCalendarDialog(
      title: 'Filter',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            child: Text(
              'Data',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ...ActivityDateFilter.values.map(
            (e) => RadioListTile<ActivityDateFilter>(
              contentPadding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              title: Text(e.buildString),
              value: e,
              groupValue: _selectedDateFilter,
              onChanged: (value) {
                setState(() {
                  _selectedDateFilter = e;
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            child: Text(
              'Task status',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ...ActivityStatusFilter.values.map(
            (e) => RadioListTile<ActivityStatusFilter>(
              contentPadding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              title: Text(e.buildString),
              value: e,
              groupValue: _selectedStatusFilter,
              onChanged: (value) {
                setState(() {
                  _selectedStatusFilter = e;
                });
              },
            ),
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(ActivityFilter(
                date: _selectedDateFilter, status: _selectedStatusFilter));
          },
          child: Text(S.of(context).btn_save),
        ),
      ],
    );
  }
}

extension _ActivityDateFilterStringBuilder on ActivityDateFilter {
  String get buildString {
    switch (this) {
      case ActivityDateFilter.hasDate:
        return 'Has a date';
      case ActivityDateFilter.withoutDate:
        return 'Without date';
      case ActivityDateFilter.all:
        return 'All';
    }
  }
}

extension _ActivityStatusFilterStringBuilder on ActivityStatusFilter {
  String get buildString {
    switch (this) {
      case ActivityStatusFilter.all:
        return 'All';
      case ActivityStatusFilter.completedOnly:
        return 'Completed only';
    }
  }
}
