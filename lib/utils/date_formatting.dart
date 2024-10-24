//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class DateFormatting {
  static String formatDateFromSeconds(int timestamp, String locale,
      {String format = "MMM dd"}) {
    final date = DateTime.fromMillisecondsSinceEpoch((timestamp * 1000));
    return DateFormat(format, locale).format(date);
  }

  static String getShortMessageDate({
    @required int timestamp,
    @required String locale,
    @required String yesterdayWord,
    @required bool is24,
  }) {
    final date = DateTime.fromMillisecondsSinceEpoch((timestamp * 1000));
    final now = DateTime.now();

    if (now.day == date.day &&
        now.month == date.month &&
        now.year == date.year) {
      if (is24) {
        return DateFormat("HH:mm", locale).format(date);
      } else {
        return DateFormat("h:mm aaa", locale).format(date);
      }
    } else if (now.day - 1 == date.day &&
        now.month == date.month &&
        now.year == date.year) {
      if (is24) {
        return DateFormat("'$yesterdayWord' HH:mm", locale).format(date);
      } else {
        return DateFormat("'$yesterdayWord' h:mm aaa", locale).format(date);
      }
    } else if (now.year == date.year) {
      return DateFormat("MMM d", locale).format(date);
    } else {
      return DateFormat("MMM d, yyyy", locale).format(date);
    }
  }

  static String getDetailedMessageDate({
    @required int timestamp,
    @required String locale,
    @required String yesterdayWord,
    @required bool is24,
  }) {
    final date = DateTime.fromMillisecondsSinceEpoch((timestamp * 1000));

    if (is24) {
      return DateFormat("EEE, MMM d, yyy HH:mm", locale).format(date);
    } else {
      return DateFormat("EEE, MMM d, yyy h:mm aaa", locale).format(date);
    }
  }

  static String formatBirthday({
    @required int day,
    @required int month,
    @required int year,
    @required String locale,
    @required String format,
  }) {
    if (year == 0 && month == 0 && year == 0) return "";
    return DateFormat(format, locale).format(DateTime(year, month, day));
  }

  static String formatEventDates({
    // @required int timestamp,
    @required DateTime startDate,
    @required DateTime endDate,
    String locale,
    @required bool is24,
  }) {
    final now = DateTime.now();
    String sStartDate = '';
    String sEndDate = '';
    bool isSameDay(DateTime dateA, DateTime dateB) {
      return dateA.year == dateB.year && dateA.month == dateB.month && dateA.day == dateB.day;
    }

    String sDateFormat = now.year != startDate.year ? 'y/MM/dd,' : 'EEE, MMM d,';
    String sTimeFormat = (is24 ? 'HH:mm' : 'h:mm a');

    sStartDate = '${DateFormat(sDateFormat, locale).format(startDate)} ${DateFormat(sTimeFormat, locale).format(startDate)}';

    if (isSameDay(startDate, endDate)) {
      sEndDate = '${DateFormat(sTimeFormat, locale).format(endDate)}';
    } else {
      sEndDate = '${DateFormat(sDateFormat, locale).format(endDate)} ${DateFormat(sTimeFormat, locale).format(endDate)}';
    }

    return sStartDate + ' - ' + sEndDate;
  }
}
