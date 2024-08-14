
import 'package:json_annotation/json_annotation.dart';
part 'quiz_result_model.g.dart';
@JsonSerializable()
class QuizResult{
  int? id;
  @JsonKey(name: 'user')
  final int userId;
  @JsonKey(name: 'quiz')
  final int quizId;
  final double score;
  final int numOfCorrect;
   String? completionTime;

QuizResult({required this.userId, required this.quizId, required this.score, required this.numOfCorrect});

 factory QuizResult.fromJson(Map<String, dynamic>data)=> _$QuizResultFromJson(data);

  Map<String, dynamic> toJson()=> _$QuizResultToJson(this); 


}