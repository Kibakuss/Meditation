import 'package:design_telegram/models/item_model.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MedatationAppScreen extends StatefulWidget {
  const MedatationAppScreen({Key? key}) : super(key: key);

  @override
  _MedatationAppScreenState createState() => _MedatationAppScreenState();
}

class _MedatationAppScreenState extends State<MedatationAppScreen> {
  final List items = [
    Item(
        name: "Forest",
        imagePath: "meditation_images/forest.jpeg",
        audioPass: "meditation_audios/forest.mp3"),
    Item(
        name: "Night",
        imagePath: "meditation_images/night.jpeg",
        //специально в пути ошибка чтобы исключение try catch заюзать
        audioPass: "meditation_audios/nightt.mp3"),
    Item(
        name: "Ocean",
        imagePath: "meditation_images/ocean.jpeg",
        audioPass: "meditation_audios/ocean.mp3"),
    Item(
        name: "Waterfall",
        imagePath: "meditation_images/waterfall.jpeg",
        audioPass: "meditation_audios/waterfall.mp3"),
    Item(
        name: "Wind",
        imagePath: "meditation_images/wind.jpeg",
        audioPass: "meditation_audios/wind.mp3"),
    Item(
        name: "GNG",
        imagePath: "meditation_images/wind.jpeg",
        audioPass: "meditation_audios/gng.mp3"),
  ];

  final auidioPlayer = AudioPlayer();
  int? playingIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(20),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(items[index].imagePath),
                  ),
                ),
                height: 100,
                child: ListTile(
                  title: Text(items[index].name),
                  leading: IconButton(
                    onPressed: () async {
                      if (playingIndex == index) {
                        setState(() {
                          playingIndex = null;
                        });
                        auidioPlayer.stop();
                      } else {
                        try {
                          // если убрать await то будет крашиться
                          await auidioPlayer
                              .setAsset(items[index].audioPass)
                              .catchError((onError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Oopps maaaan")));
                          });
                          auidioPlayer.play();
                          setState(() {
                            playingIndex = index;
                          });
                        } catch (error) {
                          print(error);
                        }
                      }
                    },
                    icon: playingIndex == index
                        ? FaIcon(FontAwesomeIcons.stop)
                        : FaIcon(FontAwesomeIcons.play),
                  ),
                ),
              ),
            );
          }),
    ));
  }
}
