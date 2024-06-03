class Score {
  int id;
  String nameUser;
  String categories;
  int score;
  String date;
  int totalAnswer;
  int totalQuestion;

  Score({
    required this.id,
    required this.nameUser,
    required this.categories,
    required this.score,
    required this.date,
    required this.totalAnswer,
    required this.totalQuestion,
  });

  Score.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nameUser = json['nameUser'],
        categories = json['categories'],
        score = json['score'],
        date = json['date'],
        totalAnswer = json['totalAnswer'],
        totalQuestion = json['totalQuestion'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameUser': nameUser,
      'categories': categories,
      'score': score,
      'date': date,
      'totalAnswer': totalAnswer,
      'totalQuestion': totalQuestion,
    };
  }
}
