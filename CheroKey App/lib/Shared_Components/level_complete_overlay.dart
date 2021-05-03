import 'dart:ui';
import 'package:chero_key/Shared_Components/flashcard_grid_view.dart';
import 'package:chero_key/Shared_Components/textfield_overlay.dart';
import 'package:chero_key/Database_sqlite/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:chero_key/service/game_and_level_data.dart';
import 'package:chero_key/src/level_select_screen.dart';
import 'package:provider/provider.dart';

//Class for creating flashcards
//Used by grid view
class LevelCompleteOverlay extends StatefulWidget {
  static const route = '/level_complete_overlay';

  @override
  _LevelCompleteOverlayState createState() => _LevelCompleteOverlayState();
}

class _LevelCompleteOverlayState extends State<LevelCompleteOverlay> {

  // Clean up the controller when the widget is disposed.
  @override
  void dispose() {
    super.dispose();
  }

  //This sets the initial value of the text fields
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<GameAndLevelData>(builder: (context, data, child) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5.0,
            sigmaY: 5.0,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              //NoteBook back
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 22),
                  child: Container(
                    width: 440,
                    child: Image(
                      image: AssetImage(
                          'assets/images/flashcard_assets/Small Notebook back.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              //Red bookmark
              Padding(
                padding: const EdgeInsets.only(left: 400, top: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Container(
                            width: 38,
                            child: Image(
                              image: AssetImage(
                                  'assets/images/main_game_screen_assets/bookmark exit.png'),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),

                        //Red bookmark exit icon
                        Padding(
                          padding: const EdgeInsets.only(bottom: 7, right: 6),
                          child: IconButton(
                            onPressed: () {
                              Navigator.popUntil(
                                  context,
                                  ModalRoute.withName(
                                      LevelSelectScreen.route));
                            },
                            //Exit icon image
                            icon: Container(
                              width: 24,
                              child: Image(
                                image: AssetImage(
                                    'assets/images/main_game_screen_assets/exit icon.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              //Main NoteBook paper
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                  width: 380,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image(
                        image: AssetImage(
                            'assets/images/main_game_screen_assets/level complete notebook paper.png'),
                        fit: BoxFit.contain,
                      ),

                      //Icon on green ribbon
                      Padding(padding: const EdgeInsets.only(bottom: 100),
                      child: Container(
                        width: 115,
                        child: Image(
                          image: AssetImage(
                            data.getIconPath(),
                          ),
                        ),
                      ),
                      ),

                      //Percent correct
                      Padding(padding: const EdgeInsets.only(left: 20, top: 100),
                        child: Text(
                          (data.getGrade()).toString() + "%",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                    ],
                  )
                ),
              ),

              //Orange button
              Padding(
                padding: const EdgeInsets.only(bottom: 40, right: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/main_game_screen_assets/level complete orange button.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.popUntil(
                              context,
                              ModalRoute.withName(
                                  LevelSelectScreen.route));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20,bottom: 5),
                          child: Container(
                            child: Text(
                              "Done",
                              style: TextStyle(color: Colors.white, fontSize: 18,),
                            ),
                          ),
                        ),
                      ),
                      /*child: Image(
                          image: AssetImage(
                              'assets/images/main_game_screen_assets/level complete orange button.png'),
                          fit: BoxFit.fitHeight,
                        ),*/
                    ),

                    //Orange button text

                  ],
                ),
              ),

              //Text on top green ribbon
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 10),
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Level Complete",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),

            ],
          ),
        ),
      );
    });

  }
}
