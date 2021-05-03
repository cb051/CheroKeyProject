import 'dart:ui';
import 'package:chero_key/Shared_Components/flashcard_grid_view.dart';
import 'package:chero_key/Shared_Components/textfield_overlay.dart';
import 'package:chero_key/Database_sqlite/database_helper.dart';
import 'package:flutter/material.dart';

//Class for editing a flashcard
//Used by grid view
class EditFlashCardOverlay extends StatefulWidget {
  static const route = '/edit_flashcard_overlay';
  final String setID;
  final String cardID;
  final String engTerm;
  final String crkTerm;

  EditFlashCardOverlay({
    Key key,
    @required this.setID,
    this.engTerm,
    this.crkTerm,
    this.cardID,
  }) : super(key: key);

  @override
  _EditFlashCardOverlayState createState() => _EditFlashCardOverlayState();
}

class _EditFlashCardOverlayState extends State<EditFlashCardOverlay> {
  TextEditingController _engTextFieldController;
  TextEditingController _crkTextFieldController;
  bool _textBoxChanged = false;

  // Clean up the controller when the widget is disposed.
  @override
  void dispose() {
    _engTextFieldController.dispose();
    _crkTextFieldController.dispose();
    super.dispose();
  }

  //This sets the initial value of the text fields
  @override
  void initState() {
    super.initState();
    if (widget.crkTerm != null || widget.engTerm != null) {
      _engTextFieldController = TextEditingController.fromValue(
          TextEditingValue(text: widget.engTerm));
      _crkTextFieldController = TextEditingController.fromValue(
          TextEditingValue(text: widget.crkTerm));
    } else {
      _engTextFieldController = TextEditingController();
      _crkTextFieldController = TextEditingController();
    }
    _engTextFieldController.addListener(() {
      _textBoxChanged = true;
    });
    _crkTextFieldController.addListener(() {
      _textBoxChanged = true;
    });
  }

  //Creates a flashcard object
  FlashCard _createFlashCard(String engTerm, String crkTerm, String cardID) {
    return FlashCard(
        setID: widget.setID,
        cardID: cardID,
        engTerm: engTerm,
        crkTerm: crkTerm);
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

            //Main NoteBook back
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
                      if(_textBoxChanged) {
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
                                            FlashCardGridView.route));
                                  },
                                  child: Text('LEAVE'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                      else{
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
                      if (_engTextFieldController.text.isNotEmpty && _crkTextFieldController.text.isNotEmpty) {
                        if(_textBoxChanged) {
                          DBProvider.instance.updateFlashCard(_createFlashCard(
                              _engTextFieldController.text,
                              _crkTextFieldController.text,
                              widget.cardID));
                        }
                        Navigator.maybePop(context);
                      } else {
                        if(_engTextFieldController.text.isEmpty && _crkTextFieldController.text.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text("Cherokee and English fields can't be empty!",
                                  textAlign: TextAlign.center,
                                ),

                                width: 301.0, // Width of the SnackBar.
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                )),
                          );
                        }
                        else if(_crkTextFieldController.text.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text("Cherokee field can't be empty!",
                                  textAlign: TextAlign.center,
                                ),
                                width: 218.0, // Width of the SnackBar.
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                )),
                          );
                        }
                        else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text("English field can't be empty!",
                                  textAlign: TextAlign.center,
                                ),
                                width: 218.0, // Width of the SnackBar.
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
                  "Editing Flashcard",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
            ),

            //Notebook card
            Padding(
              padding: const EdgeInsets.only(right: 20, top: 40),
              child: Container(
                height: 240,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image(
                      image: AssetImage(
                          'assets/images/flashcard_assets/main game screen card.png'),
                    ),

                    //Textboxes on notebook card
                    //English text box
                    Padding(
                      padding: const EdgeInsets.only(top: 60, left: 20),
                      child: Container(
                        alignment: Alignment.topCenter,
                        width: 260,
                        child: Image(
                          image: AssetImage(
                              'assets/images/flashcard_assets/Text box for creating flash cards.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    //Text in the text box
                    Padding(
                      padding: const EdgeInsets.only(top: 57, left: 16),
                      child: Container(
                        alignment: Alignment.topCenter,
                        width: 230,
                        child: TextField(
                          controller: _engTextFieldController,
                          textAlign: TextAlign.center,
                          maxLength: 15,
                          readOnly: true,
                          onTap: () {
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                    opaque: false,
                                    pageBuilder: (BuildContext context, _, __) {
                                      return TextFieldOverlay(
                                          textFieldController:
                                          _engTextFieldController,
                                          hintText: 'English');
                                    },
                                    transitionsBuilder: (___,
                                        Animation<double> animation,
                                        ____,
                                        Widget child) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    }));
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'English',
                              counterText: "",
                              hintStyle: TextStyle(
                                  color: Colors.black45, fontSize: 18)),
                        ),
                      ),
                    ),

                    //Cherokee text box
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Container(
                        width: 260,
                        child: Image(
                          image: AssetImage(
                              'assets/images/flashcard_assets/Text box for creating flash cards.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    //Text in the text box
                    Padding(
                      padding: const EdgeInsets.only(left: 16, top: 18),
                      child: Container(
                        width: 230,
                        child: TextField(
                          controller: _crkTextFieldController,
                          textAlign: TextAlign.center,
                          maxLength: 15,
                          readOnly: true,
                          onTap: () {
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                  opaque: false,
                                  pageBuilder: (BuildContext context, _, __) {
                                    return TextFieldOverlay(
                                        textFieldController:
                                        _crkTextFieldController,
                                        hintText: 'Cherokee');
                                  },
                                  transitionsBuilder: (___,
                                      Animation<double> animation,
                                      ____,
                                      Widget child) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                                ));
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Cherokee',
                              counterText: "",
                              hintStyle: TextStyle(
                                  color: Colors.black45, fontSize: 18)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
