enum DaysOfWeek { su, mo, tu, we, th, fr, sa }

extension DaysOfWeekX on DaysOfWeek {
  static DaysOfWeek fromDaysCode(String code) {
    switch (code) {
      case "MO":
        return DaysOfWeek.mo;
      case "TU":
        return DaysOfWeek.tu;
      case "WE":
        return DaysOfWeek.we;
      case "TH":
        return DaysOfWeek.th;
      case "FR":
        return DaysOfWeek.fr;
      case "SA":
        return DaysOfWeek.sa;
      case "SU":
        return DaysOfWeek.su;
      default:
        throw Exception('Unknown days code: $code');
    }
  }

  String get byDaysCode {
    switch (this) {
      case DaysOfWeek.su:
        return "SU";
      case DaysOfWeek.mo:
        return "MO";
      case DaysOfWeek.tu:
        return "TU";
      case DaysOfWeek.we:
        return "WE";
      case DaysOfWeek.th:
        return "TH";
      case DaysOfWeek.fr:
        return "FR";
      case DaysOfWeek.sa:
        return "SA";
    }
  }

  String buildString() {
    switch (this) {
      case DaysOfWeek.su:
        return 'Su';
      case DaysOfWeek.mo:
        return 'Mo';
      case DaysOfWeek.tu:
        return 'Tu';
      case DaysOfWeek.we:
        return 'We';
      case DaysOfWeek.th:
        return 'Th';
      case DaysOfWeek.fr:
        return 'Fr';
      case DaysOfWeek.sa:
        return 'Sa';
    }
  }
}