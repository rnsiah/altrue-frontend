
import 'package:json_annotation/json_annotation.dart';
import 'package:lovelovelove/Data%20Layer/Models/category_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/quiz_question_model.dart';

import 'altrue_action_model.dart';
import 'atrocity_model.dart';
part 'quiz_model.g.dart';

@JsonSerializable(explicitToJson:true)
class Quiz{

  Atrocity? atrocity;
  int id;
  String title;
  @JsonKey(name:'question')
  List <QuizQuestion> questions;
  AltrueAction? action;
  Category? category;

  Quiz({required this.action, required this.atrocity, required this.title,required this.id, required this.questions, required this.category });

  factory Quiz.fromJson(Map<String, dynamic>data)=>_$QuizFromJson(data);

  Map<String, dynamic>toJson()=> _$QuizToJson(this);


}