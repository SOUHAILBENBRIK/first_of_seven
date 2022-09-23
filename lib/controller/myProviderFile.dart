

import 'package:flutter/material.dart';

import '../model/data.dart';

class MyProvider with ChangeNotifier{
  List<Alarm> alarms=[];
  List<Ringtone> ringtones=[
    Ringtone(name: "ringtone 1", uri: "songs/ringtone_1.mp3",isClick: true,isAssets: true),
    Ringtone(name: "ringtone 2", uri: "songs/ringtone_2.mp3",isClick: false,isAssets: true),
    Ringtone(name: "ringtone 3", uri: "songs/ringtone_3.mp3",isClick: false,isAssets: true),
    Ringtone(name: "ringtone 4", uri: "songs/ringtone_4.mp3",isClick: false,isAssets: true),
  ];
  Ringtone ringtone=Ringtone(name: "ringtone 1", uri: "songs/ringtone_1.mp3",isClick: true,isAssets: true);
  DateTime dateTime = DateTime.now();
  DateTime period = DateTime.now();
  setSongSystem(Ringtone val){
    ringtone=val;

    for (var element in ringtones) {element.isClick=false;}
    val.isClick=true;
    notifyListeners();
  }
  void onChangeTime(DateTime time){
    dateTime = time;
    if(dateTime.isAfter(DateTime.now())){
      period=dateTime.subtract(Duration(
          hours: DateTime.now().hour,
          minutes: DateTime.now().minute));
    }else{
      period=dateTime.subtract(Duration(
          hours: DateTime.now().hour - 24,
          minutes: DateTime.now().minute));
    }
    notifyListeners();
  }

  setSongDevice(Ringtone val){
    ringtone=val;
    for (var element in ringtones) {element.isClick=false;}
    notifyListeners();
  }

  addList(Alarm element){
    alarms.add(element);
    notifyListeners();
  }
}