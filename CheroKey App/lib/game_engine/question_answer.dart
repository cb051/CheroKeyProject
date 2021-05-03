import 'package:chero_key/service/game_and_level_data.dart';
import 'package:chero_key/Shared_Components/level_complete_overlay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';


List<Widget> _answerIcons = List.filled(10, Container());

class QuestionAnswer extends StatefulWidget {
  @override
  _QuestionAnswerState createState() => _QuestionAnswerState();
}

class _QuestionAnswerState extends State<QuestionAnswer> {
  // used to set popup dialog and 'x'/'check' button at bottom of screen
  bool isCorrect(String chosen, String correctAnswer, int index) {
    if (chosen == correctAnswer) {
      _answerIcons[index] = Center(
        child: Container(
          width: 20,
          child: Image(
            image: AssetImage(
                'assets/images/main_game_screen_assets/correct check mark.png'),
            fit: BoxFit.contain,
          ),
        ),
      );
      context.read<GameAndLevelData>().setGameCounterIcon = _answerIcons[index];
      return true;
    } else {
      _answerIcons[index] = Center(
        child: Container(
          width: 20,
          child: Image(
            image: AssetImage(
                'assets/images/main_game_screen_assets/wrong answer.png'),
            fit: BoxFit.contain,
          ),
        ),
      );
      context.read<GameAndLevelData>().setGameCounterIcon = _answerIcons[index];
      return false;
    }
  }

  List setChoices(Map info) {
    print("INFO: $info");
    List answers = List.filled(4, "");
    var length = info.length;

    // set answers
    var rand = new Random().nextInt(4);
    answers[rand] = info["answer"];
    answers[(rand + 1) % 4] = info["incorrect"][0]["english"];
    answers[(rand + 2) % 4] = info["incorrect"][1]["english"];
    answers[(rand + 3) % 4] = info["incorrect"][2]["english"];
    return answers;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameAndLevelData>(builder: (context, gData, child) {
      // get data that user orignally set when clicking on a world
      String _colorPath = gData.getColorPath();
      String _iconPath = gData.getIconPath();
      int _levelNumber = gData.getLevelNumber();
      int _questionNumber = gData.getQuestionNumber();

      // Get question and answer data
      List qaInfo = gData.getQuestionAnswerCategoryInfo();
      String _questionText = qaInfo[gData.getWidgetIndex()]["question"];
      List _buttonText = setChoices(qaInfo[gData.getWidgetIndex()]);
      gData.setAnswer = qaInfo[gData.getWidgetIndex()]["answer"];

      return Stack(
        children: [
          //Main NoteBook
          Positioned(
            top: 2,
            left: -30,
            right: 30,
            bottom: 2,
            child: Container(
              child: Image(
                image: AssetImage(
                    'assets/images/main_game_screen_assets/game screen notebook.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),

          //Game screen background on notebook
          Padding(
            padding: const EdgeInsets.only(right: 10, bottom: 15),
            child: Center(
              child: Container(
                width: 380,
                child: Image(
                  image: AssetImage(
                      'assets/images/main_game_screen_assets/game screen bottom.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          //Paper at the top left of notebook
          Padding(
            padding: const EdgeInsets.only(top: 32, right: 352),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    //Paper
                    Container(
                      width: 112,
                      child: Image(
                        image: AssetImage(
                            'assets/images/main_game_screen_assets/catogory paper.png'),
                        fit: BoxFit.contain,
                      ),
                    ),

                    //Paper color background
                    Padding(
                      padding: const EdgeInsets.only(bottom: 11),
                      child: RotationTransition(
                        turns: new AlwaysStoppedAnimation(-5 / 360),
                        child: Container(
                          width: 80,
                          child: Image(
                            image: AssetImage(_colorPath),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),

                    //Paper Icon on color background
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: RotationTransition(
                        turns: new AlwaysStoppedAnimation(-4 / 360),
                        child: Container(
                          width: 45,
                          child: Image(
                            image: AssetImage(_iconPath),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 102, left: 5),
                      child: Container(
                        child: Text(
                          'Question ' + _questionNumber.toString(),
                          style: TextStyle(
                              color: Color.fromRGBO(221, 187, 134, 1),
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        transform: Matrix4.rotationZ(-0.11),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          //Text on clip on top of the notebook
          Padding(
            padding: const EdgeInsets.only(top: 40, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    'Level ' + "$_levelNumber",
                    style: TextStyle(
                        color: Color.fromRGBO(211, 232, 254, 1), fontSize: 18),
                  ),
                ),
              ],
            ),
          ),

          //Text in the game screen background on notebook
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 140.0, left: 30.0),
              child: Container(
                width: 250.0,
                height: 40.0,
                child: AutoSizeText(
                  _questionText + " ?",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  maxLines: 2,
                ),
              ),
            ),
          ),

          // Checkboxes at the bottom of notebook
          Padding(
            padding: const EdgeInsets.only(top: 295, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 400.0,
                  height: 400.0,
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 10,
                          crossAxisSpacing: 0.0,
                          mainAxisSpacing: 0.0,
                          mainAxisExtent: 30.0),
                      itemCount: 10,
                      padding: const EdgeInsets.only(right: 15, left: 15),
                      itemBuilder: (BuildContext context, int item) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 30,
                              child: Image(
                                image: AssetImage(
                                    'assets/images/main_game_screen_assets/game screen counter.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                            // shows Icon at bottom of screen for whether answer is correct
                            gData.getGameCounterIcons()[item],
                          ],
                        );
                      }),
                ),
              ],
            ),
          ),

          //Red bookmark
          Padding(
            padding: const EdgeInsets.only(top: 95, left: 475),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 27,
                  child: Image(
                    image: AssetImage(
                        'assets/images/main_game_screen_assets/bookmark exit.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),

          //Red bookmark exit icon
          Padding(
            padding: const EdgeInsets.only(top: 88, left: 477),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    _answerIcons = List.filled(10, Container());
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 18,
                    child: Image(
                      image: AssetImage(
                          'assets/images/main_game_screen_assets/exit icon.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // BUTTONS
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, right: 20),
              child: Container(
                width: 340.0,
                height: 100.0,
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 7.0,
                        mainAxisExtent: 45.0),
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int item) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            child: Image(
                              image: AssetImage(
                                  'assets/images/main_game_screen_assets/green long button.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              bool result = isCorrect(_buttonText[item],
                                  gData.getAnswer(), gData.getWidgetIndex());
                              if (result == true) {
                                gData.incrementCorrectAnswers();
                              }
                              if (gData.getWidgetIndex() >= 9) {
                                _answerIcons =
                                    List.filled(10, Container()); //reset
                                gData.resetWidget();
                                gData.resetCorrectAnswers();
                                // answer was clicked. show popup on whether answer is correct
                                Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      opaque: false,
                                      pageBuilder:
                                          (BuildContext context, _, __) {
                                        return LevelCompleteOverlay();
                                      },
                                    ));
                              }
                              else {
                                // choose another randomGame
                                // 'newWidget' redraws the center game widget
                                gData.newWidget();
                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 5, left: 10),
                              child: Container(
                                width: 125,
                                child: Text(
                                  _buttonText[item],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ),
        ],
      );
    });
  }
}

class BottomIconList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameAndLevelData>(
      builder: (context, data, child) {
        return Container(child: _answerIcons[data.getWidgetIndex()]);
      },
    );
  }
}
