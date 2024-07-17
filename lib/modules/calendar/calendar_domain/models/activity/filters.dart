import 'package:equatable/equatable.dart';

class ActivityFilter extends Equatable {
  final ActivityDateFilter date;
  final ActivityStatusFilter status;
  const ActivityFilter({this.date = ActivityDateFilter.all, this.status = ActivityStatusFilter.all});

  ActivityFilter copyWith(
      {ActivityDateFilter? date, ActivityStatusFilter? status}) {
    return ActivityFilter(
        date: date ?? this.date, status: status ?? this.status);
  }

  @override
  List<Object?> get props => [date, status];
}

enum ActivityDateFilter { hasDate, withoutDate, all }

enum ActivityStatusFilter { completedOnly, all }
