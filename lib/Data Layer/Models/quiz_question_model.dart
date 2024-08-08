import 'package:json_annotation/json_annotation.dart';
import 'package:lovelovelove/Data%20Layer/Models/quiz_answers_model.dart';

part'quiz_question_model.g.dart';


@JsonSerializable(explicitToJson: true)
class QuizQuestion{

  QuizQuestion({required this.choices, required this.questionText, required this.isLocked,this.selectedOption});

  @JsonKey(name: 'question_text')
  String questionText;
  List<QuizAnswers> choices;
  bool isLocked;
  QuizAnswers? selectedOption;



  factory QuizQuestion.fromJson(Map<String, dynamic>data)=> _$QuizQuestionFromJson(data);

  Map<String, dynamic> toJson()=> _$QuizQuestionToJson(this);  
}