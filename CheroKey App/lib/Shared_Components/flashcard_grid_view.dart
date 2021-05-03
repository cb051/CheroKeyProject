import 'dart:ui';
import 'package:chero_key/Database_sqlite/database_helper.dart';
import 'package:chero_key/Shared_Components/create_flashcards_overlay.dart';
import 'package:chero_key/Shared_Components/edit_flashcard_overlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chero_key/Flashcard/main_flashcard_screen.dart';
import 'package:chero_key/Shared_Components/loading_screen.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animations/loading_animations.dart';


//FIND ANOTHER WAY TO DO THIS!!!
List<Widget> _flashcards = List.empty();
bool _editMode = false;

//Class for the grid view
class FlashCardGridView extends StatefulWidget {
  static const String route = "/flashcard_grid_view";
  final String setID;
  final String setTitle;

  FlashCardGridView({
    Key key,
    @required this.setID,
    this.setTitle,
  }) : super(key: key);

  @override
  _FlashCardGridViewState createState() => _FlashCardGridViewState();
}

class _FlashCardGridViewState extends State<FlashCardGridView> {
  Widget _blueBookmarkIcon = Image(
    image:
        AssetImage('assets/images/flashcard_assets/mode_edit-white-48dp.png'),
    fit: BoxFit.contain,
  );

  //Function for creating a set object
  FlashCardSet _createFlashCardSet(
      String nameOfSet, int numCards, String setID) {
    return FlashCardSet(setID: setID, numCards: numCards, title: nameOfSet);
  }

