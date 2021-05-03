import 'package:chero_key/service/story_entity.dart';
import 'package:flutter/material.dart';


import 'package:provider/provider.dart';
import 'package:chero_key/Shared_Components/loading_screen.dart';


class StoryTest extends StatefulWidget {
  static String route = 'story_entity';
  @override
  _StoryTest createState() => _StoryTest();
}

class _StoryTest extends State<StoryTest> {
  @override
  Widget build(BuildContext context) {
    return StoryEntityTest(); //This is an example for how to pull multiple
  }
}

class StoryEntityTest extends StatefulWidget {
  @override
  _StoryEntityTest createState() => _StoryEntityTest();
}

int _i = 0; //used to change question info
bool debug = false;

class _StoryEntityTest extends State<StoryEntityTest> {
  @override
  Widget build(BuildContext context) {
    return Consumer<StoryEntity>(builder: (context, info, child) {
      info.worldName =
          'HowTheWorldWasMade'; //set world. This tells data model which world to pull from

      return FutureBuilder(
        future: Future.wait([info.story]),
        builder: (context, dataRetrievedFromDataModel) {
          if (dataRetrievedFromDataModel.hasData) {
            //initialize
            var storyInfo = dataRetrievedFromDataModel.data[0];
            String text = storyInfo[_i]['text'];

            return Scaffold(
                backgroundColor: Colors.red.shade50,
                body: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Story ${_i + 1}',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            Container(
                              height: 260.0,
                              width: 560.0,
                              color: Colors.white,
                              child: ListView(
                                padding: EdgeInsets.all(20.0),
                                children: [Text('$text')],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RaisedButton(
                          color: Colors.blue,
                          child: Text('next'),
                          onPressed: () {
                            setState(() {
                              _i = (_i + 1) % storyInfo.length;
                            });
                          },
                        ),
                        SizedBox(
                          width: 30.0,
                        ),
                      ],
                    )
                  ],
                ));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      );
    });
  }
}
