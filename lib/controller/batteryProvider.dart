import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';

class BatteryProvider with ChangeNotifier{
  final  battery=Battery();
  int batteryLevel0=100;
   BatteryState batteryState0=BatteryState.full;
   late StreamSubscription subscription;
   late Timer timer;
  Future batteryLevelCheck() async {
    final batteryLevel= await battery.batteryLevel;
    batteryLevel0=batteryLevel;
    notifyListeners();
  }
  void batteryUpdate(){
    timer=Timer.periodic(const Duration(seconds: 10), (timer) async{
      batteryLevelCheck();
    });
  }
  void onChangeBatteryState(){
    subscription=battery.onBatteryStateChanged.listen((val) {
      batteryState0=val;
    });
    notifyListeners();
  }
}