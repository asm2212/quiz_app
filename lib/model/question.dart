class Question {
  String category;
  String type;
  String difficulty;
  String question;
  String correctAnswer;
  List<String> incorrectAnswers;

  Question({
    required this.category,
    required this.type,
    required this.difficulty,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  Question.fromJson(Map<String, dynamic> json)
      : category = json['category'],
        type = json['type'],
        difficulty = json['difficulty'],
        question = json['question'],
        correctAnswer = json['correct_answer'],
        incorrectAnswers = List<String>.from(json['incorrect_answers']);

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'type': type,
      'difficulty': difficulty,
      'question': question,
      'correct_answer': correctAnswer,
      'incorrect_answers': incorrectAnswers,
    };
  }
}
