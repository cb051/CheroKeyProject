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

// import 'package:chero_key/Shared_Components/overlay.dart';
import 'package:chero_key/Shared_Components/overlay.dart';
import 'package:chero_key/service/game_and_level_data.dart';
import 'package:chero_key/game_engine/game_engine.dart';
import 'package:chero_key/service/our_data_model.dart';
import 'package:chero_key/widgets/main_game_screen_background_widget.dart';
// import 'package:chero_key/src/level_select_screen.dart';

import 'package:chero_key/Shared_Components/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'dart:async';
import 'dart:math';

class MainGameScreen extends StatelessWidget {
  static const route = 'main_game_screen';

  // set data for all 10 games
  List randomAnswers(List incorrect) {
    List incorrectAnswers = [];
    var rand = new Random().nextInt(incorrect.length);
    for (int i = 0; i < 3; i++) {
      incorrectAnswers
          .add(incorrect[(rand + i) % (incorrect.length)]['english']);
    }
    return incorrectAnswers;
  }

  List setQAQuestions(List questions, List incorrectAnswers) {
    /* for each level choose:
          (1) 10 random questions and their corresponding answers
          (2) 10 sets of 3 incorrect answers
    */
    int indexForQuestions = 0;
    List rand = [];
    // TODO: add checks here for difficulty level etc.
    while (indexForQuestions < 10) {
      var rNum = new Random().nextInt(questions.length);
      if (questions[rNum]["categories"].contains("question-answer")) {
        rand.add(rNum);
        indexForQuestions++;
      }
    }
    List<Map> qaInfo = [];
    for (int i = 0; i < 10; i++) {
      // (1) choose 10 random answers and their corresponding answers
      var levelInfo = {
        "question": "",
        "answer": "",
        "incorrect": ["", "", ""]
      };

      levelInfo["question"] = questions[rand[i]]["question"];
      levelInfo["answer"] = questions[rand[i]]["answer"];

      // (2) choose 10 sets of incorrect answers
      List wrongAnswers = [];
      for (int j = 0; j < 3; j++) {
        var rand = new Random().nextInt(incorrectAnswers.length);
        wrongAnswers.add(incorrectAnswers[rand]);
      }
      levelInfo["incorrect"] = wrongAnswers;
      qaInfo.add(levelInfo);
    }
    return qaInfo;
  }

  List setMaMQuestions(List questions) {
    //print("SET MAM CALLED");
    /*
    for each level choose:
        (1) 10 sets of 4 containing cherokee/english words/phrases
     */
    int indexForQuestions = 0;
    List cards = [];
    // TODO: add checks here for difficulty level etc.
    while (indexForQuestions < questions.length) {
      if (questions[indexForQuestions]["categories"]
          .contains("mix-and-match")) {
        cards.add(
            indexForQuestions); // adds the number for a mix and match category card
      }
      indexForQuestions++;
    }
    List mMInfo = [];
    for (int i = 0; i < cards.length; i++) {
      // (1) choose 10 random answers and their corresponding answers
      var levelInfo = {"cherokee": "", "english": ""};

      levelInfo["cherokee"] = questions[cards[i]]["question"];
      levelInfo["english"] = questions[cards[i]]["answer"];

      mMInfo.add(levelInfo);
    }
    return mMInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OurDataModel>(builder: (context, data2, child) {
      var gameData = context.read<GameAndLevelData>();
      data2.worldName = gameData
          .getWorldInfo()
          .replaceAll(' ', ''); //Takes out all the spaces from world info
      return FutureBuilder(
          future: Future.wait([data2.questionData, data2.randomAnswers]),
          builder: (context, info) {
            if (info.hasData) {
              // data should only be set once per level
              if (gameData.getWidgetIndex() == 0) {
                gameData.setCorrectAnswers = 0;
                gameData.setQuestionAnswerCategoryInfo =
                    setQAQuestions(info.data[0], info.data[1]);

                gameData.setMixAndMatchCategoryInfo =
                    setMaMQuestions(info.data[0]);
              }

              return Scaffold(
                resizeToAvoidBottomInset: false,
                body: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    GameBackgroundElements(), // background
                    GameEngine(),
                     if (gameData.getQuestionNumber() == 1)
                     TitleOverlay(
                       levelNumber: gameData.getLevelNumber(),
                       worldInfo: gameData.getWorldInfo().replaceAll(' ', ''),
                     ),
                  ],
                ),
              );
            } else {
              return LoadingScreen();
            }
          });
    });
  }
}
