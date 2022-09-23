import 'package:first_of_seven/theme.dart';
import 'package:first_of_seven/view/alarmPage.dart';
import 'package:first_of_seven/view/allRingtoneOptions.dart';
import 'package:first_of_seven/view/chargingPage.dart';
import 'package:first_of_seven/view/musicBox.dart';
import 'package:first_of_seven/controller/myProviderFile.dart';
import 'package:flutter/material.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:provider/provider.dart';

import 'controller/batteryProvider.dart';
import 'view/homePage.dart';
import 'view/newAlarmPage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AndroidAlarmManager.initialize();
  runApp(

    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyProvider()),
        ChangeNotifierProvider(create: (_) => BatteryProvider()),
      ],
      child: const MyApp(),
    ),
  );

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: myTheme(),
      initialRoute: '/',
      routes: {
        '/' : (context)=>const HomePage(),
        "/alarm":(context)=>const AlarmPage(),
        "/newAlarm" : (context)=>const NewAlarm(),
        "/musicBox" : (context)=>const MyMusicBox(),
        "/allRingtones":(context)=> const RingtonePage(),
        "/ChargingPage":(context)=>const ChargingPage(),
      },
    );
  }
}



