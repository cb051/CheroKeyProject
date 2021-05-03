import 'package:flutter/material.dart';
import 'package:chero_key/service/game_and_level_data.dart';
import 'package:chero_key/game_engine/mix_and_match.dart';
import 'package:chero_key/game_engine/question_answer.dart';
import 'package:provider/provider.dart';
import 'dart:math';


class GameEngine extends StatelessWidget {
  Widget chooseRandomGame() {
    List choices = [
      QuestionAnswer(),
      MixAndMatch(),
    ];
    var rand = new Random().nextInt(2);
    return choices[rand];
    // return QuestionAnswer();
    // return MixAndMatch();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameAndLevelData>(builder: (context, data, child) {
      return chooseRandomGame();
    });
  }
}
