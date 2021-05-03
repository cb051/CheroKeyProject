import 'dart:ui';
import 'package:chero_key/Flashcard/Set_Selector_Screen.dart';
import 'package:flutter/material.dart';
import 'package:chero_key/Database_sqlite/database_helper.dart';
import 'package:chero_key/Shared_Components/textfield_overlay.dart';

//Class for creating a set
//Used by set select screen
class CreateSetOverlay extends StatefulWidget {
  static const route = '/create_set_overlay';

  @override
  _CreateSetOverlayState createState() => _CreateSetOverlayState();
}

class _CreateSetOverlayState extends State<CreateSetOverlay> {
  final _textFieldController = TextEditingController();
  bool _textBoxChanged = false;

  //Used to init the text field controller
  @override
  void initState() {
    super.initState();
    _textFieldController.addListener(() {
      _textBoxChanged = true;
    });
  }

  // Clean up the controller when the widget is disposed.
  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  //Function for creating a set object
  FlashCardSet _createFlashCardSet(String nameOfSet) {
    return FlashCardSet(
        setID: UniqueKey().toString(), numCards: 0, title: nameOfSet);
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
          child: Stack(
            alignment: Alignment.center,
            children: [
              //Notebook (no paper)
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 28),
                  child: Container(
                    width: 440,
                    child: Image(
                      image: AssetImage(
                          'assets/images/flashcard_assets/Small Notebook back.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              //Red bookmark
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 390),
                child: Center(
                  child: Container(
                    alignment: Alignment.topCenter,
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
              Padding(
                padding: const EdgeInsets.only(left: 395, top: 49),
                child: Center(
                  child: Container(
                    alignment: AlignmentDirectional.topCenter,
                    child: IconButton(
                      onPressed: () {
                        if (_textBoxChanged) {
                          return showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Container(
                                  width: 300,
                                  child: Text(
                                    'Are you sure you want to leave without saving?',
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('CANCEL'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.popUntil(
                                          context,
                                          ModalRoute.withName(
                                              SetSelectorScreen.route));
                                    },
                                    child: Text('LEAVE'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          Navigator.maybePop(context);
                        }
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
              ),

              //Blue bookmark for confirm check mark
              Padding(
                padding: const EdgeInsets.only(left: 413, bottom: 97),
                child: Center(
                  child: Container(
                    alignment: AlignmentDirectional.bottomCenter,
                    width: 58,
                    child: Image(
                      image: AssetImage(
                          'assets/images/flashcard_assets/confirm bookmark (no checkmark).png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              //Confirm check mark on blue bookmark
              Padding(
                padding: const EdgeInsets.only(left: 413, bottom: 110),
                child: Center(
                  child: Container(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: IconButton(
                      onPressed: () {
                        if (_textFieldController.text.isNotEmpty) {
                          if (_textBoxChanged) {
                            DBProvider.instance.insertFlashCardSet(
                                _createFlashCardSet(_textFieldController.text));
                          }
                          Navigator.maybePop(context);
                        } else {
                          if (_textFieldController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                    "Title field can't be empty!",
                                    textAlign: TextAlign.center,
                                  ),
                                  width: 200.0, // Width of the SnackBar.
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  )),
                            );
                          }
                        }
                      },
                      icon: Container(
                        width: 35,
                        child: Image(
                          image: AssetImage(
                              'assets/images/flashcard_assets/confirm check mark.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              //Main NoteBook paper
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: Container(
                  height: 390,
                  child: Image(
                    image: AssetImage(
                        'assets/images/flashcard_assets/Small Notebook paper.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              //Text on green title banner
              Padding(
                padding: const EdgeInsets.only(top: 35, left: 10),
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Create Set",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),

              //Notebook card
              Padding(
                padding: const EdgeInsets.only(right: 15, top: 50),
                child: Container(
                  height: 240,
                  child: Image(
                    image: new AssetImage(
                        'assets/images/flashcard_assets/main game screen card.png'),
                  ),
                ),
              ),

              //Textbox on notebook card
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, top: 40),
                  child: Container(
                    width: 260,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/flashcard_assets/Text box for creating flash cards.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                    child: TextField(
                      controller: _textFieldController,
                      textAlign: TextAlign.center,
                      maxLength: 15,
                      showCursor: false,
                      readOnly: true,
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              opaque: false,
                              pageBuilder: (BuildContext context, _, __) {
                                return TextFieldOverlay(
                                  textFieldController: _textFieldController,
                                  hintText: 'Title', textBoxMaxLength: 15,
                                );
                              },
                            ));
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Title',
                          counterText: "",
                          hintStyle:
                              TextStyle(color: Colors.black45, fontSize: 18)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
