import 'dart:ui';
import 'package:flutter/material.dart';

//Class for text boxes
//Used by create/edit flashcard overlays as well as the create set overlay
class TextFieldOverlay extends StatefulWidget {
  static const route = 'create_flashcard_overlay';
  final TextEditingController textFieldController;
  final String hintText;
  final int textBoxMaxLength;

  TextFieldOverlay({Key key, this.textFieldController, this.hintText, this.textBoxMaxLength})
      : super(key: key);

  @override
  _TextFieldOverlayState createState() => _TextFieldOverlayState();
}

class _TextFieldOverlayState extends State<TextFieldOverlay> {
  bool _textLongerThan23Chars = false;
  int _textBoxMaxLength = 150;

  @override
  void initState() {
    if(widget.textBoxMaxLength != null) {
      _textBoxMaxLength = widget.textBoxMaxLength;
    }

    if(widget.textFieldController.text.length > 23){
      _textLongerThan23Chars = true;
    }
    else{
      _textLongerThan23Chars = false;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(alignment: Alignment.topCenter, children: [
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5.0,
            sigmaY: 5.0,
          ),
          child: Container(color: Colors.black.withOpacity(0)),
        ),

        //Outer image for text box
        Padding(
          padding: const EdgeInsets.only(top: 73),
          child: AnimatedContainer(
            width: 260,
            height: _textLongerThan23Chars ? 100.0 : 50,
            duration: Duration(seconds: 1),
            child: Image(
              image: AssetImage(
                  'assets/images/flashcard_assets/Outer box of textbox.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),

        //Inner image for text box
        Padding(
          padding: const EdgeInsets.only(top: 72),
          child: AnimatedContainer(
            padding: EdgeInsets.all(8.0),
            width: 260,
            height: _textLongerThan23Chars ? 100.0 : 50,
            duration: Duration(seconds: 1),
            child: Image(
              image: AssetImage(
                  'assets/images/flashcard_assets/Inner box of textbox.png'),
              alignment: Alignment.centerLeft,
              fit: BoxFit.cover,
            ),
          ),
        ),

        //Text in text box
        Padding(
          padding: const EdgeInsets.only(top: 77),
          child: Container(
            width: 260,
            height: _textLongerThan23Chars ? 100.0 : 50,
            child: TextField(
              controller: widget.textFieldController,
              expands: true,
              textAlign: TextAlign.start,
              maxLength: _textBoxMaxLength,
              maxLines: null,
              minLines: null,
              autofocus: true,
              onChanged: (String input) {
                if (input.length > 23) {
                  setState(() {
                    _textLongerThan23Chars = true;
                  });
                } else {
                  setState(() {
                    _textLongerThan23Chars = false;
                  });
                }
              },
              onSubmitted: (value) {
                Navigator.maybePop(context);
              },
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: 16, right: 10, top: 8, bottom: 10),
                  border: InputBorder.none,
                  hintText: widget.hintText,
                  counterText: "",
                  hintStyle: TextStyle(color: Colors.black45, fontSize: 18)),
              textInputAction: TextInputAction.done,
            ),
          ),
        ),
      ]),
    );
  }
}
