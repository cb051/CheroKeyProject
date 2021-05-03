import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OurDataModel extends ChangeNotifier {
  String _world = ''; //This variable is set in DataModelExample and used to choose which info to get from firebase
  // Future _info; //a possible setter method to set question info 

  Future _getQuestionInfo(String worldName) async {
    // worldName = 'Questions_HowTheWorldWasMade';
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('Questions_$worldName');
        // return an empty list if world name isn't correct
            List<Map> a = [
          {
            'question': 'empty',
            'answer': 'empty',
            'categories': '[empty]',
            'difficulty': 0,
            'note': 'empty'
          }
        ];
    try {
      var docSnapshot = await collectionReference.get();
      if (docSnapshot.docs.isNotEmpty) {
        List questionsList = [];
        docSnapshot.docs.forEach((doc) => {
           questionsList.add(doc.data())
        });
        return questionsList;
      }
    } catch (e) {
      print('ERROR: $e');
      return a;
    }
  }

Future _getRandomAnswers(String worldName) async {
  CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('RandomAnswers_$worldName');
    try {
      var docSnapshot = await collectionReference.get();
      if (docSnapshot.docs.isNotEmpty) {
        List questionsList = [];
        docSnapshot.docs.forEach((doc) => {
           questionsList.add(doc.data())
        });
        return questionsList;
      }
    } catch (e) {
      print('ERROR in our_data_model.dart: $e');
      return {'cherokee': 'empty', 'english': 'empty' };
    }
}
  // ==================== Getters and Setters ====================
  //  Use String world to set world type and not the function below
  // set questionData(Future<List<Map>> world) {
  //   _info = world;
  // }

  Future get questionData => _getQuestionInfo(_world);
  Future get randomAnswers => _getRandomAnswers(_world);

  set worldName(String name) {
    _world = name;
  }
}
