// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grammar_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GrammarEntity _$GrammarEntityFromJson(Map<String, dynamic> json) =>
    _GrammarEntity(
      id: json['id'] as String,
      grammarRule: json['grammarRule'] as String,
      example: json['example'] as String,
      meaning: json['meaning'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$GrammarEntityToJson(_GrammarEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'grammarRule': instance.grammarRule,
      'example': instance.example,
      'meaning': instance.meaning,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