  //Function for inserting the "+" card into the set of flashcards
  void _insertAddCard() {
    setState(() {
      _flashcards.insert(
        0,
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                PageRouteBuilder(
                    settings: RouteSettings(name: "/create_flashcard_overlay"),
                    opaque: false,
                    pageBuilder: (BuildContext context, _, __) {
                      return CreateFlashCardOverlay(
                        setID: widget.setID,
                      );
                    },
                    transitionsBuilder:
                        (___, Animation<double> animation, ____, Widget child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    })).whenComplete(() => setState(() {}));
          },
          //Card Image
          child: Container(
            width: 180,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/flashcard_assets/grid view flashcard card.png'),
                fit: BoxFit.contain,
              ),
            ),
            //Plus image
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  child: Image(
                    image: AssetImage(
                        'assets/images/flashcard_assets/add-black-48dp.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  //Function for removing the "+" card
  void _removeAddCard() {
    setState(() {
      _flashcards.removeAt(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5.0,
          sigmaY: 5.0,
        ),
        child: DefaultTextStyle.merge(
          style: TextStyle(fontFamily: null),
          child: Stack(
            children: [

              //Notebook (no paper)
              Center(
                child: Container(
                  width: 630,
                  child: Image(
                    image: AssetImage(
                        'assets/images/flashcard_assets/notebook (no paper).png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              //Red bookmark
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 212, left: 623),
                  child: Container(
                    width: 35,
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
                  padding: const EdgeInsets.only(bottom: 219, left: 627),
                  child: IconButton(
                    onPressed: () {
                      if (_editMode) {
                        _editMode = false;
                        _removeAddCard();
                        DBProvider.instance.updateSet(_createFlashCardSet(
                            "", _flashcards.length, widget.setID));
                        Navigator.maybePop(context);
                      } else {
                        DBProvider.instance.updateSet(_createFlashCardSet(
                            "", _flashcards.length, widget.setID));
                        Navigator.maybePop(context);
                      }
                    },
                    icon: Container(
                      width: 23,
                      child: Image(
                        image: AssetImage(
                            'assets/images/main_game_screen_assets/exit icon.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),

              //Blue bookmark for edit mode pencil
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 650, top: 155),
                  child: Container(
                    width: 58,
                    child: Image(
                      image: AssetImage(
                          'assets/images/flashcard_assets/confirm bookmark (no checkmark).png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              //Edit mode pencil on blue bookmark
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 655, top: 140),
                  child: IconButton(
                    iconSize: 10.0,
                    icon: Container(child: _blueBookmarkIcon),
                    onPressed: () {
                      setState(() {
                        if (_editMode) {
                          _editMode = false;
                        } else {
                          _editMode = true;
                        }
                        //Change the icon of the blue check mark
                        if (_editMode) {
                          _blueBookmarkIcon = Image(
                            image: AssetImage(
                                'assets/images/flashcard_assets/confirm check mark.png'),
                            fit: BoxFit.contain,
                          );
                          _insertAddCard();
                        } else {
                          _blueBookmarkIcon = Image(
                            image: AssetImage(
                                'assets/images/flashcard_assets/mode_edit-white-48dp.png'),
                            fit: BoxFit.contain,
                          );
                          _removeAddCard();
                          DBProvider.instance.updateSet(_createFlashCardSet(
                              "", _flashcards.length, widget.setID));
                        }
                      });
                    },
                  ),
                ),
              ),

              //Notebook paper
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Container(
                    width: 610,
                    child: Image(
                      image: AssetImage(
                          'assets/images/flashcard_assets/notebook paper.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              //Notebook top green ribbon
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, bottom: 298),
                  child: Container(
                    width: 227,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/flashcard_assets/notebook top ribbon.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                    //Text on top green ribbon
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20, left: 5),
                        child: Text(
                          widget.setTitle,
                          style:
                              TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Center(
                child: CardGridView(
                  setID: widget.setID,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Class for creating the grid view used by FlashCardGridView
class CardGridView extends StatefulWidget {
  final String setID;

  CardGridView({
    Key key,
    @required this.setID,
  }) : super(key: key);

  @override
  _CardGridViewState createState() => _CardGridViewState();
}

class _CardGridViewState extends State<CardGridView> {

  @override
  Widget build(BuildContext context) {
    //Future is a list of flashcards from the same set
    //Builder creates a list of flashcards, where each element has a gesture detector
    return FutureBuilder<List<FlashCard>>(
      future: DBProvider.instance.getFlashCards(widget.setID),
      builder: (BuildContext context, AsyncSnapshot<List<FlashCard>> snapshot) {
        if (snapshot.hasData) {
          if (_editMode) {

            _flashcards.replaceRange(
                1,
                _flashcards.length,
                (snapshot.data
                    .map((item) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                    settings: RouteSettings(name: "/edit_flashcard_overlay"),
                                    opaque: false,
                                    pageBuilder: (BuildContext context, _, __) {
                                      return EditFlashCardOverlay(
                                        setID: widget.setID,
                                        engTerm: item.engTerm,
                                        crkTerm: item.crkTerm,
                                        cardID: item.cardID,
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

                      //Cards
                      child: Stack(
                        children: [
                          //Card image
                          Container(
                            width: 180,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/flashcard_assets/grid view flashcard card.png'),
                                fit: BoxFit.contain,
                              ),
                            ),

                            //Text on the cards
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 5, left: 8),
                                child: Container(
                                  width: 70,
                                  child: Text(
                                    item.engTerm,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Roboto Black',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          //Delete icon
                          Positioned(
                            bottom: 82,
                            right: 2,
                            child: IconButton(
                              icon: Icon(Icons.delete),
                              iconSize: 12,
                              alignment: Alignment.center,
                              constraints: BoxConstraints(minWidth: 20, minHeight: 20),
                              onPressed: () {
                                return showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Discard Card?'),
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
                                                  .deleteFlashCardAt(
                                                      item.cardID);
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: Text('DISCARD'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList()));
          } else {
            //Non-editing mode
            _flashcards = (snapshot.data
                .map((item) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainFlashcardScreen(
                                    setID: item.setID,
                                    cardID: item.cardID,
                                    initialCardIndex: snapshot.data.indexWhere(
                                        (element) =>
                                            element.cardID == item.cardID))));
                      },

                      //Card image
                      child: Container(
                        width: 180,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/flashcard_assets/grid view flashcard card.png'),
                            fit: BoxFit.contain,
                          ),
                        ),

                        //Text on card
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 10, left: 8),
                            child: Container(
                              width: 70,
                              child: Text(
                                item.engTerm,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Roboto Black',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ))
                .toList());
          }

          //Returns a grid view
          return Center(
            child: Container(
              padding: const EdgeInsets.only(left: 7),
              width: 590,
              child: GridView.count(
                  key: UniqueKey(),
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(top: 100, bottom: 84),
                  shrinkWrap: true,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 11,
                  crossAxisCount: 2,
                  children: _flashcards
                  ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
