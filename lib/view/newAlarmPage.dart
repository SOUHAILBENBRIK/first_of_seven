import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:first_of_seven/controller/myProviderFile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/data.dart';

class NewAlarm extends StatefulWidget {
  const NewAlarm({Key? key}) : super(key: key);

  @override
  State<NewAlarm> createState() => _NewAlarmState();
}

class _NewAlarmState extends State<NewAlarm> {
  final TextEditingController _name=TextEditingController();
  bool _vib=true;
  bool _sno=true;
  bool status=false;
  int id=0;
  String portName = "ConnectingIsolate";
  static void pro()async {

      final prefs = await SharedPreferences.getInstance();
      Map<String,dynamic> ringtone=jsonDecode(prefs.getString("ringtone")!);
      Ringtone ringtoneClass=Ringtone(uri: ringtone['uri'], name: ringtone['name'], isClick: ringtone['isClick'], isAssets: ringtone['isAssets']);
      if(ringtoneClass.isAssets){
        await ringtoneClass.player.setAsset(ringtoneClass.uri);
        await ringtoneClass.player.play();
      }else{
        await ringtoneClass.player.setAudioSource(AudioSource.uri(Uri.parse(ringtoneClass.uri
        )));
        await ringtoneClass.player.play();
      }

        final int isolateId = Isolate.current.hashCode;
        print(isolateId);



  }
  static void fun(){
    const String portName = "ConnectingIsolate";
    SendPort? sendPort = IsolateNameServer.lookupPortByName(portName);
    sendPort!.send("Abcd");
}
  @override
  void initState()  {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MyProvider myProvider=Provider.of<MyProvider>(context);
    final MyProvider myProvider1=Provider.of<MyProvider>(context,listen: false);


    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "New alarm",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () async{
            Navigator.pushReplacementNamed(context, "/");

          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.done,
              color: Colors.white,
            ),
            onPressed: () async{
              final prefs = await SharedPreferences.getInstance();
              Navigator.pushReplacementNamed(context, "/");
              myProvider1.addList(Alarm(name: _name.text,time:  myProvider.dateTime,vib: _vib,snooze: _sno,ringOption: true,ringtoneMusic: myProvider.ringtone,period: myProvider.period, active: true));
              prefs.setString("ringtone",jsonEncode(myProvider.ringtone));
              await AndroidAlarmManager.periodic(const Duration(hours:0,minutes:0,seconds: 50), id, pro);
            },
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Alarm will ring in " + myProvider.period.hour.toString()+" h "+myProvider.period.minute.toString()+" min ",
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TimePickerSpinner(
                    is24HourMode: true,
                    normalTextStyle:
                        const TextStyle(fontSize: 15, color: Colors.blueGrey),
                    highlightedTextStyle:
                        const TextStyle(fontSize: 26, color: Colors.white),
                    spacing: 40,
                    itemHeight: 80,
                    isForce2Digits: true,
                    onTimeChange: (time) {
                      myProvider1.onChangeTime(time);
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              primary: status?Colors.blueGrey:Colors.black,
                              minimumSize: const Size(150, 40)),
                          onPressed: () {
                            setState(() {
                              status=true;
                            });

                          },
                          child: const Text(
                            'Ring once',
                            style: TextStyle(color: Colors.white),
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              primary: !status?Colors.blueGrey:Colors.black,
                              minimumSize: const Size(150, 40)),
                          onPressed: () {setState(() {
                            status=false;
                          });},
                          child: const Text(
                            'custom',
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  ),
                  Visibility(
                    replacement: SizedBox(),
                    visible: !status,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 5, 3),
                      child: GestureDetector(
                        onTap: (){print("d");},
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(crossAxisAlignment:CrossAxisAlignment.start,children: const [
                                  Text("Repeat",style: TextStyle(color: Colors.white,fontSize: 20)),
                                  Text("select",style: TextStyle(color: Colors.teal,fontSize: 11))
                                ],),
                                Icon(Icons.arrow_forward_ios,color: Colors.grey.shade700,size: 20,),
                              ],
                            ),
                            const Divider(color: Colors.blueGrey,)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: TextField(style:const TextStyle(color: Colors.white),controller:_name,cursorColor:Colors.white,decoration: const InputDecoration(hintText: "Alarm Name",hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      )),),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 3, 5, 3),
                    child: GestureDetector(
                      onTap: (){Navigator.pushReplacementNamed(context, "/allRingtones");},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
                            const Text("Ringtone",style: TextStyle(color: Colors.white,fontSize: 20)),
                            Text(Provider.of<MyProvider>(context).ringtone.name,style: const TextStyle(color: Colors.teal,fontSize: 11))
                          ],),
                          Icon(Icons.arrow_forward_ios,color: Colors.grey.shade700,size: 20,),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                      const Text("Vibrate",style: TextStyle(color: Colors.white),),
                      Switch(value: _vib, onChanged: (val){setState(() {
                        _vib=val;
                      });},inactiveThumbColor: Colors.blueGrey,inactiveTrackColor: Colors.blueGrey.shade700,activeColor: Colors.teal,activeTrackColor: Colors.blueGrey.shade700,)
                    ],),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      const Text("Snooze",style: TextStyle(color: Colors.white),),
                      Switch(value: _sno, onChanged: (val){setState(() {
                        _sno=val;
                      });},inactiveThumbColor: Colors.blueGrey,inactiveTrackColor: Colors.blueGrey.shade700,activeColor: Colors.teal,activeTrackColor: Colors.blueGrey.shade700,)
                    ],),
                  ),

                ]),
          ),
        ),
      ),    );
  }
}
