// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quiz _$QuizFromJson(Map<String, dynamic> json) => Quiz(
      action: json['action'] == null
          ? null
          : AltrueAction.fromJson(json['action'] as Map<String, dynamic>),
      atrocity: json['atrocity'] == null
          ? null
          : Atrocity.fromJson(json['atrocity'] as Map<String, dynamic>),
      title: json['title'] as String,
      id: (json['id'] as num).toInt(),
      questions: (json['question'] as List<dynamic>)
          .map((e) => QuizQuestion.fromJson(e as Map<String, dynamic>))
          .toList(),
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QuizToJson(Quiz instance) => <String, dynamic>{
      'atrocity': instance.atrocity?.toJson(),
      'id': instance.id,
      'title': instance.title,
      'question': instance.questions.map((e) => e.toJson()).toList(),
      'action': instance.action?.toJson(),
      'category': instance.category?.toJson(),
    };
