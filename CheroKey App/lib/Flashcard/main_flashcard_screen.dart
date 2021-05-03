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

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:chero_key/Database_sqlite/database_helper.dart';
import 'package:chero_key/Shared_Components/loading_screen.dart';


//Class for the main flashcard screen
class MainFlashcardScreen extends StatefulWidget {
  static const route = '/main_flashcard_screen';
  final String setID; //Set ID of selected set
  final cardID; //Card ID of selected card
  final initialCardIndex; //Index of selected card, used to initialize state

  // Setters
  MainFlashcardScreen({
    Key key,
    this.setID,
    this.cardID,
    this.initialCardIndex,
  }) : super(key: key);

  @override
  _MainFlashcardScreenState createState() => _MainFlashcardScreenState();
}

class _MainFlashcardScreenState extends State<MainFlashcardScreen> {
  FlashCardSet set; //Used to store set data from database
  int cardIndex; //Used to update index of current card for display

  @override
  void initState() {
    cardIndex = widget.initialCardIndex + 1;
    super.initState();
  }

  //Callback from FlashCardCarousel
  //Used to update index of current card for display
  callback(int index) {
    setState(() {
      cardIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    //This future builder returns the scaffold for the screen
    return FutureBuilder<FlashCardSet>(
        //Gets set info with the setID
        future: DBProvider.instance.getSetByID(widget.setID),
        builder: (BuildContext context, AsyncSnapshot<FlashCardSet> snapshot) {
          if (snapshot.hasData) {
            set = snapshot.data;
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: Stack(
                children: <Widget>[
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
                        image: AssetImage(
                            'assets/images/select_level_assets/t bg.png'),
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
                  Positioned(
                    child: Container(
                      child: Image(
                        width: 900,
                        image: AssetImage(
                            'assets/images/flashcard_assets/main flashcard background shadow.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),

                  //Main NoteBook back
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 28, right: 60),
                      child: Container(
                        width: 440,
                        child: Image(
                          image: AssetImage(
                              'assets/images/flashcard_assets/Small Notebook back (with shadow).png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),

                  //Red bookmark
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 265, left: 360),
                      child: Container(
                        width: 38,
                        child: Image(
                          image: AssetImage(
                              'assets/images/main_game_screen_assets/bookmark exit.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),

                  //Red bookmark exit icon
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 272, left: 365),
                      child: IconButton(
                        onPressed: () {
                          Navigator.maybePop(context);
                        },
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
                  ),

                  //Main NoteBook paper
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 40, right: 15),
                      child: Container(
                        height: 370,
                        child: Image(
                          image: AssetImage(
                              'assets/images/flashcard_assets/Small Notebook paper.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),

                  //Text on clip on top of the notebook
                  Padding(
                    padding: const EdgeInsets.only(top: 35, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            set.title,
                            style: TextStyle(
                                color: Colors.white, fontSize: 22),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Carousel of flashcards
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: FlashCardCarousel(
                        setID: widget.setID,
                        cardID: widget.cardID,
                        callback: callback,
                      ),
                    ),
                  ),

                  //Card number at the bottom of notebook
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 270, right: 30),
                      child: Container(
                        child: Text(
                          'CARD # ' + cardIndex.toString(),
                          textAlign: TextAlign.center,
                          key: UniqueKey(),
                          style: TextStyle(color: Colors.black54, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}

//Class that contains the carousel used to display flashcards
class FlashCardCarousel extends StatefulWidget {
  final String setID; //Set ID of selected set
  final String cardID; //Card ID of selected card
  final Function(int) callback; //Callback function from MainFlashcardScreen

  //Setters
  FlashCardCarousel({
    Key key,
    this.setID,
    this.cardID,
    this.callback,
  }) : super(key: key);

  @override
  _FlashCardCarouselState createState() => _FlashCardCarouselState();
}

class _FlashCardCarouselState extends State<FlashCardCarousel> {
  List<Widget> _cards = <Widget>[]; //Holds FlipCard widgets for carousel
  int _cardsIndex; //Used with the onPageChanged property of carousel to update index of current card
  final CarouselController _controller =
      CarouselController(); //Controller for carousel

  @override
  Widget build(BuildContext context) {
    // This future builder returns the carousel of flashcards.
    // It assigns the values from the database to the properties of each FlipCard, and then adds them to _cards.
    return FutureBuilder<List<FlashCard>>(
      future: DBProvider.instance.getFlashCards(widget.setID),
      builder: (BuildContext context, AsyncSnapshot<List<FlashCard>> snapshot) {
        if (snapshot.hasData) {
          _cards = (snapshot.data
              .map((item) => Padding(
                padding: const EdgeInsets.only(right: 35),
                child: Container(
                      width: 320,
                      child: FlipCard(
                        direction: FlipDirection.VERTICAL,
                        front: Container(
                          width: 300,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/flashcard_assets/main game screen card.png'),
                              fit: BoxFit.contain,
                            ),
                          ),

                          //English term
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20, bottom: 10),
                              child: Container(
                                alignment: Alignment.center,
                                width: 280,
                                height: 150,
                                child: AutoSizeText(item.engTerm,
                                    textAlign: TextAlign.center,
                                    maxFontSize: 24,
                                    minFontSize: 14,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.0,
                                    )),
                              ),
                            ),
                          ),
                        ),
                        back: Container(
                          width: 300,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/flashcard_assets/main game screen card.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                          //Cherokee term
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20, bottom: 20),
                              child: Container(
                                alignment: Alignment.center,
                                width: 280,
                                height: 150,
                                child: AutoSizeText(item.crkTerm,
                                    textAlign: TextAlign.center,
                                    maxFontSize: 24,
                                    minFontSize: 14,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.0,
                                    )),
                              ),
                            ),
                          ),

                        ),
                      ),
                    ),
              ))
              .toList());

          //Get index of card by comparing the cardID of each card returned
          //from database to the cardID that was passed to widget class
          _cardsIndex = snapshot.data
              .indexWhere((element) => element.cardID == widget.cardID);

          return CarouselSlider(
            items: _cards,
            options: CarouselOptions(
                initialPage: _cardsIndex,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                height: 250.0,
                viewportFraction: 0.8,
                onPageChanged: (index, reason) {
                  widget.callback(index + 1);
                }),
            carouselController: _controller,
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
