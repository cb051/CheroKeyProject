import 'package:auto_size_text/auto_size_text.dart';
import 'package:chero_key/Shared_Components/level_complete_overlay.dart';
import 'package:chero_key/service/game_and_level_data.dart';
import 'package:chero_key/src/level_select_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

/*
DONE: get counter to update
DONE: get widget to update
TODO: mix order that cards on right are shown
DONE: make sure game fully resets each time
 */

class MixAndMatch extends StatefulWidget {
  @override
  _MixAndMatchState createState() => _MixAndMatchState();
}

// holds 10 sets of card text
List cards = [];
List rNums = List.filled(10, 0);
List cardText = [];
int cardsDragged = 0;

List setCards(List cardInfo) {
  List text = [];
  var rNum = new Random().nextInt(cardInfo.length);
  text.add(cardInfo[rNum]);
  text.add(cardInfo[(rNum + 1) % cardInfo.length]);
  text.add(cardInfo[(rNum + 2) % cardInfo.length]);
  text.add(cardInfo[(rNum + 3) % cardInfo.length]);

  return text;
}

List<bool> isCorrect = List.filled(4, false);
List iconsList = List.filled(10, Container());
// for counter
// Widget correctIcons(int index){
//   return iconsList
// }

class _MixAndMatchState extends State<MixAndMatch> {
  bool isLevelComplete = false;
  bool questionStarted = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // get data to place on cards
    List<Widget> answerIcons =
        context.read<GameAndLevelData>().getGameCounterIcons();
    var data = context.read<GameAndLevelData>();
    if (cardsDragged == 0 && !questionStarted) {
      isCorrect = List.filled(4, false);
      List cardInfo = data.getMixAndMatchCategoryInfo();
      cardText = setCards(cardInfo);
    }
    if (isLevelComplete) {
      cardsDragged = 0;
    }

    // print(cardInfo);
    // print(cards[data.getWidgetIndex()]);

