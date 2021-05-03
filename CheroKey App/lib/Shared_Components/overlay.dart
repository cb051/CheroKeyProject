import 'dart:ui';

import 'package:chero_key/service/game_and_level_data.dart';
import 'package:chero_key/service/story_entity.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'package:chero_key/Shared_Components/loading_screen.dart';

class TitleOverlay extends StatefulWidget {
  final int levelNumber;
  final String worldInfo;

  TitleOverlay({Key key, @required this.levelNumber, @required this.worldInfo})
      : super(key: key);

  @override
  _TitleOverlayState createState() => _TitleOverlayState();
}

class _TitleOverlayState extends State<TitleOverlay> {
  bool onClick = false;
  var stories;
  List<List<String>> storyLists =
      List.generate(9, (_) => new List.generate(5, (_) => null));

  @override
  Widget build(BuildContext context) {
    int worldIdx = 0;
    if (widget.worldInfo == "The First Fire") {
      worldIdx = 1;
    }
    int levelIdx = widget.levelNumber - 1;
    return Consumer2<GameAndLevelData, StoryEntity>(
        builder: (context, gData, sData, child) {
      sData.worldName = gData.getWorldInfo().replaceAll(' ', '');
      // sData.worldName = "TheFirstFire";
      return FutureBuilder(
          future: Future.wait([sData.story]),
          builder: (context, storyData) {
            if (storyData.hasData) {
              stories = storyData.data[0];
              int i = 0;
              for (var section in stories) {
                int j = 0;
                for (String sentence in section) {
                  storyLists[i][j] = sentence;
                  j++;
                }
                i++;
              }
              for (var list in storyLists) {
                list.removeWhere((element) => element == null);
              }
              return BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5.0,
                  sigmaY: 5.0,
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      onClick = true;
                    });
                  },
                  child: onClick == true
                      ? Container()
                      : Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              color: Colors.transparent,
                            ),

                            //Speech bubble
                            Positioned(
                              top: -60,
                              left: 120,
                              child: Container(
                                height: 500,
                                width: 650,
                                child: FadeIn(
                                  child: Image(
                                    image: AssetImage(
                                        'assets/images/main_game_screen_assets/speech bubble.png'),
                                    fit: BoxFit.contain,
                                  ),
                                  duration: Duration(milliseconds: 2500),
                                  curve: Curves.easeIn,
                                ),
                              ),
                            ),

                            //Text in speech bubble
                            Padding(
                              padding: const EdgeInsets.only(bottom: 100),
                              child: Center(
                                child: Container(
                                  width: 400,
                                  child: TyperAnimatedTextKit(
                                    speed: Duration(milliseconds: 55),
                                    isRepeatingAnimation: false,
                                    text: storyLists[levelIdx],
                                    textStyle: TextStyle(
                                        height: 0.9,
                                        color: Colors.black87,
                                        fontSize: 20.0),
                                    //repeatForever : false,
                                    //totalRepeatCount: 0,
                                    displayFullTextOnTap: true,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),

                            //Owl image
                            Positioned(
                              top: 270,
                              left: -10,
                              child: Container(
                                height: 210,
                                child: FadeIn(
                                  child: Image(
                                    image: AssetImage(
                                        'assets/images/main_game_screen_assets/owl.png'),
                                    fit: BoxFit.contain,
                                  ),
                                  duration: Duration(milliseconds: 2500),
                                  curve: Curves.easeIn,
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          });
    });
  }
}
