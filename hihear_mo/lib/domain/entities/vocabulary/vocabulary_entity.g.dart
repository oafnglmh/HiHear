// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vocabulary_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VocabularyEntity _$VocabularyEntityFromJson(Map<String, dynamic> json) =>
    _VocabularyEntity(
      id: json['id'] as String,
      question: json['question'] as String,
      choices: (json['choices'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      correctAnswer: json['correctAnswer'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$VocabularyEntityToJson(_VocabularyEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'choices': instance.choices,
      'correctAnswer': instance.correctAnswer,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
