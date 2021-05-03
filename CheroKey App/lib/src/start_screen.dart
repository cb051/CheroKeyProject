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

import 'package:chero_key/src/world_screen.dart';
import 'package:chero_key/Flashcard/Set_Selector_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StartScreen extends StatefulWidget {
  static const route = '/';

  StartScreen({Key key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  FirebaseFirestore firestore;
  List<bool> isSelected = List.generate(3, (index) => false);
  _StartScreenState() {
    firestore = FirebaseFirestore.instance;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/wooden bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          //Rubik Cube
          Positioned(
            left: 270,
            child: Container(
              height: 125,
              child: Image(
                image: AssetImage(
                    'assets/images/start_screen_assets/start screen rubik.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),

          //Books
          Positioned(
            child: Container(
              width: 350,
              height: 205,
              child: Image(
                image: AssetImage(
                    'assets/images/start_screen_assets/start screen books.png'),
                fit: BoxFit.scaleDown,
              ),
            ),
          ),

          //Paper Clip
          Positioned(
            top: 222,
            left: -55,
            child: Container(
              width: 100,
              height: 52,
              child: Image(
                image: AssetImage(
                    'assets/images/start_screen_assets/start screen clip2.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),

          //Pencils
          Positioned(
            top: 301,
            left: -112,
            child: Container(
              width: 295,
              height: 115,
              child: Image(
                image: AssetImage(
                    'assets/images/start_screen_assets/start screen pen.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),

          //Top Shadow
          Positioned(
            child: Container(
              child: Image(
                image: AssetImage(
                    'assets/images/start_screen_assets/start screen top shadow.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          //Title
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Center(
              child: Container(
                width: 574,
                child: Image(
                  image: AssetImage(
                      'assets/images/start_screen_assets/start screen title.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          //Story and Flashcard Buttons
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Story Button
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, WorldScreen.route);
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 110,
                          child: Image(
                            image: AssetImage(
                                'assets/images/start_screen_assets/play button for start screen.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                        Container(
                          child: Text(
                            'Story',
                            style: TextStyle(
                                color: Color.fromRGBO(190, 129, 70, 1)),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Flashcard Button
                  Padding(
                    padding: const EdgeInsets.only(left: 55),
                    child: TextButton(
                      onPressed: () {
                        //Navigator.pushNamed(context, MainFlashcardScreen.route);
                        Navigator.pushNamed(context, SetSelectorScreen.route);
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 110,
                            child: Image(
                              image: AssetImage(
                                  'assets/images/start_screen_assets/play button for start screen.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                          Container(
                            child: Text(
                              'Flashcard',
                              style: TextStyle(
                                  color: Color.fromRGBO(190, 129, 70, 1)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
