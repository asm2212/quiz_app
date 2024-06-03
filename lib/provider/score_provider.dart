import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/model/score.dart';
import 'package:quiz_app/util/dbmanager.dart';

class ScoreProvider with ChangeNotifier {
  DbManger dbManger = DbManger();
  List<Score> arrScore = [];

  Future<Score> addScore(String nameUser, String categories, int score, String date, int totalAnswer, int totalQuestion) async {
    Score newScore = Score(
      nameUser: nameUser,
      categories: categories,
      score: score,
      date: date,
      totalAnswer: totalAnswer,
      totalQuestion: totalQuestion,
    );
    await dbManger.addUserScore(newScore);
    arrScore.add(newScore); // Update the list after adding the new score
    notifyListeners();
    return newScore;
  }

  Future<void> deleteScore(int id) async {
    await dbManger.deleteScore(id);
    arrScore.removeWhere((score) => score.id == id); // Update the list after deleting the score
    notifyListeners();
  }

  Future<List<Score>> getAllScore() async {
    arrScore = await dbManger.getUserScore();
    notifyListeners();
    return arrScore;
  }
}
