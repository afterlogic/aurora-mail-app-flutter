enum RemindersOption {
  min5,
  min10,
  min15,
  min30,
  hours1,
  hours2,
  hours3,
}

extension RemindersIntMapper on RemindersOption {
  static RemindersOption? fromInt(int value) {
    switch (value) {
      case 5:
        return RemindersOption.min5;
      case 10:
        return RemindersOption.min10;
      case 15:
        return RemindersOption.min15;
      case 30:
        return RemindersOption.min30;
      case 60:
        return RemindersOption.hours1;
      case 120:
        return RemindersOption.hours2;
      case 180:
        return RemindersOption.hours3;
      default:
        return null;
    }
  }

  int get toInt {
    switch (this) {
      case RemindersOption.min5:
        return 5;
      case RemindersOption.min10:
        return 10;
      case RemindersOption.min15:
        return 15;
      case RemindersOption.min30:
        return 30;
      case RemindersOption.hours1:
        return 60;
      case RemindersOption.hours2:
        return 120;
      case RemindersOption.hours3:
        return 180;
    }
  }
}

extension RemindersOptionString on RemindersOption {
  String get buildString {
    switch (this) {
      case RemindersOption.min5:
        return '5 minutes';
      case RemindersOption.min10:
        return '10 minutes';
      case RemindersOption.min15:
        return '15 minutes';
      case RemindersOption.min30:
        return '30 minutes';
      case RemindersOption.hours1:
        return '1 hours';
      case RemindersOption.hours2:
        return '2 hours';
      case RemindersOption.hours3:
        return '3 hours';
    }
  }
}
