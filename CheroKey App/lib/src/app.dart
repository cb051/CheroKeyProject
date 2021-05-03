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

import 'package:chero_key/service/our_data_model.dart';
import 'package:chero_key/service/story_entity.dart';
import 'package:chero_key/Shared_Components/create_set_flashcard_overlay.dart';
import 'package:chero_key/Shared_Components/flashcard_grid_view.dart';
import 'package:chero_key/src/start_screen.dart';
import 'package:chero_key/Shared_Components/create_flashcards_overlay.dart';
import 'package:chero_key/Shared_Components/level_complete_overlay.dart';
import 'package:chero_key/src/world_screen.dart';
import 'package:flutter/material.dart';
import 'package:chero_key/src/level_select_screen.dart';
import 'package:chero_key/src/main_game_screen.dart';
import 'package:chero_key/service/data_model_example.dart';
import 'package:chero_key/service/story_test.dart';
import 'package:provider/provider.dart';
import 'package:chero_key/Flashcard/main_flashcard_screen.dart';
import 'package:chero_key/Flashcard/Set_Selector_Screen.dart';
import 'package:chero_key/service/game_and_level_data.dart';

class CheroKey extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OurDataModel()),
        ChangeNotifierProvider(create: (_) => StoryEntity()),
        ChangeNotifierProvider(create: (_) => GameAndLevelData()),
      ],
      child: MaterialApp(
         home: StartScreen(),
        // home: DataModelExample(),
        // initialRoute: StartScreen.route,
        initialRoute: StartScreen.route,
          routes: {
            WorldScreen.route: (context) => WorldScreen(),
            LevelSelectScreen.route: (context) => LevelSelectScreen(),
            MainGameScreen.route: (context) => MainGameScreen(),
            MainFlashcardScreen.route: (context) => MainFlashcardScreen(),
            SetSelectorScreen.route: (context) => SetSelectorScreen(),
            CreateSetOverlay.route: (context) => CreateSetOverlay(),
            CreateFlashCardOverlay.route: (context) => CreateFlashCardOverlay(setID: '0',),
            FlashCardGridView.route: (context) => FlashCardGridView(setID: "0",),
            DataModelExample.route: (context) => DataModelExample(),
            LevelCompleteOverlay.route: (context) => LevelCompleteOverlay(),
          },
        theme: ThemeData(fontFamily: "Roboto Medium"),
      ),
    );
  }
}
