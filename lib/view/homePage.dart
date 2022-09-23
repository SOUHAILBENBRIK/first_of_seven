
import 'package:first_of_seven/view/alarmPage.dart';
import 'package:first_of_seven/view/chargingPage.dart';
import 'package:first_of_seven/view/timerPage.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:flutter/foundation.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestStorage();
  }
  final OnAudioQuery _audioQuery=OnAudioQuery();
  void requestStorage() async {
    if(!kIsWeb){
      bool permission= await _audioQuery.permissionsStatus();
      if(!permission){
        await _audioQuery.permissionsRequest();

      }
    }
  }
  final _pageViewController = PageController();


  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }
  int index=0;
  final List<Widget> pages=[
    const AlarmPage(),
    const ChargingPage(),
    const TimerPage(),
  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView(
        controller: _pageViewController,
        children: pages,
        onPageChanged: (val) {
          setState(() {
            index = val;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: index,
        selectedFontSize: 20,
        onTap: (val)=>_pageViewController.animateToPage(val, duration: const Duration(milliseconds: 200), curve: Curves.bounceOut),
        unselectedFontSize: 10,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.access_alarm,size: 24,),label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.charging_station,size: 24,),label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.timer,size: 24,),label: '')
        ],
      ),
    );
  }
}
