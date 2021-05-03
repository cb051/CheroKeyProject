import 'package:chero_key/service/game_and_level_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FillInTheBlank extends StatefulWidget {
  @override
  _FillInTheBlankState createState() => _FillInTheBlankState();
}

class _FillInTheBlankState extends State<FillInTheBlank> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameAndLevelData>(builder: (context, data, child) {
      return Center(
        child: Column(
          children: [
            IconButton(
                color: Colors.amber[50],
                icon: Icon(Icons.arrow_back_rounded, size: 40.0),
                onPressed: () {
                  // Navigator.pop(context);
                  data.newWidget();
                }),
            Text(
              "Fill In The Blank",
              style: TextStyle(color: Colors.amber[50], fontSize: 30.0),
            )
          ],
        ),
      );
    });
  }
}
