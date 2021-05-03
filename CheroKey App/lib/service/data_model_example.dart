import 'package:chero_key/service/our_data_model.dart';
import 'package:flutter/material.dart';

import 'dart:math';

import 'package:provider/provider.dart';
import 'package:chero_key/Shared_Components/loading_screen.dart';


class DataModelExample extends StatefulWidget {
  static String route = 'our_data_model';
  @override
  _DataModelExampleState createState() => _DataModelExampleState();
}

class _DataModelExampleState extends State<DataModelExample> {
  @override
  Widget build(BuildContext context) {
    return GeneralDataUseExample(); //This is an example for how to pull multiple
  }
}

//
class GeneralDataUseExample extends StatefulWidget {
  @override
  _GeneralDataUseExampleState createState() => _GeneralDataUseExampleState();
}

int _i = 0; //used to change question info
int _j = 0; //used to change random answer info

class _GeneralDataUseExampleState extends State<GeneralDataUseExample> {
  @override
  Widget build(BuildContext context) {
    return Consumer<OurDataModel>(builder: (context, info, child) {
      info.worldName =
          'HowTheWorldWasMade'; //set world. This tells data model which world to pull from

      /* 
      FutureBuilder widgets lets us display futures. This Future builder 
      lets us use data from two different collections: Question Info and 
      RandomAnswers.
      */
      return FutureBuilder(
        future: Future.wait([info.questionData, info.randomAnswers]),
        builder: (context, dataRetrievedFromDataModel) {
          if (dataRetrievedFromDataModel.hasData) {
            //initialize variables for questionInfo ==========
            var questionInfo = dataRetrievedFromDataModel.data[0];
            String question = questionInfo[_i]['question'];
            String answer = questionInfo[_i]['answer'];
            String note = questionInfo[_i]['note'];
            String categories = questionInfo[_i]['categories']
                .toString(); //originally stored as List/array
            String difficulty = questionInfo[_i]['difficulty']
                .toString(); //originally stored as int;
            //initialize variables for randomAnswers ==========
            var randomAnswers = dataRetrievedFromDataModel.data[1];
            String cherokee = randomAnswers[_j]['cherokee'];
            String english = randomAnswers[_j]['english'];
            // ================================================

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
                              'Question ${_i + 1} Info',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            Container(
                              height: 260.0,
                              width: 360.0,
                              color: Colors.white,
                              child: ListView(
                                padding: EdgeInsets.all(20.0),
                                children: [
                                  Text('question: $question'),
                                  Text('answer: $answer'),
                                  Text('categories: $categories'),
                                  Text('difficulty: $difficulty'),
                                  Text('note: $note'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10.0),
                        Column(
                          children: [
                            Text(
                              'Random Answers ${_j + 1}',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            Container(
                              color: Colors.white,
                              height: 160.0,
                              width: 360.0,
                              child: ListView(
                                children: [
                                  Text('cherokee: $cherokee'),
                                  Text('english: $english'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          //color: Colors.blue,
                          child: Text('next'),
                          onPressed: () {
                            // _i = 2;

                            setState(() {
                              _i = (_i + 1) % questionInfo.length;
                              _j = (_j + 1) % randomAnswers.length;
                            });
                          },
                        ),
                        SizedBox(
                          width: 30.0,
                        ),
                        ElevatedButton(
                          //color: Colors.teal.shade200,
                          child: Text('random'),
                          onPressed: () {
                            /* sets a random value to access random data to access question info and random answer data
                            */
                            var randomQA =
                                new Random().nextInt(questionInfo.length);
                            var randomA =
                                new Random().nextInt(randomAnswers.length);

                            setState(() {
                              _i = randomQA;
                              _j = randomA;
                            });
                            print('i: $_i');
                          },
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