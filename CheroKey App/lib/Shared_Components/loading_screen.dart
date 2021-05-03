import 'dart:async';

import 'package:chero_key/src/start_screen.dart';
import 'package:chero_key/widgets/main_game_screen_background_widget.dart';
import 'package:flutter/material.dart';

import 'package:loading_animations/loading_animations.dart';
import 'package:loader_overlay/loader_overlay.dart';


class LoadingScreen extends StatelessWidget {

  bool load = true;
  @override

  Widget build(BuildContext context) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: LoaderOverlay(

          useDefaultLoading: false,
          child: Stack(
            children: <Widget>[
              GameBackgroundElements(),
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
                      ],
                    ),
                  ],
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
                padding: const EdgeInsets.only(top: 103, left: 477),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 18,
                      child: Image(
                        image: AssetImage(
                            'assets/images/main_game_screen_assets/exit icon.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
              /*Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/loading_screen/loading.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),*/

              Positioned(
                child: Container(
                  child: LoadingDoubleFlipping.square(
                    size: 35,
                    backgroundColor: Colors.lightGreen,
                  ),
                ),
              ),
            ],

          ),
        ),
      );
  }
}