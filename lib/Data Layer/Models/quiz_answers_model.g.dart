// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_answers_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizAnswers _$QuizAnswersFromJson(Map<String, dynamic> json) => QuizAnswers(
  answer: json['answer'] as String,
  isCorrect: json['isCorrect'] as bool,
);

Map<String, dynamic> _$QuizAnswersToJson(QuizAnswers instance) =>
    <String, dynamic>{
      'answer': instance.answer,
      'isCorrect': instance.isCorrect,
    };
