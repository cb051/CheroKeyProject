import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StoryEntity extends ChangeNotifier {
  String _world =
      ''; //This variable is set in DataModelExample and used to choose which info to get from firebase
  // Future _info; //a possible setter method to set question info

  Future _getStory(String worldName) async {
    CollectionReference collectionReference = FirebaseFirestore.instance.collection(
        'Stories_$worldName'); // return an empty list if world name isn't correct
    List<Map> a = [
      {
        'story': 'empty',
      }
    ];
    try {
      // var docSnapshot = await collectionReference.get();
      // if (docSnapshot.docs.isNotEmpty) {
      //   List<String> storyList = <String>[];
      //   docSnapshot.docs.map((DocumentSnapshot doc) {
      //     storyList.add(doc.data().values.toString());
      //   }).toList();
      //   return storyList;
      // }

      var docSnapshot = await collectionReference.get();
      if (docSnapshot.docs.isNotEmpty) {
        List storyList = [];
        docSnapshot.docs.forEach((document) {
          storyList.add(document.get('story'));
        });
        return storyList;
      }
    } catch (e) {
      print('ERROR: $e');
      return a;
    }
  }

  // ==================== Getters and Setters ====================
  //  Use String world to set world type and not the function below
  // set questionData(Future<List<Map>> world) {R
  //   _info = world;
  // }

  Future get story => _getStory(_world);

  set worldName(String name) {
    _world = name;
  }
}
