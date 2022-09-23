import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:first_of_seven/controller/batteryProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
class ChargingPage extends StatefulWidget {
  const ChargingPage({Key? key}) : super(key: key);

  @override
  State<ChargingPage> createState() => _ChargingPageState();
}

class _ChargingPageState extends State<ChargingPage> {
  final  battery=Battery();
  int batteryLevel0=100;
  BatteryState batteryState0=BatteryState.full;
  late StreamSubscription subscription;
  late Timer timer;
  bool isClick=false;
  Future batteryLevelCheck() async {
    final batteryLevel= await battery.batteryLevel;
    setState(() {
      batteryLevel0=batteryLevel;
    });

  }
  void batteryUpdate(){
    timer=Timer.periodic(const Duration(seconds: 10), (timer) async{
      batteryLevelCheck();
    });
  }
  void onChangeBatteryState(){
    subscription=battery.onBatteryStateChanged.listen((val) {
      setState(() {
        batteryState0=val;
      });

    });
  }
  @override
  void initState() {
    batteryLevelCheck();
    batteryUpdate();
    onChangeBatteryState();
    super.initState();
  }
  @override
  void dispose() {
    timer.cancel();
    subscription.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    BatteryProvider provider=Provider.of<BatteryProvider>(context,listen: false);
    BatteryProvider myProvider=Provider.of<BatteryProvider>(context);

    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(visible:batteryState0.name=='charging',child: Text("the phone is charging!!",style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white))),
            Spacer(flex: 2,),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Visibility(
                visible: batteryState0.name=='full'?false:true,
                replacement: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.battery_charging_full,color: Colors.teal,size: 300,),
                    Text('full charging',style: Theme.of(context).textTheme.headline3)
                  ],
                ),
                child: CircularPercentIndicator(
                  radius: 100.0,
                  lineWidth: 5.0,
                  percent: batteryLevel0.toDouble()*0.01,
                  center: Text(batteryLevel0.toString(),style: Theme.of(context).textTheme.headline3,),
                  progressColor: batteryState0.name=='charging'?Colors.yellow:Colors.teal,
                  backgroundColor: Colors.blueGrey,
                ),
              ),
            ),
            Spacer(flex: 1,)

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){},child: Icon(Icons.play_arrow),heroTag: null,),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
