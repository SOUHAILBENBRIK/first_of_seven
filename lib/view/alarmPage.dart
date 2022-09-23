
import 'dart:isolate';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:first_of_seven/controller/myProviderFile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

import '../model/data.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {

  Widget isEmpty(){
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(20,200,20,20),
      child: Column(
        children: const [
          Text("there is no alarm",style: TextStyle(color: Colors.white,fontSize: 20),),
          SizedBox(height: 10,),
          Icon(Icons.alarm_off,size: 70,color: Colors.white,)
        ],
      ),
    );
  }
  Widget isNotEmpty(Alarm alarm){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text((alarm.time.hour<10?"0"+alarm.time.hour.toString():alarm.time.hour.toString())+":"+(alarm.time.minute<10?"0"+alarm.time.minute.toString():alarm.time.minute.toString()),style: const TextStyle(color: Colors.white,fontSize: 30),),
                  const SizedBox(width: 10,),
                  Text(alarm.name,style: const TextStyle(color: Colors.white),)
                ],
              ),
              const SizedBox(height: 5,),
              Text(alarm.ringOption?"ring once":"ring monday",style: const TextStyle(color: Colors.white),)
            ],
          ),
          Switch(value: alarm.active, onChanged: (val){setState(() {
            alarm.active=val;});

            if(alarm.active){
             /*
             *  AndroidAlarmManager.oneShotAt(DateTime.now().add(const Duration(minutes: 1)), 0, ()async{
                if(alarm.ringtoneMusic.isAssets){
                  print("gggg");
                  await alarm.ringtoneMusic.player.setAsset(alarm.ringtoneMusic.uri);
                  await alarm.ringtoneMusic.player.play();
                }else{
                  await alarm.ringtoneMusic.player.setAudioSource(AudioSource.uri(Uri.parse(alarm.ringtoneMusic.uri
                  )));
                  await alarm.ringtoneMusic.player.play();
                }
    });*/
            }
          },inactiveThumbColor: Colors.blueGrey,inactiveTrackColor: Colors.blueGrey.shade700,activeColor: Colors.teal,activeTrackColor: Colors.blueGrey.shade700,)
        ],
      ),
    );
  }
  static void pro()async {
    final int isolateId = Isolate.current.hashCode;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
        IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert,color: Colors.white,))
      ],),
      body: Container(
        padding: const EdgeInsets.all(30),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Alarm",style: TextStyle(color: Colors.white,fontSize: 30,),),
            Provider.of<MyProvider>(context).alarms.isEmpty?isEmpty():Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: Provider.of<MyProvider>(context).alarms.map((e) => isNotEmpty(e)).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()async{
        Navigator.pushReplacementNamed(context, "/newAlarm");
      },child: const Icon(Icons.add,),backgroundColor: Colors.teal,heroTag: null,),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
