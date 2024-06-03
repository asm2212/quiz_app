import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/model/question.dart';
import 'package:quiz_app/service/api_service.dart';

class QuestionProvider with ChangeNotifier {
  API_Service api = API_Service();
  List<Question> listQuestion = [];
  bool isLoading = false;
  String error = '';
  int currentIndex = 0;
  Map<int, dynamic> answer = {};

  QuestionProvider() {
    initValue();
  }

  void initValue() {
    api = API_Service();
    listQuestion = [];
    isLoading = false;
    error = '';
    currentIndex = 0;
    answer = {};
  }

  Future<List<Question>> getDataQuestion(String difficulty, int totalQuestion, int categoriesId) async {
    String url = "${api.baseURL}?amount=$totalQuestion&category=$categoriesId&difficulty=$difficulty";
    var dio = Dio();
    isLoading = true;
    notifyListeners();

    try {
      var res = await dio.get(url);
      if (res.statusCode == 200) {
        var jsonData = res.data;
        listQuestion = List<Question>.from(jsonData['results'].map((i) => Question.fromJson(i)));
      } else {
        error = "Failed to load data";
      }
    } on DioError catch (e) {
      error = e.message;
      print("Error: ${e.message}");
    } finally {
      isLoading = false;
      notifyListeners();
    }

    return listQuestion;
  }

  void selectRadio(dynamic e) {
    answer[currentIndex] = e;
    notifyListeners();
  }

  void selectQuestion(int index) {
    currentIndex = index;
    notifyListeners();
  }

  Future<void> submitQuiz(List<Question> listQuestion) async {
    if (currentIndex < (listQuestion.length - 1)) {
      currentIndex++;
    }
    notifyListeners();
  }

  void setLoading(bool status) {
    isLoading = status;
    notifyListeners();
  }
}
