import 'dart:convert';
import 'dart:io';

import 'package:aurora_mail/modules/settings/blocs/settings_bloc/settings_bloc.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ContactBirthDatePicker extends StatefulWidget {
  final int birthDay;
  final int birthMonth;
  final int birthYear;
  final void Function(List<int> time) onPicked;

  const ContactBirthDatePicker({
    Key key,
    @required this.birthDay,
    @required this.birthMonth,
    @required this.birthYear,
    @required this.onPicked,
  }) : super(key: key);

  @override
  _ContactBirthDatePickerState createState() => _ContactBirthDatePickerState();
}

class _ContactBirthDatePickerState extends BState<ContactBirthDatePicker> {
  DateTime _selectedDate = DateTime.now();

  void set selectedDate(DateTime date) {
    if (date != null && date != _selectedDate) {
      setState(() => _selectedDate = date);
      _setDate();
      widget.onPicked(
          [_selectedDate.day, _selectedDate.month, _selectedDate.year]);
    }
  }

  final _dateText = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.birthDay != 0) {
      _selectedDate =
          DateTime(widget.birthYear, widget.birthMonth, widget.birthDay);
      _setDate();
    }
  }

  void _setDate() async {
    final languageString =
        await BlocProvider.of<SettingsBloc>(context).getLanguage();

    final decoded = json.decode(languageString ?? "{}");
    final language = decoded["tag"] as String;
    _dateText.text = DateFormat(
      i18n(context, "contacts_birth_date_format"),
      language ?? "en",
    ).format(_selectedDate);
  }

  Future<void> _pick() async {
    FocusScope.of(context).unfocus();

    final now = DateTime.now();

    if (Platform.isIOS) {
      DateTime picked;
      await showCupertinoModalPopup(
        context: context,
        builder: (_) => SizedBox(
          height: 230.0,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            maximumDate: now,
            minimumDate: DateTime(now.year - 100),
            initialDateTime: _selectedDate,
            onDateTimeChanged: (dateTime) => picked = dateTime,
          ),
        ),
      );
      selectedDate = picked;
    } else {
      selectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(now.year - 100),
        lastDate: now,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GestureDetector(
        onTap: _pick,
        child: AbsorbPointer(
          child: TextField(
            controller: _dateText,
            decoration: InputDecoration(
              labelText: i18n(context, "contacts_view_birthday"),
              alignLabelWithHint: true,
            ),
          ),
        ),
      ),
    );
  }
}
