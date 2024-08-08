

import 'package:json_annotation/json_annotation.dart';
part 'quiz_answers_model.g.dart';

@JsonSerializable()
class QuizAnswers{
  String answer;
  bool isCorrect;

  QuizAnswers({required this.answer, required this.isCorrect
  });

  factory QuizAnswers.fromJson(Map<String, dynamic> data)=> _$QuizAnswersFromJson(data);

  Map<String, dynamic> toJson()=> _$QuizAnswersToJson(this);
}