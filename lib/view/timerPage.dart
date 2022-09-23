import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {

  @override
  Widget build(BuildContext context) {
    DateTime time=DateTime(0,0,0,0,10);
    bool isClick=false;
    return Scaffold(
      appBar: AppBar(title: Text("sleep mode",style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),),),
      body: Container(
        padding: EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Text("All songs will stop after ${time.minute} : ${time.second}",style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white,fontSize: 14),),
            Spacer(flex: 1,),
            TimePickerSpinner(
              time: time,
              is24HourMode: true,
              isShowSeconds: true,
              normalTextStyle: const TextStyle(fontSize: 15, color: Colors.blueGrey),
              highlightedTextStyle: const TextStyle(fontSize: 26, color: Colors.white),
              spacing: 40,
              itemHeight: 80,
              isForce2Digits: true,
              onTimeChange: (val) {
                setState(() {
                  time=val;
                });
              },
            ),
            Spacer(flex: 1,),
          ],
        ),),
        floatingActionButton: FloatingActionButton(onPressed: (){},child: Icon(Icons.play_arrow),backgroundColor: Colors.teal,heroTag: null,),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );
  }
}
