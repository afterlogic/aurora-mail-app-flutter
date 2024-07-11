class Rrule {
  final int startBase;
  final int? endBase;
  final int? period;
  final String? interval;
  final int? end;
  final String? until;

  const Rrule({
    required this.startBase,
    this.endBase,
    this.period,
    this.interval,
    this.end,
    this.until,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is Rrule &&
              runtimeType == other.runtimeType &&
              startBase == other.startBase &&
              endBase == other.endBase &&
              period == other.period &&
              interval == other.interval &&
              end == other.end &&
              until == other.until);

  @override
  int get hashCode =>
      startBase.hashCode ^
      endBase.hashCode ^
      period.hashCode ^
      interval.hashCode ^
      end.hashCode ^
      until.hashCode;

  @override
  String toString() {
    return 'Rrule{' +
        ' startBase: $startBase,' +
        ' endBase: $endBase,' +
        ' period: $period,' +
        ' interval: $interval,' +
        ' end: $end,' +
        ' until: $until,' +
        '}';
  }

  Rrule copyWith({
    int? startBase,
    int? endBase,
    int? period,
    String? interval,
    int? end,
    String? until,
  }) {
    return Rrule(
      startBase: startBase ?? this.startBase,
      endBase: endBase ?? this.endBase,
      period: period ?? this.period,
      interval: interval ?? this.interval,
      end: end ?? this.end,
      until: until ?? this.until,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'startBase': this.startBase,
      'endBase': this.endBase,
      'period': this.period,
      'interval': this.interval,
      'end': this.end,
      'until': this.until,
    };
  }

  factory Rrule.fromMap(Map<String, dynamic> map) {
    return Rrule(
      startBase: map['startBase'] as int,
      endBase: map['endBase'] as int,
      period: map['period'] as int,
      interval: map['interval'] as String,
      end: map['end'] as int,
      until: map['until'] as String,
    );
  }
}
