import 'dart:isolate';

import 'package:first_of_seven/controller/myProviderFile.dart';
import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class Alarm{
  final DateTime period;
  final DateTime time;
  final String name;
  final bool  ringOption;
  final Ringtone ringtoneMusic;
  final bool vib;
  final bool snooze;
  bool active;


  Alarm({required this.active,required this.name, required  this.time, required this.ringOption,required this.ringtoneMusic,required this.snooze, required this.vib,required this.period});
}
class Ringtone{
  final String name;
  final String uri;
  final bool isAssets;
  bool isClick;
  final AudioPlayer player=AudioPlayer();

  Ringtone( {required this.uri,required this.name,required this.isClick,required this.isAssets,});
  Map<String, dynamic> toJson() => {
    "name":name,
    "uri":uri,
    "isAssets":isAssets,
    "isClick":isClick
  };
}


