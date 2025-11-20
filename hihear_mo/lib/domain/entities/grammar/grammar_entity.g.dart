// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grammar_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GrammarEntity _$GrammarEntityFromJson(Map<String, dynamic> json) =>
    _GrammarEntity(
      id: json['id'] as String,
      question: json['question'] as String,
      answer: json['answer'] as String,
    );

Map<String, dynamic> _$GrammarEntityToJson(_GrammarEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'answer': instance.answer,
    };
