// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizQuestion _$QuizQuestionFromJson(Map<String, dynamic> json) => QuizQuestion(
      choices: (json['choices'] as List<dynamic>)
          .map((e) => QuizAnswers.fromJson(e as Map<String, dynamic>))
          .toList(),
      questionText: json['question_text'] as String,
      isLocked: json['isLocked'] as bool,
      selectedOption: json['selectedOption'] == null
          ? null
          : QuizAnswers.fromJson(
              json['selectedOption'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QuizQuestionToJson(QuizQuestion instance) =>
    <String, dynamic>{
      'question_text': instance.questionText,
      'choices': instance.choices.map((e) => e.toJson()).toList(),
      'isLocked': instance.isLocked,
      'selectedOption': instance.selectedOption?.toJson(),
    };
