// https://firebase.flutter.dev/docs/firestore/usage/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:chero_key/Shared_Components/add_data.dart';

class AddDataToFirebase extends StatefulWidget {
  static const String route = 'add_data';

  @override
  _AddDataToFirebaseState createState() => _AddDataToFirebaseState();
}

class _AddDataToFirebaseState extends State<AddDataToFirebase> {
  final CollectionReference questions =
      FirebaseFirestore.instance.collection('Questions_HowTheWorldWasMade');

  String questionNum;

  String question;

  String answer;

  List<String> categories;

  int difficulty;

  String note;

  Future<void> addInfo() {
    Map a = {
      'question': question,
      'answer': answer,
      'categories': categories,
      'difficulty': difficulty,
      'note': note,
    };
    print(a);
    print('button clicked');
    return questions
        .doc('$questionNum')
        .set({
          'question': question,
          'answer': answer,
          'categories': categories,
          'difficulty': difficulty,
          'note': note,
        })
        .then((value) => print("Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    categories = [];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          child: ListView(
            children: <Widget>[
              Text(
                'Add Data',
                style: TextStyle(fontSize: 20.0),
              ),
              //question num
              TextFormField(
                decoration: InputDecoration(hintText: 'question num'),
                onChanged: (String value) {
                  questionNum = value;
                },
              ),
              //question
              TextFormField(
                decoration: InputDecoration(hintText: 'question'),
                onChanged: (String value) {
                  question = value;
                },
              ),
              //answer
              TextFormField(
                decoration: InputDecoration(hintText: 'answer'),
                onChanged: (String value) {
                  answer = value;
                },
              ),
              // categories
              DropdownButton(
                value: 'mix-and-match',
                icon: Icon(Icons.arrow_circle_down),
                items: <String>[
                  'mix-and-match',
                  'question-answer',
                  'fill-in-the-blank'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String newValue) {
                  categories.add(newValue);
                  print(categories);
                },
              ),

              //difficulty
              TextFormField(
                decoration: InputDecoration(hintText: 'difficulty'),
                onChanged: (String value) {
                  difficulty = int.parse(value);
                },
              ),
              // note
              TextFormField(
                decoration: InputDecoration(hintText: 'note'),
                onChanged: (String value) {
                  note = value;
                },
              ),
              ElevatedButton(

                  child: Text('submit'),
                  onPressed: () {
                    print('button clicked');
                    addInfo();
                    Navigator.popAndPushNamed(context, AddDataToFirebase.route);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
