// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizResult _$QuizResultFromJson(Map<String, dynamic> json) => QuizResult(
      userId: (json['user'] as num).toInt(),
      quizId: (json['quiz'] as num).toInt(),
      score: (json['score'] as num).toDouble(),
      numOfCorrect: (json['num_correct'] as num).toInt(),
    )
      ..id = (json['id'] as num?)?.toInt()
      ..completionTime = json['completionTime'] as String?;

Map<String, dynamic> _$QuizResultToJson(QuizResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.userId,
      'quiz': instance.quizId,
      'score': instance.score,
      'num_correct': instance.numOfCorrect,
      'completionTime': instance.completionTime,
    };
