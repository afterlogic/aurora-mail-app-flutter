
import 'dart:convert';
import 'dart:io';

import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/settings_bloc.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/input_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ContactBirthDatePicker extends StatefulWidget {
  final int? birthDay;
  final int? birthMonth;
  final int? birthYear;
  final void Function(List<int> time) onPicked;

  const ContactBirthDatePicker({
    Key? key,
    required this.birthDay,
    required this.birthMonth,
    required this.birthYear,
    required this.onPicked,
  }) : super(key: key);

  @override
  _ContactBirthDatePickerState createState() => _ContactBirthDatePickerState();
}

class _ContactBirthDatePickerState extends BState<ContactBirthDatePicker> {
  DateTime _selectedDate = DateTime.now();

  void set selectedDate(DateTime? date) {
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
          DateTime(widget.birthYear!, widget.birthMonth!, widget.birthDay!);
      _setDate();
    }
  }

  void _setDate() async {
    final languageString =
        await BlocProvider.of<SettingsBloc>(context).getLanguage();

    final decoded = json.decode(languageString ?? "{}");
    final language = decoded["tag"] as String?;
    _dateText.text = DateFormat(
      S.of(context).format_contacts_birth_date,
      language ?? "en",
    ).format(_selectedDate);
  }

  Future<void> _pick() async {
    FocusScope.of(context).unfocus();

    final now = DateTime.now();

    if (Platform.isIOS) {
      DateTime picked = _selectedDate;
      await showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
          height: 292.0,
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: Column(
            children: [
              Container(
                height: 56.0,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: CupertinoColors.separator.resolveFrom(context),
                      width: 0.5,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          S.of(context).btn_cancel,
                          style: TextStyle(
                            color:
                                CupertinoColors.systemBlue.resolveFrom(context),
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        onPressed: () {
                          selectedDate = picked;
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          S.of(context).btn_done,
                          style: TextStyle(
                            color:
                                CupertinoColors.systemBlue.resolveFrom(context),
                            fontWeight: FontWeight.w600,
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  maximumDate: now,
                  minimumDate: DateTime(now.year - 100),
                  initialDateTime: _selectedDate,
                  onDateTimeChanged: (dateTime) => picked = dateTime,
                ),
              ),
            ],
          ),
        ),
      );
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
    return InputUtils.buildUnlymeDatePicker(
      context: context,
      controller: _dateText,
      labelText: S.of(context).contacts_view_birthday,
      onTap: _pick,
    );
  }
}
