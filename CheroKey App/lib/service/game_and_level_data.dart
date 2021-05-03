/*
This is used to set/get all the information that was
previously done with constructors. This fix should
help with scalability.
*/

import 'package:flutter/material.dart';

class GameAndLevelData extends ChangeNotifier {
  String _worldInfo = "French Fries";
  String _colorPath = "assets/images/select_world_assets/category color3.png";
  String _iconPath = "assets/images/select_world_assets/category4.png";
  int _levelNumber = 0;
  int _questionNumber = 1;
  int correctAnswers = 0;
  int grade = 0;

  String _question = ""; // used for fill-in-the-blank/question-answer
  String _answer = ""; // used for fill-in-the-blank/question-answer
  List<Map> _otherAnswers = [
    {}
  ]; //used for other answer choices in fill-in-the-blank/question-answer

  int _widgetIndex = 0;
  List _questionAnswerCategoryInfo = [
    {
      "question": "",
      "incorrectAnswers": ["", "", ""],
      "correctAnswer": ""
    }
  ];

  List _mixAndMatchCategoryInfo = [
    {"cherokee": "", "english": ""}
  ];

  List<Widget> _gameIcons = List.filled(10, Container());

  // ==================== Getters and Setters ====================

  // GETTERS =========================================================

  String getWorldInfo() => _worldInfo;
  String getColorPath() => _colorPath;
  String getIconPath() => _iconPath;
  int getLevelNumber() => _levelNumber;
  int getQuestionNumber() => _questionNumber;
  int getCorrectAnswers() => correctAnswers;
  int getGrade() => grade;

  String getQuestion() => _question;
  String getAnswer() => _answer;
  List<Map> getOtherAnswers() => _otherAnswers;

  int getWidgetIndex() => _widgetIndex;

  List<Map> getQuestionAnswerCategoryInfo() => _questionAnswerCategoryInfo;

  List getMixAndMatchCategoryInfo() => _mixAndMatchCategoryInfo;

  List<Widget> getGameCounterIcons() => _gameIcons;

  // SETTERS =========================================================

  set setWorldInfo(String name) {
    // reset questions when a new world is chosen
    _questionAnswerCategoryInfo = []; 
    _mixAndMatchCategoryInfo = [];
    _worldInfo = name;
  }

  set setColorPath(String name) {
    _colorPath = name;
  }

  set setIconPath(String name) {
    _iconPath = name;
  }

  set setLevelNumber(int number) {
    _levelNumber = number;
  }

  set setQuestionNumber(int number) {
    _questionNumber = number;
  }

  set setQuestion(String q) {
    _question = q;
  }

  set setAnswer(String a) {
    _answer = a;
  }

  set setOtherAnswers(List<Map> a) {
    _otherAnswers = a;
  }

  set setQuestionAnswerCategoryInfo(List info) {
    _questionAnswerCategoryInfo = info;
  }

  set setMixAndMatchCategoryInfo(List info) {
    _mixAndMatchCategoryInfo = info;
  }

  set setCorrectAnswers(int number) {
    correctAnswers = number;
  }

  set setGrade(int number) {
    grade = number;
  }

  set setGameCounterIcon(Widget icon) {
    _gameIcons[_widgetIndex] = icon;
  }

  // MISC
  void newWidget() {
    _widgetIndex++; //get a new game widget
    _questionNumber++; //change question number
    notifyListeners();
  }

  void resetWidget() {
    _widgetIndex = 0;
    _questionNumber = 1;
    _gameIcons = List.filled(10, Container());
  }

  void resetCorrectAnswers() {
    grade = (correctAnswers / 10 * 100).toInt(); //sets final result percentage
    correctAnswers = 0; //resets correctAnswers
  }

  void incrementCorrectAnswers() {
    correctAnswers++; //increments correctAnswers
  }
}
