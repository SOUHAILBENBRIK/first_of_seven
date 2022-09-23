
import 'package:first_of_seven/controller/myProviderFile.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

import '../model/data.dart';
class RingtonePage extends StatelessWidget {
  const RingtonePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyProvider myProvider=Provider.of<MyProvider>(context);



    Widget radio(Ringtone ringtone){
      return ListTile(
        title: Text(ringtone.name,style: const TextStyle(color: Colors.white),),
        trailing: CircleAvatar(
          radius: 10,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 8,
            backgroundColor: ringtone.isClick?Colors.teal:Colors.black,
          ),
        ),
        onTap: ()async{
          Provider.of<MyProvider>(context,listen: false).setSongSystem(ringtone);
          for (var element in myProvider.ringtones) {element.player.stop();}
          await ringtone.player.setAsset(ringtone.uri);
          await ringtone.player.play();
        },

      );
    }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Ringtone"),
        elevation: 0,
        backgroundColor: Colors.black,
        leading: IconButton(icon:const Icon(Icons.arrow_back),onPressed: (){
          myProvider.ringtones.forEach((element) {
            element.player.stop();
          });
          Navigator.pushReplacementNamed(context, "/newAlarm");},),

      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: const Text("choose from your Device",style: TextStyle(color: Colors.white),),
              trailing: const Icon(Icons.arrow_forward_ios,color: Colors.white,),
              onTap: (){
                for (var element in myProvider.ringtones) {
                  element.player.stop();
                }
                Navigator.pushReplacementNamed(context, "/musicBox");
              },
            ),
            Column(children:myProvider.ringtones.map((e) => radio(e)).toList(),),
          ],

        ),
      ),
    );
  }
}

