import 'package:chero_key/Database_sqlite/database_helper.dart';
import 'package:chero_key/Shared_Components/create_set_flashcard_overlay.dart';
import 'package:chero_key/Shared_Components/flashcard_grid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chero_key/Shared_Components/loading_screen.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animations/loading_animations.dart';


//Class for the set select screen
class SetSelectorScreen extends StatefulWidget {
  static const String route = '/Set_Selector_Screen';

  @override
  _SetSelectorScreen createState() => _SetSelectorScreen();
}

class _SetSelectorScreen extends State<SetSelectorScreen> {
  @override
  Widget build(BuildContext context) {
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
                    'assets/images/select_world_assets/start screen top shadow.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),

          //Back arrow
          Positioned(
            child: Container(
              child: TextButton(
                onPressed: () {
                  Navigator.maybePop(context);
                },
                child: Image.asset(
                  'assets/images/select_world_assets/back arrow.png',
                  scale: 3.0,
                ),
              ),
            ),
          ),

          //Calls CardCarousel and positions it on top of the stack
          Center(
            child: CardCarousel(),
          ),
        ],
      ),
    );
  }
}

//Carousel for sets
class CardCarousel extends StatefulWidget {
  @override
  _CardCarouselState createState() => _CardCarouselState();
}

class _CardCarouselState extends State<CardCarousel> {
  final CarouselController _controller = CarouselController();
  List<Widget> _sets = <Widget>[];

  //Function for inserting the "+" card into the list of sets
  void _insertAddCard() {
    _sets.insert(
      0,
      GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              PageRouteBuilder(
                  settings: RouteSettings(name: "/flashcard_grid_view"),
                  opaque: false,
                  pageBuilder: (BuildContext context, _, __) {
                    return CreateSetOverlay();
                  },
                  transitionsBuilder:
                      (___, Animation<double> animation, ____, Widget child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  })).whenComplete(() => setState(() {}));
        },
        child: Center(
          child: Container(
            height: 270,
            width: 260,
            child: Image.asset(
              'assets/images/flashcard_assets/Add_Sets.png',
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Future is a list of sets
    //Builder creates a list of sets, where each element is a gesture detector
    return FutureBuilder<List<FlashCardSet>>(
      future: DBProvider.instance.getFlashCardSets(),
      builder:
          (BuildContext context, AsyncSnapshot<List<FlashCardSet>> snapshot) {
        if (snapshot.hasData) {
          _sets = (snapshot.data
              .map((item) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                              settings:
                                  RouteSettings(name: "/flashcard_grid_view"),
                              opaque: false,
                              pageBuilder: (BuildContext context, _, __) {
                                return FlashCardGridView(
                                  setID: item.setID,
                                  setTitle: item.title,
                                );
                              },
                              transitionsBuilder: (___,
                                  Animation<double> animation,
                                  ____,
                                  Widget child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              })).whenComplete(() => setState(() {}));
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        //Stack of cards
                        Container(
                          width: 260,
                          height: 270,
                          child: Image(
                            image: AssetImage(
                                'assets/images/flashcard_assets/card stack with delete button.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                        //Delete button
                        Positioned(
                          top: 5,
                          right: 15,
                          child: Center(
                            child: IconButton(
                              icon: Container(
                                width: 0,
                                height: 0,
                              ),
                              constraints: BoxConstraints(maxWidth: 50, maxHeight: 50),
                              onPressed: () {
                                return showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Discard Set?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('CANCEL'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              DBProvider.instance
                                                  .deleteFlashCardSetAt(item.setID);
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: Text('DISCARD'),
                                        ),
                                      ], // Actions
                                    );
                                  }, // Builder
                                ); // showDialog
                              }, // onPressed
                            ),
                          ),
                        ),

                        //Text on the cards
                        Padding(
                          padding: const EdgeInsets.only(left: 55),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(
                                  item.title,
                                  style: TextStyle(fontSize: 18, fontFamily: 'Roboto Black',),
                                ),
                              ),
                              Container(
                                child: Text(
                                  item.numCards.toString() + " cards",
                                  style: TextStyle(fontSize: 16, fontFamily: 'Roboto Black',),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList());

          //Adds the "+" card to carousel
          _insertAddCard();

          //Returns a carousel
          return CarouselSlider(
            items: _sets,
            options: CarouselOptions(
              initialPage: 1,
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
              height: 250.0,
              viewportFraction: 0.34,
            ),
            carouselController: _controller,
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