    return Consumer<GameAndLevelData>(
      builder: (context, data, child) => Stack(
        children: [
          // back button
          Positioned(
            top: 20.0,
            left: 20.0,
            child: GestureDetector(
              onTap: () {
                cards = [];
                answerIcons = [];
                cardsDragged = 0;
                isCorrect = List.filled(4, false);
                // reset details on game widgets
                data.resetWidget();
                questionStarted = false;
                isLevelComplete = false;
                Navigator.popUntil(
                    context, ModalRoute.withName('level_select_screen'));
              },
              child: Container(
                child: Image.asset(
                  "assets/images/select_level_assets/back arrow.png",
                  scale: 3,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // center cards (CONTENT)
              Flexible(
                flex: 6,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 2,
                        fit: FlexFit.loose,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Container(
                            height: 300.0,
                            width: 250.0,
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 130.0,
                                crossAxisSpacing: 30.0,
                                mainAxisSpacing: 30.0,
                              ),
                              itemCount: 4,
                              itemBuilder: (BuildContext context, int item) {
                                return Draggable<String>(
                                  data: cardText[item]["english"],
                                  onDragCompleted: () {
                                    // used to redraw widget when a correct card has been matched
                                    setState(() {});
                                    questionStarted = true;
                                    if (cardsDragged == 4) {
                                      data.incrementCorrectAnswers();
                                      questionStarted = false;
                                      var icon = Center(
                                        child: Container(
                                          width: 20,
                                          child: Image(
                                            image: AssetImage(
                                                'assets/images/main_game_screen_assets/correct check mark.png'),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      );
                                      data.setGameCounterIcon = icon;
                                      if (data.getWidgetIndex() >= 9) {
                                        isLevelComplete = true;
                                        // reset data on counter
                                        data.resetWidget();
                                        data.resetCorrectAnswers();
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              opaque: false,
                                              pageBuilder:
                                                  (BuildContext context, _, __) {
                                                return LevelCompleteOverlay();
                                              },
                                            ));
                                      } else {
                                        cardsDragged = 0;
                                        isCorrect = List.filled(4, false);
                                        // print("new widget");
                                        data.newWidget();
                                      }
                                    }
                                  },
                                  child: isCorrect[item]
                                      ? Container(
                                          width: 110.0,
                                          color: Colors.black12,
                                        )
                                      : Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Image(
                                              image: AssetImage(
                                                  "assets/images/main_game_screen_assets/category paper small.png"),
                                              fit: BoxFit.contain,
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(left: 5),
                                              width: 90,
                                              child: AutoSizeText(
                                                cardText[item]["cherokee"],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 30.0,
                                                ),
                                                wrapWords: false,
                                                softWrap: true,
                                              ),
                                            ),
                                          ],
                                        ),
                                  feedback: Container(
                                      width: 110.0,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Image.asset(
                                              "assets/images/main_game_screen_assets/category paper small.png"),
                                          Material(
                                              color: Colors.transparent,
                                              child: Container(
                                                padding: const EdgeInsets.only(left: 5),
                                                width: 90,
                                                child: AutoSizeText(
                                                  cardText[item]["cherokee"],
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 30.0,
                                                  ),
                                                  wrapWords: false,
                                                  softWrap: true,
                                                )),
                                          ),
                                        ],
                                      )),
                                  childWhenDragging: Container(
                                    width: 80.0,
                                    height: 100.0,
                                    color: Colors.black12,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),

                      //Level and Question on top center
                      Flexible(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            // color: Colors.blue,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                AutoSizeText("Level ${data.getLevelNumber()}",
                                    style: TextStyle(
                                        color: Colors.white30, fontSize: 40.0)),
                                AutoSizeText(
                                    "Question ${data.getQuestionNumber()}",
                                    style: TextStyle(color: Colors.white30)),
                              ],
                            ),
                          ),
                        ),
                      ),

                      //Dark boxes on the right of the screen
                      Flexible(
                        flex: 2,
                        fit: FlexFit.loose,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Container(
                            height: 300.0,
                            width: 250.0,
                            child: GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 130.0,
                                crossAxisSpacing: 30.0,
                                mainAxisSpacing: 30.0,
                              ),
                              itemCount: 4,
                              itemBuilder: (BuildContext context, int item) {
                                return DragTarget<String>(
                                  onAccept: (value) {
                                    if (value == cardText[item]["english"]) {
                                      isCorrect[item] = true;
                                      cardsDragged++;
                                    }
                                  },
                                  builder: (BuildContext context, List<dynamic> placeHolderA,
                                      List<dynamic> placeHolderB) {
                                    return Container(
                                      child: isCorrect[item]
                                          //Card when in the black boxes
                                          ? Container(
                                              width: 100.0,
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Image.asset(
                                                      "assets/images/main_game_screen_assets/category paper small.png"),
                                                  Material(
                                                      color: Colors.transparent,
                                                      child: Container(
                                                        padding: const EdgeInsets.only(left: 5),
                                                        width: 90,
                                                        child: AutoSizeText(
                                                          cardText[item]["cherokee"],
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 30.0,
                                                          ),
                                                          wrapWords: false,
                                                          softWrap: true,
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            )
                                            //Text in black boxes
                                          : Container(
                                              color: Colors.black54,
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(3.0),
                                                  child: AutoSizeText(
                                                    cardText[item]["english"],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 30.0),
                                                    wrapWords: false,
                                                    softWrap: false,
                                                  ),
                                                ),
                                              ),
                                            ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              //  on screen counter
              Flexible(
                flex: 1,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Container(
                        width: 500.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                          width: 470.0,
                          height: 40.0,
                          child: GridView.builder(
                              itemCount: 10,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 10),
                              itemBuilder: (BuildContext context, int item) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        child: Image.asset(
                                            "assets/images/main_game_screen_assets/game screen counter.png"),
                                      ),
                                      data.getGameCounterIcons()[item],
                                    ],
                                  ),
                                );
                              })),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
