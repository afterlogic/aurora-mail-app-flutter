import 'package:flutter/material.dart';
import 'package:alarm_service/alarm_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

const alarmId = 1;
var withMain = false;

void main() async {
  print("-----main");
  withMain = true;
  runApp(MyApp());
  AlarmService.init();
  AlarmService.onAlarm(onAlarm, alarmId);
  final sharedPreference = await SharedPreferences.getInstance();
  await sharedPreference.setBool(alarmId.toString(), true);
}

@pragma('vm:entry-point')
void onAlarm() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("-----background withMain:$withMain");
  bool success;
  try {
    final sharedPreference = await SharedPreferences.getInstance();
    success = sharedPreference.getBool(alarmId.toString());
  } catch (e) {
    success = false;
  }
  print("-----hasSharedPreferences:$success");
  AlarmService.endAlarm(success);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setAlarm();
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    state;
    super.didChangeAppLifecycleState(state);
  }


  setAlarm() {
    AlarmService.setAlarm(onAlarm, alarmId, Duration(seconds: 20));
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
