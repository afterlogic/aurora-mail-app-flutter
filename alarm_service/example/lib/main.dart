import 'package:flutter/material.dart';
import 'package:alarm_service/alarm_service.dart';

const alarmId = 1;

void main() async {
  runApp(MyApp());
  AlarmService.onAlarm(onAlarm, alarmId);
}

@pragma('vm:entry-point')
void onAlarm() async {
  print("alarm is now ${TimeOfDay.now().toString()}");
  AlarmService.endAlarm();
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    setAlarm();
  }

  setAlarm() {
    AlarmService.setAlarm(onAlarm, alarmId, Duration(seconds: 20), true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
      ),
    );
  }
}
