// Copyright 2020 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:chero_key/service/game_and_level_data.dart';
import 'package:chero_key/src/start_screen.dart';
import 'package:chero_key/src/main_game_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LevelSelectScreen extends StatefulWidget {
  static const route = 'level_select_screen';

  @override
  _LevelSelectScreenState createState() => _LevelSelectScreenState();
}

class _LevelSelectScreenState extends State<LevelSelectScreen> {
  // vars used througout game
  String _worldInfo;
  String _colorPath;
  String _iconPath;
  // int _levelNumber;
  // int _questionNumber;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Consumer<GameAndLevelData>(builder: (context, data, child) {
      // use data previously set in world screen
      _worldInfo = data.getWorldInfo();
      _colorPath = data.getColorPath();
      _iconPath = data.getIconPath();
      //_worldInfo.replaceAll(new RegExp(r"\s+"), "");
      // _questionNumber = data.getQuestionNumber();
      // _levelNumber = data.getLevelNumber();

      return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              //Background
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/wooden bg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              //Rubik Cube
              Positioned(
                top: -52,
                right: -52,
                child: Container(
                  width: 195,
                  height: 176,
                  child: Image(
                    image: AssetImage(
                        'assets/images/main_game_screen_assets/rubik bg.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              //Books top left
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: 214,
                  child: Image(
                    image: AssetImage(
                        'assets/images/select_level_assets/select world books.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              //Paper Clip on left side bg
              Positioned(
                top: 73,
                left: -35,
                child: Container(
                  width: 65,

                  child: Image(
                    image: AssetImage(
                        'assets/images/main_game_screen_assets/start screen clip2.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              //Eraser
              Positioned(
                top: 235,
                left: 0,
                child: Container(
                  width: 60,
                  height: 71,
                  child: Image(
                    image: AssetImage(
                        'assets/images/select_world_assets/eraser.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              //Letter T
              Positioned(
                top: 120,
                right: -3,
                child: Container(
                  width: 87,
                  height: 86,
                  child: Image(
                    image: AssetImage(
                        'assets/images/select_level_assets/t bg.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              //Letter A
              Positioned(
                top: 204,
                right: -12,
                child: Container(
                  width: 89,
                  child: Image(
                    image: AssetImage(
                        'assets/images/select_level_assets/a bg.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              //Book at bottom right bg
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 101,
                  height: 128,
                  child: Image(
                    image: AssetImage(
                        'assets/images/select_level_assets/book bg.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              //Main Book
              Padding(
                padding: EdgeInsets.only(
                  right: 35,
                  bottom: 5
                ),
                child: Container(
                  width: 670,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image(
                        image: AssetImage(
                            'assets/images/select_level_assets/category book full.png'),
                        fit: BoxFit.contain,
                      ),

                      //Category Paper on main book
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 90,
                          right: 262,
                        ),
                        child: Container(
                          width: 214,
                          height: 260,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image(
                                image: AssetImage(
                                    'assets/images/select_level_assets/catogory paper.png'),
                                fit: BoxFit.contain,
                              ),

                              //Category Color on category paper
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20,right: 5),
                                child: RotationTransition(
                                  turns: new AlwaysStoppedAnimation(-6 / 360),
                                  child: Container(
                                    width: 147,
                                    child: Image(
                                      image: AssetImage(_colorPath),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),

                              //Category Text on category paper
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 33, left: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        RotationTransition(
                                          turns: new AlwaysStoppedAnimation(
                                              -7 / 360),
                                          child: Text(
                                            _worldInfo,
                                            style: TextStyle(
                                              color: Colors.brown,
                                              fontSize: 12,
                                              fontFamily: 'Roboto Black',

                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              //Category Icon on category color
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: 20,
                                ),
                                child: Container(
                                  width: 90,
                                  height: 124,
                                  child: Image(
                                    image: AssetImage(_iconPath),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      //Category Paper Clip on category color and paper
                      Padding(
                        padding: const EdgeInsets.only(right: 205, top: 15),
                        child: Column(
                          children: [
                            Container(
                              width: 31,
                              height: 63,
                              child: Image(
                                image: AssetImage(
                                    'assets/images/select_level_assets/category clip on paper.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),

                      //Paper Clip on bottom left corner of main book
                      Padding(
                        padding: const EdgeInsets.only(left: 54, bottom: 84),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: 76,
                                  height: 40,
                                  child: Image(
                                    image: AssetImage(
                                        'assets/images/select_level_assets/category clip on book.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      //Orange bookmark
                      Padding(
                        padding: const EdgeInsets.only(right: 335,bottom: 4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 107,
                                  height: 59,
                                  child: Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      Image(
                                        image: AssetImage(
                                            'assets/images/select_level_assets/bookmark category.png'),
                                        fit: BoxFit.contain,
                                      ),
                                      //Back Button on orange bookmark
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 22),
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.maybePop(context);
                                          },
                                          child: Container(
                                            width: 35,
                                            height: 25,
                                            child: Image(
                                              image: AssetImage(
                                                  'assets/images/select_level_assets/back arrow.png'),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      //Red Bookmark
                      Padding(
                        padding: const EdgeInsets.only(right: 165,bottom: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 109,
                                  height: 66,
                                  child: Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      Image(
                                        image: AssetImage(
                                            'assets/images/select_level_assets/bookmark red.png'),
                                        fit: BoxFit.contain,
                                      ),
                                      //Home Button on red bookmark
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, StartScreen.route);
                                          },
                                          child: Container(
                                            width: 33,
                                            height: 29,
                                            child: Image(
                                              image: AssetImage(
                                                  'assets/images/select_level_assets/home button.png'),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                /*Center(
                  child: RotationTransition(
                    turns: new AlwaysStoppedAnimation(-7 / 360),
                    child: Text(
                      _worldInfo,
                      style: TextStyle(
                        color: Colors.brown,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),*/
              ),

              //Top Shadow
              Positioned(
                top: -80,
                left: 0,
                child: Container(
                  width: 960,
                  height: 223,
                  child: Image(
                    image: AssetImage(
                        'assets/images/start_screen_assets/start screen top shadow.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              //Levels Text
              Padding(
                padding: const EdgeInsets.only(left: 280,bottom: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Levels",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Roboto Black',
                          ),
                        ),

                        // Levels
                        Container(
                          width: 200.0,
                          height: 250.0,
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 15.0,
                              mainAxisSpacing: 5.0,
                              mainAxisExtent:
                                  80.0, //sets the height of each item in grid
                            ),
                            itemCount:
                                9, //NOTE: this might change based on level
                            itemBuilder: (BuildContext context, itemCount) {
                              return GestureDetector(
                                onTap: () {
                                  data.setLevelNumber = itemCount + 1;
                                  data.resetWidget(); //initializes level to the beginning
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainGameScreen()),
                                  );
                                },
                                child: Container(
                                  child: Stack(
                                    children: [
                                      Image(
                                        image: AssetImage(
                                            'assets/images/select_level_assets/level for level selection2.png'),
                                        fit: BoxFit.contain,
                                      ),

                                      Positioned(
                                        top: 6.0,
                                        left: 25.0,
                                        child: Text(
                                          "${itemCount + 1}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),

                                      // 3 STARS
                                     /* GridView.builder(
                                                  padding:
                                                  EdgeInsets.only(left: 2.5, top: 55.0),
                                                  gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3,
                                                    crossAxisSpacing: 1.0,
                                                    mainAxisSpacing: 1.0, //sets spacing bt stars
                                                    mainAxisExtent: 13.0, //sets the size of each star
                                                  ),
                                                  itemCount: 3,
                                                  itemBuilder:
                                                      (BuildContext context, int itemCount) {
                                                    return Container(
                                                      child: Image(
                                                        image: AssetImage(
                                                            'assets/images/select_level_assets/star empty.png'),
                                                        fit: BoxFit.contain,
                                                      ),
                                                    );
                                                  }),*/
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ));
    });
  }
}
