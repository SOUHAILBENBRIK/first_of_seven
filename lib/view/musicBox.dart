
import 'package:first_of_seven/controller/myProviderFile.dart';
import 'package:first_of_seven/model/data.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class MyMusicBox extends StatefulWidget {
  const MyMusicBox({Key? key}) : super(key: key);

  @override
  State<MyMusicBox> createState() => _MyMusicBoxState();
}

class _MyMusicBoxState extends State<MyMusicBox> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final AudioPlayer _player=AudioPlayer();
  List<Ringtone> ringtones=[];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("your songs"),
          elevation: 0,
          backgroundColor: Colors.black,
          leading: IconButton(icon:const Icon(Icons.arrow_back),onPressed: (){
            _player.dispose();
            Navigator.pushReplacementNamed(context, "/newAlarm");},),
        ),
        body: FutureBuilder<List<SongModel>>(
            future: _audioQuery.querySongs(
              sortType: null,
              orderType: OrderType.ASC_OR_SMALLER,
              uriType: UriType.EXTERNAL,
              ignoreCase: true,
            ),
            builder: (context, item) {
              if (item.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (item.data!.isEmpty) {
                return const Center(
                  child: Text('there is no song'),
                );
              }
              else{
                for (var element in item.data!) {ringtones.add(Ringtone(uri: element.uri!, name: element.title, isClick: false,isAssets: false));}
                return ListView.builder(
                    itemCount: item.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: ()async {
                          setState(() {
                            for (var element in ringtones) {element.isClick=false;}
                            ringtones[index].isClick=true;
                          });
                          Provider.of<MyProvider>(context,listen: false).setSongDevice(ringtones[index]);
                          await _player.setAudioSource(AudioSource.uri(Uri.parse(item.data![index].uri!)));
                          await _player.play();
                        },
                        trailing: CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 8,
                            backgroundColor: ringtones[index].isClick?Colors.teal:Colors.black,
                          ),
                        ),
                        title: Text(item.data![index].title,style: const TextStyle(color: Colors.white),),
                      );
                    });
              }

            }));
  }
}

