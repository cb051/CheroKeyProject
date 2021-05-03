import 'package:flutter/material.dart';

//background elements used in main_game_screen.dart
class GameBackgroundElements extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //Background
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/main_game_screen_assets/main game screen wooden bg.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),

        //Rubik Cube
        Positioned(
          top: -52,
          right: -46,
          child: Container(
            width: 200,
            height: 200,
            child: Image(
              image: AssetImage(
                  'assets/images/main_game_screen_assets/rubik bg.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),

        //Books top left
        Positioned(
          child: Container(
            width: 213,
            child: Image(
              image: AssetImage(
                  'assets/images/select_level_assets/select world books.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),

        //Paper on the left side
        Positioned(
          top: 39,
          child: Container(
            width: 90,
            child: Image(
              image: AssetImage(
                  'assets/images/main_game_screen_assets/paper bg.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),

        //Paper clip on the bottom left side
        Positioned(
          bottom: 95,
          left: -30,
          child: Container(
            width: 69,
            child: Image(
              image: AssetImage(
                  'assets/images/main_game_screen_assets/start screen clip2.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),

        //Letter T
        Positioned(
          top: 83,
          right: -25,
          child: Container(
            width: 90,
            height: 90,
            child: Image(
              image: AssetImage('assets/images/select_level_assets/t bg.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),

        //Book at bottom right bg
        Positioned(
          bottom: -5,
          right: -80,
          child: Container(
            width: 250,
            height: 250,
            child: Image(
              image: AssetImage(
                  'assets/images/main_game_screen_assets/book bg.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),

        //Paper clip bottom right
        Positioned(
          bottom: -15,
          right: 8,
          child: Container(
            width: 75,
            height: 75,
            child: Image(
              image: AssetImage(
                  'assets/images/main_game_screen_assets/main game screen clip2.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),

        //Background shadow
        Container(
          child: Image(
            width: 900,
            image: AssetImage(
                'assets/images/flashcard_assets/main flashcard background shadow.png'),
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }
}
